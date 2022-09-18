import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview/ui/webview/web_view_cubit.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late InAppWebViewController webViewController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
  );

  final String _webViewData = """
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    </head>
    <body>
        <h1>JavaScript Handlers1</h1>
        <script>
            window.addEventListener("flutterInAppWebViewPlatformReady", function(event) {
                window.flutter_inappwebview.callHandler('Native', "SSOPlugin", 'testFunction', "String123")
                  .then(function(result) {
                    // print to the console the data coming
                    // from the Flutter side.
                    console.log(JSON.stringify(result));
                    
                    // window.flutter_inappwebview
                    //   .callHandler('handlerFooWithArgs', 1, true, ['bar', 5], {foo: 'baz'}, result);
                });
            });
        </script>
    </body>
</html>
                      """;

  @override
  void initState() {
    if (Platform.isAndroid) {
      AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    super.initState();
  }

  _initWebViewController(InAppWebViewController controller) {
    webViewController = controller;
    WebViewCubit.addJavaScriptHandler(webViewController);
  }

  _requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    // Map<Permission, PermissionStatus> status = await [Permission.storage, Permission.notification, Permission.phone].request();
    debugPrint(status.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: InAppWebView(
                initialData: InAppWebViewInitialData(data: _webViewData),
                initialOptions: options,
                onWebViewCreated: (controller) async {
                  _requestPermission();
                  // Map<Permission, PermissionStatus> status = await [Permission.storage, Permission.notification, Permission.phone].request();
                  // debugPrint(status.toString());
                  _initWebViewController(controller);
                },
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
