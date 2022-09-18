import 'dart:collection';

abstract class JsPlugin {
  /// this field store all methods of a JsPlugin instance
  Map<String, Function> functionLists = HashMap();

  JsPlugin() {
    initFunctionList();
  }

  /// get plugin name of concrete JSPlugin
  String getPluginName() {
    return runtimeType.toString();
  }

  /// template method which init all functions of concrete JSPlugin,
  /// all concrete classes have to implement this function
  void initFunctionList();
}
