// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.
// @dart = 2.12

import 'dart:core';
import 'package:webview/jsplugin/js_plugin.dart' as prefix0;
import 'package:webview/jsplugin/sso/sso_plugin.dart' as prefix1;

// ignore_for_file: camel_case_types
// ignore_for_file: implementation_imports
// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const

// ignore:unused_import
import 'package:reflectable/mirrors.dart' as m;
// ignore:unused_import
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
// ignore:unused_import
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{
  const prefix0.Reflector(): r.ReflectorData(
      <m.TypeMirror>[
        r.NonGenericClassMirrorImpl(
            r'SSOPlugin',
            r'.SSOPlugin',
            134217735,
            0,
            const prefix0.Reflector(),
            const <int>[-1],
            null,
            null,
            -1,
            {},
            {},
            {r'': (bool b) => () => b ? prefix1.SSOPlugin() : null},
            -1,
            -1,
            const <int>[-1],
            null,
            {
              r'==': 1,
              r'toString': 0,
              r'noSuchMethod': 1,
              r'hashCode': 0,
              r'runtimeType': 0,
              r'getPluginName': 0,
              r'testFunction': 1
            })
      ],
      null,
      null,
      <Type>[prefix1.SSOPlugin],
      1,
      {
        r'==': (dynamic instance) => (x) => instance == x,
        r'toString': (dynamic instance) => instance.toString,
        r'noSuchMethod': (dynamic instance) => instance.noSuchMethod,
        r'hashCode': (dynamic instance) => instance.hashCode,
        r'runtimeType': (dynamic instance) => instance.runtimeType,
        r'getPluginName': (dynamic instance) => instance.getPluginName,
        r'testFunction': (dynamic instance) => instance.testFunction
      },
      {},
      null,
      [
        const [0, 0, null],
        const [1, 0, null]
      ])
};

final _memberSymbolMap = null;

void initializeReflectable() {
  r.data = _data;
  r.memberSymbolMap = _memberSymbolMap;
}