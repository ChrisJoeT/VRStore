import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrstore/Templates/design.dart';
import 'package:vrstore/admin/adminhome.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> adminCredentials = [];

  @override
  void initState() {
    super.initState();
    _fetchAdminCredentials();
  }

  void _fetchAdminCredentials() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('Admin').get();
      List<Map<String, dynamic>> fetchedCredentials = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

      setState(() {
        adminCredentials = fetchedCredentials;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  void _login() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email & password')),
      );
      return;
    }

    bool isValid = adminCredentials.any((credential) =>
      credential['email'] == email && credential['password'] == password);

    if (isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful')),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminHomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 70,),
                    Center(
                      child: Text(
                        "Admin Login Page",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: GoogleFonts.kronaOne().fontFamily,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50,),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        "Email :",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: GoogleFonts.kronaOne().fontFamily,
                        ),
                      ),
                    ),
                    DesignTextFeild(
                      hint: "Enter Your Email", 
                      controller: _emailController, 
                      obscuretext: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 10),
                      child: Text(
                        "Password : ",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: GoogleFonts.kronaOne().fontFamily,
                        ),
                      ),
                    ),
                    DesignTextFeild(
                      hint: "Enter Your Password", 
                      controller: _passwordController, 
                      obscuretext: true,
                    ),
                    const SizedBox(height: 10,),
                    GestureDetector(
                      onTap: _login,
                      child: Center(
                        child: Container(
                          height: 55,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade600,
                                offset: const Offset(0.5, 0.5),
                                blurRadius: 1,
                                spreadRadius: 0.5,
                              ),
                              BoxShadow(
                                color: Theme.of(context).colorScheme.secondary,
                                offset: const Offset(-1.0, -1.0),
                                blurRadius: 3,
                                spreadRadius: 0.5,
                              ),
                            ]
                          ),
                          child: Center(
                            child: Text(
                              "Login ",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.background,
                                fontSize: 14,
                                fontFamily: GoogleFonts.kronaOne().fontFamily,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
