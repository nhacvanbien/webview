import 'package:reflectable/reflectable.dart';

class Reflector extends Reflectable {
  const Reflector()
      : super(
          invokingCapability,
          typeCapability,
        );
}

const reflector = Reflector();

abstract class JsPlugin {
  String getPluginName();
}
