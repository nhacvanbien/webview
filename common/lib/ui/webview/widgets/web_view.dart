import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../web_view_cubit.dart';

class WebView extends StatefulWidget {
  const WebView({Key? key}) : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late InAppWebViewController webViewController;
  late WebViewCubit webViewCubit;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
  );

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
  }

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
                window.flutter_inappwebview.callHandler('Native', "RMRPlugin", 'testFunction1', "String123")
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

  _initWebViewController(
    InAppWebViewController controller,
    BuildContext context,
  ) {
    webViewController = controller;
    webViewCubit = BlocProvider.of<WebViewCubit>(context);
    webViewCubit.addJavaScriptHandler(webViewController);
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialOptions: options,
      initialData: InAppWebViewInitialData(data: _webViewData),
      onWebViewCreated: (controller) async {
        _initWebViewController(controller, context);
      },
      onConsoleMessage: (controller, consoleMessage) {
        debugPrint(consoleMessage.message);
      },
    );
  }
}
