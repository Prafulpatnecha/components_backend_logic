import 'dart:html' as html;
import 'dart:io';
String userAgent = html.window.navigator.userAgent.toLowerCase();

bool isMobileBrowser = userAgent.contains("iphone") ||
                       userAgent.contains("android") ||
                       userAgent.contains("ipad");

bool isDesktopBrowser = !isMobileBrowser;



// -------------------------------------------------------------------------------------------------------------

// void funtion() {
  
// if (kIsWeb) {
//   if (isMobileBrowser) {
//     print("Running on mobile browser");
//   } else {
//     print("Running on desktop browser");
//   }
// } else if (Platform.isAndroid) {
//   print("Android App");
// } else if (Platform.isIOS) {
//   print("iOS App");
// }

// }