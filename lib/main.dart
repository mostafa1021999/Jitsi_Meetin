import 'package:flutter/material.dart';

import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var nameText=TextEditingController();
  List<String> participants = [];
  final _jitsiMeetPlugin = JitsiMeet();

  join() async {
   {

     var options = JitsiMeetConferenceOptions(
      room: "JitsiMeeting",
      serverURL: 'https://meet.jit.si',
      configOverrides: {
        "startWithAudioMuted": false,
        "startWithVideoMuted": false,
        "subject": "Lipitori"
      },
      featureFlags: {
        "unsaferoomwarning.enabled": false,
        "ios.screensharing.enabled": true
      },
      userInfo: JitsiMeetUserInfo(
          displayName: "${nameText.text}",));

    var listener = JitsiMeetEventListener(
      conferenceJoined: (url) {
        debugPrint("conferenceJoined: url: https://8x8.vc/vpaas-magic-cookie-7efb1cdc601c4859a7af86e4147b8607/SampleAppEnvironmentalCompaniesTearGently");
      },
      conferenceTerminated: (url, error) {
        debugPrint("conferenceTerminated: url: https://8x8.vc/vpaas-magic-cookie-7efb1cdc601c4859a7af86e4147b8607/SampleAppEnvironmentalCompaniesTearGently, error: $error");
      },
      conferenceWillJoin: (url) {
        debugPrint("conferenceWillJoin: url: https://8x8.vc/vpaas-magic-cookie-7efb1cdc601c4859a7af86e4147b8607/SampleAppEnvironmentalCompaniesTearGently");
      },
      participantJoined: (email, name, role, participantId) {
        debugPrint(
          "participantJoined: email: $email, name: $name, role: $role, "
              "participantId: $participantId",
        );
        participants.add(participantId!);
      },
      participantLeft: (participantId) {
        debugPrint("participantLeft: participantId: $participantId");
      },
      audioMutedChanged: (muted) {
        debugPrint("audioMutedChanged: isMuted: $muted");
      },
      videoMutedChanged: (muted) {
        debugPrint("videoMutedChanged: isMuted: $muted");
      },
      endpointTextMessageReceived: (senderId, message) {
        debugPrint(
            "endpointTextMessageReceived: senderId: $senderId, message: $message");
      },
      screenShareToggled: (participantId, sharing) {
        debugPrint(
          "screenShareToggled: participantId: $participantId, "
              "isSharing: $sharing",
        );
      },
      chatMessageReceived: (senderId, message, isPrivate, timestamp) {
        debugPrint(
          "chatMessageReceived: senderId: $senderId, message: $message, "
              "isPrivate: $isPrivate, timestamp: $timestamp",
        );
      },
      chatToggled: (isOpen) => debugPrint("chatToggled: isOpen: $isOpen"),
      participantsInfoRetrieved: (participantsInfo) {
        debugPrint(
            "participantsInfoRetrieved: participantsInfo: $participantsInfo, ");
      },
      readyToClose: () {
        debugPrint("readyToClose");
      },
    );
    await _jitsiMeetPlugin.join(options, listener);}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child:   Container(
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.redAccent,),
                width: double.infinity,
                child: MaterialButton(onPressed: join,
                  child: const Text('Start Meeting' , style: TextStyle( fontWeight: FontWeight.bold , fontSize: 25,color: Colors.white)),
                ),),
            )
          )),
    );
  }
}