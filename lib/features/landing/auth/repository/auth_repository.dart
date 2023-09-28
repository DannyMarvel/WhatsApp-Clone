import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:danny_chats/common/widgets2/utils/utils.dart';
import 'package:danny_chats/features/landing/auth/screens/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  void signInWithPhone(BuildContext context, phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: ((String verificationId, int? resendToken) async {
//Whenever firebase sends an otp code, we need to go to the OTP screen
          Navigator.pushNamed(context, OTPScreen.routeName);
        }),
        codeAutoRetrievalTimeout: (String verification) {},
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
