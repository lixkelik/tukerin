import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tukerin/firebase_options.dart';
import 'package:tukerin/main_page_route.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference stationName = firestore.collection('station');
CollectionReference transaction = firestore.collection('transactionHistory');


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();

  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context){
    
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: const MainPageRoute()
    );
  }
}
