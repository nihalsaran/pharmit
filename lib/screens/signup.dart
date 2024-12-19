import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmit/screens/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController(); // Added
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String dist = '';
  List<String> district = [
    'Mumbai',
    'Thane',
    'Palghar',
    'Raigad',
    'Ratnagiri',
    'Sindhudurg',
    'Dhule',
    'Jalgaon',
    'Nandurbar',
    'Nashik',
    'Ahmednagar',
    'Bhandara',
    'Chandrapur',
    'Gadchiroli',
    'Gondia',
    'Nagpur',
    'Wardha',
    'Aurangabad',
    'Beed',
    'Jalna',
    'Osmanabad',
    'Nanded',
    'Latur',
    'Parbhani',
    'Hingoli',
    'Akola',
    'Amravati',
    'Buldhana',
    'Yavatmal',
    'Washim',
    'Sangli',
    'Satara',
    'Solapur',
    'Kolhapur',
    'Pune',
  ];

  TextEditingController add1 = TextEditingController();
  TextEditingController add2 = TextEditingController();
  TextEditingController add3 = TextEditingController();
  TextEditingController add4 = TextEditingController();
  String state = "Maharashtra";
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose(); // Added
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    add1.dispose();
    add2.dispose();
    add3.dispose();
    add4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    add3.text = state;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
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
                  "Create an Account",
                  style: GoogleFonts.righteous(
                      fontSize: 30, color: Colors.teal.shade700),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: const Text("Join us and start your journey",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.teal)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Image(
                    image: AssetImage("assets/logos/signup.jpg"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
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
                      labelText: 'Full Name',
                      prefixIcon:
                          Icon(Icons.person_outline, color: Colors.black),
                      labelStyle: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    cursorColor: Colors.grey,
                  ),
                ),
                // Phone Number Field Added Below
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
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
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone, color: Colors.black),
                      labelStyle: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    cursorColor: Colors.grey,
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
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
                      labelStyle: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    cursorColor: Colors.grey,
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: confirmPasswordController,
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
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
                      labelStyle: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    cursorColor: Colors.grey,
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 25),
                  child: const Text(
                    'Your Address',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: add1,
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'House Number & Building',
                        labelStyle:
                            TextStyle(fontSize: 20, color: Colors.grey)),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    cursorColor: Colors.grey,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: add2,
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Street & City',
                        labelStyle:
                            TextStyle(fontSize: 20, color: Colors.grey)),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    cursorColor: Colors.grey,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    hint: Text(
                      'DISTRICT',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    value: dist.isNotEmpty ? dist : null,
                    items: district.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(fontSize: 20)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dist = newValue!;
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: add3,
                    readOnly: true,
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'State',
                        labelStyle:
                            TextStyle(fontSize: 20, color: Colors.grey)),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    cursorColor: Colors.grey,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: add4,
                    maxLength: 6,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'PIN Number',
                        labelStyle:
                            TextStyle(fontSize: 20, color: Colors.grey)),
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
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.teal.shade700),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    onPressed: signUp,
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
                            'SIGN UP',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Already have an account? Sign In',
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

  // ...existing code...

  signUp() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
            .hasMatch(emailController.text) ||
        phoneController.text.isEmpty ||
        add1.text.isEmpty ||
        add2.text.isEmpty ||
        add3.text.isEmpty ||
        add4.text.isEmpty ||
        dist.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Fill all details')),
        );
      }
      return;
    }

    if (dist != "Mumbai") {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'We are unavailable to deliver in $dist. We will be there very soon',
            ),
          ),
        );
      }
      return;
    }

    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      String uid = FirebaseAuth.instance.currentUser!.uid;
      String fname = nameController.text;
      String femail = emailController.text;
      String contact = phoneController.text;

      await FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'Name': fname,
        'Email': femail,
        'Phone No': contact,
        'uid': uid,
        'wallet': 0
      });

      String address =
          "${add1.text}, ${add2.text}, $dist, ${add3.text}, ${add4.text}";

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('Address')
          .add({'Address': address});

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
          (Route<dynamic> route) => false,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$fname : Welcome to PharmIt")),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Error occurred')),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error Occurred')),
        );
      }
    }
  }
}
