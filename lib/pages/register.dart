import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrstore/Templates/design.dart';
import 'package:vrstore/model/user_model.dart';
import 'package:vrstore/service/auth_services.dart';

class PageRegister extends StatefulWidget {
  const PageRegister({super.key});

  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {

  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordcontroller=TextEditingController();
  final TextEditingController _namecontroller=TextEditingController();

  bool _isloading=false;


UserModel _userModel=UserModel();
AuthService _authService =AuthService();



void registerUser()async{


  setState(() {
    _isloading=true;
  });
                
                
                _userModel=UserModel(
                email: _emailController.text.trim(),
                password: _passwordcontroller.text.trim(),
                createdAt: DateTime.now(),
                status: 1,
                name: _namecontroller.text.trim(),
                        
                );

                try{
                  await Future.delayed(const Duration(seconds: 3));

                final userData= await _authService.registerUser(_userModel);
                       if(userData !=null){
                        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                       }

                }catch(e){



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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          
          child: Stack(
            children: [
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30,),
                    Center(
                      child: Text("Register Page",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: GoogleFonts.kronaOne().fontFamily,
                      ),
                      ),
                    ),
              
                      const SizedBox(height: 50,),
              
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0 , ),
                      child: Text("Name :",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: GoogleFonts.kronaOne().fontFamily,
                        ),
                        ),
                    ),
                    
                    DesignTextFeild(hint: "Enter Your Name", controller: _namecontroller, obscuretext: false),
              
                    
              
                    const SizedBox(height: 8,),
              
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
              
              
                                  
                    const SizedBox(height: 20,),
              
                    GestureDetector(
                      onTap: () async{

                       
                          registerUser();
                       

                        
                      },
                      child: Center(
                        child: Container( 
                          height: 55,
                          width: 250,
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
                              child: Text("Register Now  ",
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



              Visibility(
                visible: _isloading,
                child: Center(child: CircularProgressIndicator(),))
            ],
          ),
          
        ),
      ),
    );
  }
  
  
}