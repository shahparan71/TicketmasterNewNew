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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhtjbk_HvIcRwmMyAeBF9HWyMJJR2-mjE',
    appId: '1:520849791314:android:179d55040909b2306d828b',
    messagingSenderId: '520849791314',
    projectId: 'ticketmaster-2e77b',
    databaseURL: 'https://ticketmaster-2e77b-default-rtdb.firebaseio.com',
    storageBucket: 'ticketmaster-2e77b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBnzgFGGp0mtCY3fE07hRKzOsJXQsa7-E8',
    appId: '1:520849791314:ios:8cbb852915331d6f6d828b',
    messagingSenderId: '520849791314',
    projectId: 'ticketmaster-2e77b',
    databaseURL: 'https://ticketmaster-2e77b-default-rtdb.firebaseio.com',
    storageBucket: 'ticketmaster-2e77b.appspot.com',
    iosBundleId: 'com.ticketmasternew.ticketMaster',
  );
}
