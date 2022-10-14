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
    apiKey: 'AIzaSyCyxQu4x2qiIYH1Q8h_Aao6b5MybMg6KSo',
    appId: '1:56142775138:web:74bde1b0298b65674ee23b',
    messagingSenderId: '56142775138',
    projectId: 'gizozoshopx',
    authDomain: 'gizozoshopx.firebaseapp.com',
    storageBucket: 'gizozoshopx.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBx6u97GeFtBOFZbu-NdJHlrymYC3aiHL4',
    appId: '1:56142775138:android:fea891c0dba3e0324ee23b',
    messagingSenderId: '56142775138',
    projectId: 'gizozoshopx',
    storageBucket: 'gizozoshopx.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAL_uvyciIsv_g3KPQPdqhWgv11qP9llPE',
    appId: '1:56142775138:ios:56c7b32d546aa4114ee23b',
    messagingSenderId: '56142775138',
    projectId: 'gizozoshopx',
    storageBucket: 'gizozoshopx.appspot.com',
    iosClientId: '56142775138-c72i6lppmurnr74dhl1fqp2tes73505a.apps.googleusercontent.com',
    iosBundleId: 'com.example.zozoshop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAL_uvyciIsv_g3KPQPdqhWgv11qP9llPE',
    appId: '1:56142775138:ios:56c7b32d546aa4114ee23b',
    messagingSenderId: '56142775138',
    projectId: 'gizozoshopx',
    storageBucket: 'gizozoshopx.appspot.com',
    iosClientId: '56142775138-c72i6lppmurnr74dhl1fqp2tes73505a.apps.googleusercontent.com',
    iosBundleId: 'com.example.zozoshop',
  );
}