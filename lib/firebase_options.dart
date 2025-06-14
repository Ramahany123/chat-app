// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBB2BAjHoASdv5uYZZIskFbNxMZqqjEbD4',
    appId: '1:914986240677:web:2819c556e4f5cc837c1b4c',
    messagingSenderId: '914986240677',
    projectId: 'chat-app-e4c6d',
    authDomain: 'chat-app-e4c6d.firebaseapp.com',
    storageBucket: 'chat-app-e4c6d.firebasestorage.app',
    measurementId: 'G-WBXDGB6SVS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmlsE_pJvBuwQWo5EhmVme7hcLbjZ78_4',
    appId: '1:914986240677:android:07a4d95ae813ce647c1b4c',
    messagingSenderId: '914986240677',
    projectId: 'chat-app-e4c6d',
    storageBucket: 'chat-app-e4c6d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCTZQB_WTqXiT-INR-SvM5EWQUb0O7mMUw',
    appId: '1:914986240677:ios:60f206ee4fb42d6e7c1b4c',
    messagingSenderId: '914986240677',
    projectId: 'chat-app-e4c6d',
    storageBucket: 'chat-app-e4c6d.firebasestorage.app',
    iosBundleId: 'com.example.chatApp2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCTZQB_WTqXiT-INR-SvM5EWQUb0O7mMUw',
    appId: '1:914986240677:ios:60f206ee4fb42d6e7c1b4c',
    messagingSenderId: '914986240677',
    projectId: 'chat-app-e4c6d',
    storageBucket: 'chat-app-e4c6d.firebasestorage.app',
    iosBundleId: 'com.example.chatApp2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBB2BAjHoASdv5uYZZIskFbNxMZqqjEbD4',
    appId: '1:914986240677:web:bfe5079d4c63d97d7c1b4c',
    messagingSenderId: '914986240677',
    projectId: 'chat-app-e4c6d',
    authDomain: 'chat-app-e4c6d.firebaseapp.com',
    storageBucket: 'chat-app-e4c6d.firebasestorage.app',
    measurementId: 'G-SF7VCKPNYF',
  );
}
