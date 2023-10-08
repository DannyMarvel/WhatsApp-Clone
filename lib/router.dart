import 'package:danny_chats/common/widgets2/error.dart';
import 'package:danny_chats/features/landing/auth/screens/login_screen.dart';
import 'package:danny_chats/features/landing/auth/screens/otp_screen.dart';
import 'package:danny_chats/features/landing/auth/screens/user_information_screen.dart';
import 'package:danny_chats/features/landing/select_contacts/screens/select_contacts_screen.dart';
import 'package:danny_chats/features/landing/auth/chats/screens/mobile_chat_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => LoginScreen(),
      );
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(
          verificationId: verificationId,
        ),
      );

    case UserInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => UserInformationScreen(),
      );

    case MobileChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      //This is how to extract the Map we have sent
      final name = arguments['name'];
      final uid = arguments['uid'];
      return MaterialPageRoute(
        builder: (context) => MobileChatScreen(
          name: name,
          uid: uid, 
          isGroupChat: null,
          profilePic: ,
        ),
      );

    case SelectContactsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => SelectContactsScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: ErrorScreen(error: 'This Page does not exist '),
        ),
      );
  }
}
