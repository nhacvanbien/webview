import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview/ui/webview/webview_screen.dart';

Future commonMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BizzElectronicApp());
}

class BizzElectronicApp extends StatefulWidget {
  const BizzElectronicApp({Key? key}) : super(key: key);

  @override
  State<BizzElectronicApp> createState() => _BizzElectronicAppState();
}

class _BizzElectronicAppState extends State<BizzElectronicApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WebViewScreen(),
    );
  }
}
