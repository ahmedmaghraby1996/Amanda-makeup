

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';
class Makeup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
   return Makeupstate();
  }

}
class Makeupstate extends State<Makeup>{
  final _key = UniqueKey();
  bool done=false;
  InAppWebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body:  Stack(
      children: [
        Container(
          child: Column(
            children: [
              Expanded(
  child: Container(
  child: InAppWebView(
  initialUrl: "https://showroom.algoface.ai/try-on",
                onLoadStop:(_,s){
        setState(() {
          done=true;
        });
                },

                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    mediaPlaybackRequiresUserGesture: false,
                    debuggingEnabled: true,
                  ),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
                androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
                  return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                }
  ),

  )),
            ],
          ),
        ),
        done==false? Center( child: CircularProgressIndicator(),):Container()
      ],
    ));
  }

}