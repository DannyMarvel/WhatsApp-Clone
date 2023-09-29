import 'package:danny_chats/features/landing/auth/controller/auth_controller.dart';
import 'package:danny_chats/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//In StatelessWidget for RiverPod we use ConsumerWidget only
class OTPScreen extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;
  const OTPScreen({
    super.key,
    required this.verificationId,
  });

  void verifyOTP(
    WidgetRef ref,
    BuildContext context,
    String userOTP,
  ) {
    ref
        .read(authControllerProvider)
        .verifyOTP(context, verificationId, userOTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Verifying your number'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text('We have sent an SMS with a Code.'),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle: TextStyle(
                    fontSize: 30,
                  ),
                ),
                keyboardType: TextInputType.number,
//onChanged means when you input the text correctly,
//You do not need a next button, before it auotmatically goes to the nextScreen

                onChanged: (val) {
//Because of onChanged we do not need TextEditing controller
                  if (val.length == 6) {
                    verifyOTP(ref, context, val.trim());
                    
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
