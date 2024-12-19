// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmit/screens/admin_login.dart';
import 'package:pharmit/screens/signup.dart';
// import 'package:pharmit/screens/login_otp.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static String verify = "";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController contact = TextEditingController();
  TextEditingController contrycode = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    contrycode.text = "+91";
    super.initState();
  }

  @override
  void dispose() {
    contact.dispose();
    contrycode.dispose(); // dispose of the controller when the widget is removed from the tree
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icons' color
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Welcome to PharmIt",
                  style: GoogleFonts.righteous(
                      fontSize: 30, color: Colors.teal.shade700),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: const Text(
                      "We care beyond what your doctors have prescribed",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.teal)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Image(
                    image: AssetImage("assets/logos/login.jpg"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Email',
                      prefixIcon:
                          Icon(Icons.email_outlined, color: Colors.black),
                      labelStyle: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    cursorColor: Colors.grey,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Password',
                      prefixIcon:
                          Icon(Icons.lock_outline, color: Colors.black),
                      labelStyle: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    cursorColor: Colors.grey,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Colors.teal.shade700),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    onPressed: signIn,
                    child: isLoading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Please Wait...',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        : const Text(
                            'SIGN IN',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: const BorderSide(color: Colors.teal)))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminLogin()),
                      );
                    },
                    child: const Text(
                      'Are you a Service Partner? Login here',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUp()),
                    );
                  },
                  child: const Text(
                    'Not a User, SignUP',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  signIn() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email and password')),
      );
    } else {
        setState(() {
          isLoading = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        // Navigate to the next screen
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Error occurred')),
        );
      }
    }
  }
}
