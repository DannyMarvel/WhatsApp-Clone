import 'package:danny_chats/features/landing/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Now to provide the AuthController to our screen, we use the provider
final authControllerProvider = Provider((ref) {
// provider ref helps us to interact with other providers
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

class AuthController {
  final AuthRepository authRepository;
  AuthController({required this.authRepository});

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
}
