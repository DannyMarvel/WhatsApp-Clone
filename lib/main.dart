import 'package:danny_chats/features/landing/landing/screens/landing_screen.dart';
import 'package:danny_chats/router.dart';
import 'package:danny_chats/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
      home: const LandingScreen(),
    );
  }
}

