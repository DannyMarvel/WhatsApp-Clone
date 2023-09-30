import 'package:danny_chats/common/widgets2/error.dart';
import 'package:danny_chats/common/widgets2/loader.dart';
import 'package:danny_chats/features/landing/auth/controller/auth_controller.dart';
import 'package:danny_chats/features/landing/landing/screens/landing_screen.dart';
import 'package:danny_chats/router.dart';
import 'package:danny_chats/screens/mobile_layout_screen.dart';
import 'package:danny_chats/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//ProviderScope keeps track of the state of the application
//This must be in all RiverPod Used Projects
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: 'Danny WhatsApp',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: AppBarTheme(
            color: appBarColor,
          ),
        ),
//Here we created a special route widget for generateRoute
        onGenerateRoute: (settings) => generateRoute(settings),
        home: ref.watch(userDataAuthProvider).when(
              data: (user) {
                if (user == null) {
                  return LandingScreen();
                }
                return MobileLayoutScreen();
              },
              error: (err, trace) {
                return ErrorScreen(
                  error: err.toString(),
                );
              },
              loading: () => Loader(),
            ));
  }
}
