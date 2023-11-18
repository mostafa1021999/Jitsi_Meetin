import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Jitsi(),
    );
  }
}
class Jitsi extends StatelessWidget {
  const Jitsi({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:   Container(
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.redAccent,),
              width: double.infinity,
              child: MaterialButton(onPressed: ()async{
                Navigator.push(context, MaterialPageRoute(builder: (context) => Meeting(title: 'Meeting')));
              },
                child: const Text('Start Meeting' , style: TextStyle( fontWeight: FontWeight.bold , fontSize: 25,color: Colors.white)),
              ),),
          )
      ),
    );
  }
}

class Meeting extends StatefulWidget {
  const Meeting({super.key, required this.title});

  final String title;

  @override
  State<Meeting> createState() => _Meeting();
}

class _Meeting extends State<Meeting> {
  final controller = WebViewController.fromPlatformCreationParams(
    const PlatformWebViewControllerCreationParams(),
    onPermissionRequest: (request) {
      request.grant();
    },
  );
  Future<WebViewController> _getController() async {
    await controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    await controller.loadRequest(Uri.parse( "https://8x8.vc/vpaas-magic-cookie-7efb1cdc601c4859a7af86e4147b8607/SampleAppEnvironmentalCompaniesTearGently" ));
    return controller;
  }
  @override
  void initState() {
    requestPermissions();
    _getController();
    super.initState();

  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebViewWidget(controller: controller,)
    );
  }
}

void requestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.microphone,
  ].request();

  // Check the status of the permissions
  if (statuses[Permission.camera]!.isGranted &&
      statuses[Permission.microphone]!.isGranted) {
    // Both permissions are granted, load the WebView
  } else {
    // Permissions are not granted, handle accordingly
    // For example, show an error message or request permissions again
  }
}

