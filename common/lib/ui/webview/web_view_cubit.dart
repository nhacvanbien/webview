import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../js_plugin/js_plugin_manager.dart';
import '../../js_plugin/js_result.dart';

part 'web_view_state.dart';

class WebViewCubit extends Cubit<WebViewState> {
  static const _javaScriptHandlerName = "Native";
  JSPluginManager jsPluginManager = JSPluginManager.instance;

  void addJavaScriptHandler(InAppWebViewController controller) {
    controller.addJavaScriptHandler(
      handlerName: _javaScriptHandlerName,
      callback: (args) {
        //extract params from javascript side
        final String pluginName = args[0];
        final String methodName = args[1];
        final dynamic params = args[2];
        debugPrint("$pluginName.$methodName($params)");
        JsResult result = jsPluginManager.dispatchApi(
          pluginName,
          methodName,
          params,
        );
        return result.toJson();
      },
    );
  }

  WebViewCubit() : super(WebViewInitial()) {
    JSPluginManager.instance.setupPlugins();
  }
}
