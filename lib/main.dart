import 'package:chat_app_riverpod/colors.dart';
import 'package:chat_app_riverpod/common/widgets/error.dart';
import 'package:chat_app_riverpod/common/widgets/loader.dart';
import 'package:chat_app_riverpod/features/auth/controller/auth_controller.dart';
import 'package:chat_app_riverpod/features/landing/screens/landing_screen.dart';
import 'package:chat_app_riverpod/firebase_options.dart';
import 'package:chat_app_riverpod/responsive/responsive_layout.dart';
import 'package:chat_app_riverpod/router.dart';
import 'package:chat_app_riverpod/screens/mobile_screen_layout.dart';
import 'package:chat_app_riverpod/screens/web_screen_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Chat App",
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          color: appBarColor,
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(
            data: (user) {
              if (user == null) {
                return const LandingScreen();
              }
              return const MobileScreenLayout();
            },
            error: (err, trace) {
              return ErrorScreen(error: err.toString());
            },
            loading: () => const Loader(),
          ),
    );
  }
}
