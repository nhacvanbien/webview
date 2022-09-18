import 'package:common/js_plugin/js_plugin_manager.dart';
import 'package:webview/rmr/jsplugin/rmr_plugin.dart';

import '../common_main.dart';

void initAppJsPlugin() {
  //add your custom JSPlugin
  JSPluginManager.instance.addPlugin(RMRPlugin());
}

void main() {
  initAppJsPlugin();
  commonMain();
}
