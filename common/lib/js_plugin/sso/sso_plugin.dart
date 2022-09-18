import '../js_plugin.dart';

class SSOPlugin extends JsPlugin {
  String testFunction(String param) {
    return param;
  }

  @override
  void initFunctionList() {
    functionLists["testFunction"] = testFunction;
  }
}
