import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:danny_chats/common/widgets2/utils/utils.dart';
import 'package:danny_chats/features/landing/auth/screens/otp_screen.dart';
import 'package:danny_chats/features/landing/auth/screens/user_information_screen.dart';
import 'package:danny_chats/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/repositories/common_firebase_storage.dart';
import '../../../../screens/mobile_layout_screen.dart';

//Provider ref helps us to interact with other providers
final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
      auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

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
          Navigator.pushNamed(
            context,
            OTPScreen.routeName,
            arguments: verificationId,
          );
        }),
        codeAutoRetrievalTimeout: (String verification) {},
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(credential);
      Navigator.pushAndRemoveUntil(
        //With pushAndRemoveUntil, you cannot go back to the next Screen
        context,
        UserInformationScreen.routeName as Route<Object?>,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

//Now to save user data  to Firebase
  void saveUserDataToFirebase({
    required String name,
//Note, image file can be nullable
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl = '';
      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase(
              'profilePic/$uid',
              profilePic,
            );
      }
      var user = UserModel(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        isOnline: true,
//Note Phone Number and uid are totally different
        phoneNumber: auth.currentUser!.phoneNumber.toString(),
        groupId: [],
      );
//Now we push the user to firebase
      await firestore.collection('users').doc(uid).set(user.toMap());
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MobileLayoutScreen(),
        ),
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

//Auth Repository first, Then Move to the Auth Controller
  Stream<UserModel> userData(String userId) {
//Now we get UserData from firestore
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(event.data()!),
        );
  }

  void setUserState(bool isOnline) async {
  //Now we update isOnline / offline on firestore  
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'isOnline': isOnline,
    });
  }
}
