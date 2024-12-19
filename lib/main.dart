// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fancy_cart/fancy_cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Import your existing screens/pages
import 'package:pharmit/Admin/admin_main.dart';
// import 'package:pharmit/screens/dashboard.dart';
import 'package:pharmit/screens/signin.dart';

// Main entry point of the application
void main() async {
  // Ensure Flutter binding is initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Lock the app to portrait orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Initialize the fancy cart package
  initializeFancyCart(
    child: const MyApp(),
  );
}

// Root application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configure system UI overlay styles
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      // Adjust text scaling factor for better readability
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.textScaleFactor.clamp(0.8, 0.9);
        return MediaQuery(
          data: mediaQueryData.copyWith(textScaleFactor: scale),
          child: child!,
        );
      },
    );
  }
}

// Splash Screen Widget
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Connectivity logging method
  Future<void> logConnectivityDetails() async {
    try {
      // Get the current connectivity result
      var connectivityResult = await (Connectivity().checkConnectivity());

      // Comprehensive logging of network status
      print('==== Detailed Network Connectivity Check ====');
      print('Raw Connectivity Result: $connectivityResult');

      // Detailed breakdown of connectivity status

      // Additional check to verify actual internet connectivity
      try {
        final result = await InternetAddress.lookup('google.com');
        print('Internet Reachability: ${result.isNotEmpty && result[0].rawAddress.isNotEmpty}');
        print('Ping Test Result Addresses: ${result.map((address) => address.rawAddress).join(', ')}');
      } on SocketException catch (e) {
        print('Internet Connectivity Check Failed');
        print('Socket Exception Details: ${e.toString()}');
      }
    } catch (e) {
      print('Unexpected Error During Connectivity Logging: ${e.toString()}');
    }
  }

  @override
  void initState() {
    super.initState();
    
    Timer(const Duration(seconds: 1), () async {
      try {
        // Log detailed connectivity information
        await logConnectivityDetails();

        // Check connectivity
        var connectivityResult = await (Connectivity().checkConnectivity());

        // Verify internet connection
        if (connectivityResult != ConnectivityResult.none) {
          // Listen to authentication state changes
          FirebaseAuth.instance.authStateChanges().listen((User? user) async {
            if (user == null) {
              // No user signed in, navigate to login
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            } else {
              // Check if user is an admin
              final userSnapshot = await FirebaseFirestore.instance
                  .collection('Admin')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get();

              if (userSnapshot.exists) {
                if (userSnapshot.data()!['admin'] == true) {
                  if (mounted) {
                    // Navigate to admin dashboard
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminDashboard()),
                      (Route<dynamic> route) => false,
                    );
                  }
                }
              } else {
                if (mounted) {
                  // Navigate to regular dashboard
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const Dashboard()),
                  //   (Route<dynamic> route) => false,
                  // );
                }
              }
            }
          });
        } else {
          // No internet connection
          print('No network connection available. Navigating to Offline Screen.');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const OfflineScreen()),
            (Route<dynamic> route) => false,
          );
        }
      } catch (e) {
        // Catch any unexpected errors
        print('Unexpected Error in Connectivity Check: ${e.toString()}');
        
        // Navigate to offline screen as a fallback
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const OfflineScreen()),
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade100,
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.center,
          child: const Image(
            width: double.infinity,
            image: AssetImage("assets/logos/splash_screen_logo.png"),
          ),
        ),
      ),
    );
  }
}

// Offline Screen Widget
class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onTap: () => exit(0), // Exit the app
        ),
        title: const Text(
          'PharmIt',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: const Center(
        child: Text(
          'Please check your internet connection.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}