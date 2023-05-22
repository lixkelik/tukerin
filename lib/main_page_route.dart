import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tukerin/page/landing_page.dart';
import 'package:tukerin/page/widgets/navigation.dart';
import 'package:tukerin/page/widgets/utils.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MainPageRoute extends StatefulWidget {
  const MainPageRoute({super.key});

  @override
  State<MainPageRoute> createState() => _MainPageRouteState();
}

class _MainPageRouteState extends State<MainPageRoute> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Navigation();
            } else {
              return const LandingPage();
            }
          }),
    );
  }
}
