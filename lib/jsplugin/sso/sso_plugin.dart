import '../js_plugin.dart';

@reflector
class SSOPlugin extends JsPlugin {
  @override
  String getPluginName() {
    return "SSOPlugin";
  }

  dynamic testFunction(String param){
    return param;
  }
}