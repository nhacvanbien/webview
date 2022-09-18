import 'dart:collection';

import 'package:reflectable/mirrors.dart';
import 'package:webview/jsplugin/js_result.dart';
import 'package:webview/jsplugin/js_plugin.dart';
import 'package:webview/jsplugin/sso/sso_plugin.dart';

import '../main.reflectable.dart';

class JSPluginManager {
  HashMap<String, JsPlugin> plugins = HashMap();

  JSPluginManager(){
    initializeReflectable();
  }
  setupPlugins() {
    var ssoPlugin = SSOPlugin();
    plugins[ssoPlugin.getPluginName()] = ssoPlugin;
  }

  JsPlugin? _getPlugin(String name) {
    return plugins[name];
  }

  JsResult dispatchAction(String pluginName, String method, dynamic arg) {
    try {
      final jsPlugin = _getPlugin(pluginName);
      if (jsPlugin != null) {
        InstanceMirror instanceMirror = reflector.reflect(jsPlugin);
        return JsResult.success(0, instanceMirror.invoke(method, [arg]));
      }
      return JsResult.error(-1, "Plugin $pluginName not found!");
    } catch (e) {
      return JsResult.error(-1, e.toString());
    }
  }
}
