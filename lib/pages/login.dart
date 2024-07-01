


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrstore/Templates/design.dart';
import 'package:vrstore/model/user_model.dart';
import 'package:vrstore/service/auth_services.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {

  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordcontroller=TextEditingController();
                    UserModel _userModel = UserModel();
                    AuthService _authService = AuthService(); 

                    bool _isloading=false;

                    void _login() async{

                      setState(() {
                        _isloading=true;
                      });

                      try{

                      _userModel= UserModel(email: _emailController.text.trim(),password: _passwordcontroller.text.trim());

                      final data= await _authService.loginUser(_userModel);

                      if(data!=null){

                        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);

                        }
                       }on FirebaseAuthException catch(e){
                      setState(() {
                    _isloading=false;
                  });

                  List err=e.toString().split("]");

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err[1])));
               

                            }


                    }
  
      
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          
          child: Stack(
            children: [
              Stack(
                children: [
                  Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 70,),
                        Center(
                          child: Text("Login Page",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: GoogleFonts.kronaOne().fontFamily,
                          ),
                          ),
                        ),
                  
                        const SizedBox(height: 50,),
                  
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0 , ),
                          child: Text("Email :",
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
                          padding: const EdgeInsets.only(left: 18.0 , top: 10 ),
                          child: Text("Password : ",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: GoogleFonts.kronaOne().fontFamily,
                            ),
                            ),
                        ),
                  
                        DesignTextFeild(hint: "Enter Your Password", controller: _passwordcontroller, obscuretext: true),
                  
                  
                        const SizedBox(height: 10,),
                  
                  
                         Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("If you don't have an account?"),
                                  
                                  TextButton(
                                    onPressed: () {
                                      
                                    Navigator.pushNamed(context, '/register');
                                    },
                                    child: const Text("Create an account")),
                                ],
                              ),
                        ),
                  
                        const SizedBox(height: 10,),
                  
                        GestureDetector(
                          onTap: () {
                        

                              _login();
                            

                          
                          },
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
                                  child: Text("Login ",
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


              Center(
                child: Visibility(
                  visible: _isloading,
                  child: CircularProgressIndicator()),
              )
            


            ],


          ),
          
        ),
      ),
    );
  }
}


