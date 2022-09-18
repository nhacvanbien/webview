import 'dart:collection';

import 'package:common/js_plugin/sso/sso_plugin.dart';

import 'js_plugin.dart';
import 'js_result.dart';

class JSPluginManager {
  static final JSPluginManager _instance = JSPluginManager._();

  static JSPluginManager get instance => _instance;

  JSPluginManager._();

  HashMap<String, JsPlugin> plugins = HashMap();

  ///init all required plugins
  setupPlugins() {
    var ssoPlugin = SSOPlugin();
    plugins[ssoPlugin.getPluginName()] = ssoPlugin;
  }

  /// get a [JsPlugin] by [name]
  JsPlugin? _getPlugin(String name) {
    return plugins[name];
  }

  ///add a [JsPlugin]
  void addPlugin(JsPlugin plugin) {
    plugins[plugin.getPluginName()] = plugin;
  }

  ///dispatch [api] of plugin [pluginName] with argument [arg]
  JsResult dispatchApi(String pluginName, String api, dynamic arg) {
    try {
      final jsPlugin = _getPlugin(pluginName);
      if (jsPlugin == null) {
        return JsResult.error(-1, "Plugin $pluginName not found!");
      }
      if (jsPlugin.functionLists[api] == null) {
        return JsResult.error(
            -1, "Api  $api of the plugin $pluginName not found!");
      }
      return JsResult.success(0, jsPlugin.functionLists[api]?.call(arg));
    } catch (e) {
      return JsResult.error(-1, e.toString());
    }
  }
}
