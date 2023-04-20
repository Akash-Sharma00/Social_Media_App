import 'package:flutter/material.dart';
import 'package:social_media/calling/const_call.dart';
import 'package:social_media/const/allkeys.dart';
import 'package:social_media/main.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID,required this.user_name}) : super(key: key);
  final String callID;
  final String user_name;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: CallConsts.appID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: CallConsts.appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: prefs.getString(AllKeys.id)??"24jhbj",
      userName: user_name,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall() 
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}