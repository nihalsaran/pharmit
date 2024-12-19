import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmit/Admin/admin_main.dart';
import 'package:pharmit/screens/admin_login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController pin = TextEditingController();
  final TextEditingController captcha = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    fullName.dispose();
    email.dispose();
    phone.dispose();
    pin.dispose();
    captcha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdminLogin()),
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: <Widget>[
          _buildHeader(),
          const SizedBox(height: 40),
          _buildTextField(controller: captcha, label: 'Captcha', icon: Icons.privacy_tip_outlined, maxLength: 6, keyboardType: TextInputType.number),
          _buildTextField(controller: fullName, label: 'Full Name', icon: Icons.person_outline, keyboardType: TextInputType.name),
          _buildTextField(controller: email, label: "Email I'd", icon: Icons.email_outlined, keyboardType: TextInputType.emailAddress),
          _buildTextField(controller: phone, label: 'Contact no', icon: Icons.phone_iphone_outlined, maxLength: 10, keyboardType: TextInputType.phone, prefixText: '+91-'),
          _buildTextField(controller: pin, label: 'PIN', icon: Icons.lock_outline, maxLength: 6, keyboardType: TextInputType.number, obscureText: true),
          const SizedBox(height: 50),
          _buildRegisterButton(),
          const SizedBox(height: 10),
          _buildLoginButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Almost There !",
          style: GoogleFonts.righteous(fontSize: 30, color: Colors.teal.shade700),
        ),
        const SizedBox(height: 10),
        Text(
          "We are excited to see you here..!",
          style: GoogleFonts.acme(fontSize: 25, color: Colors.teal),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int? maxLength,
    TextInputType? keyboardType,
    bool obscureText = false,
    String? prefixText,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: TextField(
        controller: controller,
        maxLength: maxLength,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.black),
          ),
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.black),
          prefixText: prefixText,
          prefixStyle: const TextStyle(fontSize: 20, color: Colors.grey),
          labelStyle: const TextStyle(fontSize: 20, color: Colors.grey),
        ),
        style: const TextStyle(fontSize: 20, color: Colors.black),
        cursorColor: Colors.grey,
      ),
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.teal.shade700),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        onPressed: signUp,
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Please Wait...', style: TextStyle(fontSize: 18)),
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
                'REGISTER',
                style: TextStyle(fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: const BorderSide(color: Colors.teal),
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdminLogin()),
          );
        },
        child: const Text(
          'LOGIN',
          style: TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    if (captcha.text.isEmpty || fullName.text.isEmpty || email.text.isEmpty || phone.text.isEmpty || pin.text.isEmpty) {
      _showSnackBar('Please enter your details');
    } else if (captcha.text != '123456') {
      _showSnackBar('Captcha does not match');
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email.text)) {
      _showSnackBar('Please enter your proper email id');
    } else if (!RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$').hasMatch(phone.text)) {
      _showSnackBar('Please enter your proper contact no');
    } else if (pin.text.length < 6) {
      _showSnackBar('Pincode should be equal to 6 digit');
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        await _registerUser();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AdminDashboard()),
          (Route<dynamic> route) => false,
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        if (e.code == 'weak-password') {
          _showSnackBar('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          _showSnackBar('The account already exists for that email.');
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        _showSnackBar('Error Occurred');
      }
    }
  }

  Future<void> _registerUser() async {
    String name = fullName.text;
    String emailId = email.text;
    String contact = phone.text;
    String pass = pin.text;
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailId,
      password: pass,
    );

    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('Admin').doc(uid).set({
      'Name': name,
      'Email': emailId,
      'Phone No': contact,
      'Password': pass,
      'uid': uid,
      'admin': true,
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
