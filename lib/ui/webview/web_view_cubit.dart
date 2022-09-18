import 'package:bloc/bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:meta/meta.dart';
import 'package:webview/jsplugin/js_result.dart';

import '../../jsplugin/js_plugin_manager.dart';

part 'web_view_state.dart';

class WebViewCubit extends Cubit<WebViewState> {
  static const _javaScriptHandlerName = "Native";
  static late JSPluginManager jsPluginManager;

  static void addJavaScriptHandler(InAppWebViewController controller) {
    controller.addJavaScriptHandler(
        handlerName: _javaScriptHandlerName,
        callback: (args) {
          //extract param from javascript side
          final String pluginName  = args[0];
          final String methodName  = args[1];
          final dynamic params = args[2];
          print("$pluginName.$methodName($params)");
          jsPluginManager = JSPluginManager();
          jsPluginManager.setupPlugins();
          JsResult result =  jsPluginManager.dispatchAction(pluginName, methodName, params);
          return result.toJson();
        });
  }

  WebViewCubit() : super(WebViewInitial());
}
