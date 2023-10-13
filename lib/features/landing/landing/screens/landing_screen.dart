import 'package:danny_chats/common/widgets2/custom_button.dart';
import 'package:danny_chats/features/landing/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/colors.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Welcome to Danny WhatsApp',
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height / 9),
            Image.asset(
              'assets/images/landing.jpeg',
              height: 340,
              width: 340,
            ),
            SizedBox(height: size.height / 9),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Read our Privacy Policy. Tap "Agree and continue to accept our terms and condition',
                style: TextStyle(
                  color: greyColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: size.width * 0.75,
              child: CustomButton(
                text: 'AGREE AND CONTINUE',
                onPressed: () => navigateToLoginScreen(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
