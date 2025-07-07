import 'dart:html' as html;
String userAgent = html.window.navigator.userAgent.toLowerCase();

bool isMobileBrowser = userAgent.contains("iphone") ||
                       userAgent.contains("android") ||
                       userAgent.contains("ipad");

bool isDesktopBrowser = !isMobileBrowser;


// -------------------------------------------------------------------------------------------------------------

/* todo
this funtion was also working . not any error found here.

    void funtion() {
    
        if (kIsWeb) {
          if (isMobileBrowser) {
            print("Running on mobile browser");
          } else {
            print("Running on desktop browser");
          }
        } else if (Platform.isAndroid) {
          print("Android App");
        } else if (Platform.isIOS) {
          print("iOS App");
        }

    }

todo */