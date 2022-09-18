
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatefulWidget{
  const PermissionScreen({super.key});

  @override
  PermissionScreenState createState() => PermissionScreenState();
}

class PermissionScreenState extends State<PermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Request Permission"),
          backgroundColor: Colors.redAccent,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              ElevatedButton(
                child: const Text("Request Single Permission"),
                onPressed: () async {
                  Permission.values
                  if (await Permission.camera.request().isGranted) {
                    // Either the permission was already granted before or the user just granted it.
                    debugPrint("Location Permission is granted");
                  }else{
                    openAppSettings();
                  }
                },
              ),

              ElevatedButton(
                child: const Text("Request Multiple Permission"),
                onPressed: () async {
                  // You can request multiple permissions at once.
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.storage,
                    Permission.camera,
                    //add more permission to request here.
                  ].request();
                  debugPrint("Location permission is denied. $statuses");
                },
              ),

              ElevatedButton(
                child: const Text("Check Camera Permission"),
                onPressed: () async {
                  //check permission without request popup
                  var status = await Permission.camera.status;
                  if (status.isDenied) {
                    // We didn't ask for permission yet or the permission has been denied before but not permanently.
                    debugPrint("Permission is denined.");
                  }else if(status.isGranted){
                    //permission is already granted.
                    debugPrint("Permission is already granted.");
                  }else if(status.isPermanentlyDenied){
                    //permission is permanently denied.
                    debugPrint("Permission is permanently denied");
                  }else if(status.isRestricted){
                    //permission is OS restricted.
                    debugPrint("Permission is OS restricted.");
                  }
                },
              )
            ],
          ),
        )
    );
  }
}