# In-App APK Update Documentation

This document explains the changes made to the Flutter project to support downloading and installing an APK directly from within the app, without redirecting to an external browser (like Chrome).

You can share this document with your team so they understand exactly what was added and where.

---

## 1. Packages Added
**File Path:** `pubspec.yaml`

To implement this feature, we added 4 new packages to your Flutter project. You can find them under your `dependencies:` section in `pubspec.yaml` (installed automatically via `flutter pub add`):

- **`dio`**: Used to download the `.apk` file from the URL. It is very reliable for handling file downloads and getting download progress.
- **`path_provider`**: Used to securely find the Android device's local storage directory so we can save the downloaded APK file.
- **`open_filex`**: Used to "open" the `.apk` file after downloading. Opening an APK automatically triggers Android's built-in app installer.
- **`permission_handler`**: Used to ask the user/device for permission to install apps (if required by Android).

---

## 2. Android Permissions
**File Path:** `android/app/src/main/AndroidManifest.xml`

Android requires explicit permissions to install an application and read/write storage. The following lines were added inside the `<manifest>` tag, right before the `<application>` tag:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```
*Note: `REQUEST_INSTALL_PACKAGES` is the most important permission here as it allows the app to prompt the system installer.*

---

## 3. Flutter Code Implementation
**File Path:** `lib/main.dart`

### A. New Imports
We added the necessary imports at the very top of `main.dart` so we can use the downloaded packages:

```dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
```

### B. The Download and Install Logic
Inside the `_AppCheckState` class, we added the state variables and the core function `downloadAndInstallApk()`. 

**What this function does:**
1. Requests permission to install packages.
2. Finds the device's external storage directory.
3. Uses `Dio()` to download the APK from `https://prafulpatnecha.omgcreation.in/apk/app-release.apk` and tracks the download progress percentage.
4. Uses `OpenFilex.open()` to run the downloaded APK and show the installation screen.

```dart
class _AppCheckState extends State<AppCheck> {
  double progress = 0;
  bool isDownloading = false;

  Future<void> downloadAndInstallApk() async {
    setState(() {
      isDownloading = true;
      progress = 0;
    });

    try {
      // 1. Request Install Permission
      if (await Permission.requestInstallPackages.isDenied) {
        await Permission.requestInstallPackages.request();
      }

      // 2. Get the storage directory
      Directory? dir = await getExternalStorageDirectory();
      String savePath = "${dir!.path}/app-update.apk";

      // 3. Download the APK
      Dio dio = Dio();
      await dio.download(
        "https://prafulpatnecha.omgcreation.in/apk/app-release.apk",
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              progress = received / total; // Update UI progress
            });
          }
        },
      );

      // 4. Open the APK to install
      final result = await OpenFilex.open(savePath);
      print("Open result: ${result.message}");
      
    } catch (e) {
      print("Error downloading or installing: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    } finally {
      if (mounted) {
        setState(() {
          isDownloading = false;
        });
      }
    }
  }
```

### C. UI Integration
In the same `_AppCheckState` class, inside the `build()` method, we updated the UI to show a **Button** to start the update. While downloading, it swaps the button with a **CircularProgressIndicator** and text showing the download percentage.

```dart
child: Center(
  child: isDownloading
      ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(value: progress, color: Colors.white),
            const SizedBox(height: 20),
            Text(
              "Downloading Update... ${(progress * 100).toStringAsFixed(1)}%",
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        )
      : ElevatedButton.icon(
          onPressed: downloadAndInstallApk,
          icon: const Icon(Icons.download),
          label: const Text("Download & Install Update"),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
),
```

---
**Summary:** You now have a complete, secure, and native in-app updater. No external browser is opened during the process.
