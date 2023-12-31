
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../common/widgets2/loader.dart';
import '../../../config/agora_config.dart';
import '../../../models/call.dart';
import '../controller/call_controller.dart';

class CallScreen extends ConsumerStatefulWidget {
  final String channelId;
  final Call call;
  final bool isGroupChat;
  final String userID ='';
  final String name = '';
 // final String appSign;
  const CallScreen({  
    Key? key,
    required this.channelId,
    required this.call,
    required this.isGroupChat,
    //required this.appSign,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  var client = ZegoUIKitPrebuiltCall;
  //String baseUrl = 'https://whatsapp-clone-rrr.herokuapp.com';

  // @override
  // void initState() {
  //   super.initState();
  //   client = ZegoClient(
  //       appId: AgoraConfig.appId,
  //       channelName: widget.channelId,
  //      // tokenUrl: baseUrl,
      
  //   );
  //   initAgora();
  // } 

  // void initZego() async {
  //   await client!.initialize();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: client == null
          ? const Loader()
          :ZegoUIKitPrebuiltCall(
      appID: 671455410, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: "1fad8a99f6877bc7255fe9c09f0404e387ef9923084abfe9ab068f288af1884c", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: widget.userID,
     userName: widget.name,
      callID: widget.channelId,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall() 
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    ),
    );
  }
}
