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
    apiKey: 'AIzaSyDYGCpaXuTUJw8Z78MQ-ecVpJ_u56oUMuI',
    appId: '1:821817644503:web:8c70eefd202686ac2ae792',
    messagingSenderId: '821817644503',
    projectId: 'med-qcom',
    authDomain: 'med-qcom.firebaseapp.com',
    storageBucket: 'med-qcom.firebasestorage.app',
    measurementId: 'G-51PW7RZSXN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAKz-Wag_F_R0bOJzGl3uAlCqxnMAOFRKU',
    appId: '1:821817644503:android:6498e6621a4bf4582ae792',
    messagingSenderId: '821817644503',
    projectId: 'med-qcom',
    storageBucket: 'med-qcom.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAFt3B6blR_1IIFTYxhg715l-8OlEb2MG8',
    appId: '1:821817644503:ios:203aed40346ca6832ae792',
    messagingSenderId: '821817644503',
    projectId: 'med-qcom',
    storageBucket: 'med-qcom.firebasestorage.app',
    iosBundleId: 'com.pharmit.pharmit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAFt3B6blR_1IIFTYxhg715l-8OlEb2MG8',
    appId: '1:821817644503:ios:203aed40346ca6832ae792',
    messagingSenderId: '821817644503',
    projectId: 'med-qcom',
    storageBucket: 'med-qcom.firebasestorage.app',
    iosBundleId: 'com.pharmit.pharmit',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDYGCpaXuTUJw8Z78MQ-ecVpJ_u56oUMuI',
    appId: '1:821817644503:web:30db6fcf90ad759e2ae792',
    messagingSenderId: '821817644503',
    projectId: 'med-qcom',
    authDomain: 'med-qcom.firebaseapp.com',
    storageBucket: 'med-qcom.firebasestorage.app',
    measurementId: 'G-T7XVXKRB5S',
  );
}
