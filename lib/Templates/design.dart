import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesignProductBox extends StatelessWidget {

  final String url;
  final String  modelname;
  final String companyname;
  final String price;

  const DesignProductBox({super.key, required this.url, required this.modelname, required this.companyname, required this.price});

  @override
  Widget build(BuildContext context) {

    return 
    Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,bottom: 7),
                  child: SizedBox(

                    child: Stack(
                      children: [
                       Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Theme.of(context).colorScheme.secondary,
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
                          ),
                        ),            
                        Column(
                          children: [
                            Center(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: ClipRRect(
                                  child: Image.network(url)         
                                ),
                              ),
                            ),                            
                        Center(
                          child: SizedBox(  
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(modelname,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: GoogleFonts.kronaOne().fontFamily,
                                  ),
                                  ),
                                ),
                                Text(companyname,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  
                                  fontSize: 7,
                                  fontFamily: GoogleFonts.kronaOne().fontFamily,
                                ),
                                ),
                                const SizedBox(height: 5),
                                Text("Rs. $price",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: GoogleFonts.kronaOne().fontFamily,
                                ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ],
                        ),                            
                      ],
                    ),
                  ),
                );
  }
}



class DesignTextFeild extends StatelessWidget {

  final String hint;
  final TextEditingController? controller;
  final bool obscuretext;


  const DesignTextFeild({super.key , required this.hint,required this.controller,required this.obscuretext});

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15, top:8 ),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6.0,right: 6.0,top: 3),
                    child: TextFormField(
                     
                      obscureText: obscuretext,
                      controller: controller,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: hint,
                        
                      ),
                    ),
                  ),
                ),
              );
 
  }
}