// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDKphRY9Vm1AOPqLTZxqe6C6bWnZFwp5k8',
    appId: '1:418865579922:web:499bd70c6bdebe7f90e34b',
    messagingSenderId: '418865579922',
    projectId: 'tukerin-50e8c',
    authDomain: 'tukerin-50e8c.firebaseapp.com',
    storageBucket: 'tukerin-50e8c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyARmM93HgE6Uj7ZtEQRQOm-KZAUbzQmVi0',
    appId: '1:418865579922:android:ccc4bc0cf747296790e34b',
    messagingSenderId: '418865579922',
    projectId: 'tukerin-50e8c',
    storageBucket: 'tukerin-50e8c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDfSOAt7qEVyCRH7Sp7vkKyRL8CJqvidfw',
    appId: '1:418865579922:ios:b5b28c90f9fbe61690e34b',
    messagingSenderId: '418865579922',
    projectId: 'tukerin-50e8c',
    storageBucket: 'tukerin-50e8c.appspot.com',
    iosClientId: '418865579922-tksocep68l4n5jq87c2g1f5oog9jirud.apps.googleusercontent.com',
    iosBundleId: 'com.example.swaptry',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDfSOAt7qEVyCRH7Sp7vkKyRL8CJqvidfw',
    appId: '1:418865579922:ios:b5b28c90f9fbe61690e34b',
    messagingSenderId: '418865579922',
    projectId: 'tukerin-50e8c',
    storageBucket: 'tukerin-50e8c.appspot.com',
    iosClientId: '418865579922-tksocep68l4n5jq87c2g1f5oog9jirud.apps.googleusercontent.com',
    iosBundleId: 'com.example.swaptry',
  );
}
