import 'dart:io';

import 'package:danny_chats/features/landing/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/user_model.dart';

//Now to provide the AuthController to our screen, we use the provider
final authControllerProvider = Provider((ref) {
// provider ref helps us to interact with other providers
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(
    authRepository: authRepository,
    ref: ref,
  );
});

final userDataAuthProvider = FutureProvider((ref) {
final authController = ref.watch(authControllerProvider);
return authController.getUserData();



});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({required this.authRepository, required this.ref});

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhone(context, phoneNumber);
  }

//Then we also add this to our Controller
  void verifyOTP(
    BuildContext context,
    String verificationId,
    String userOTP,
  ) {
    authRepository.verifyOTP(
      context: context,
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveUserDataToFirebase(
      name: name,
      profilePic: profilePic,
      ref: ref,
      context: context,
    );
  }
}
