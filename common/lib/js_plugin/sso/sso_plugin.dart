import 'package:common/js_plugin/js_result.dart';

import '../js_plugin.dart';
class SSOPlugin extends JsPlugin {

  JsResult testFunction(String param){
    return JsResult.success(1, param);
  }

  @override
  void initFunctionList() {
    functionLists["testFunction"] =  testFunction;
  }

}