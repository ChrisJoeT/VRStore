import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrstore/Templates/design.dart';

class UpdateUserDetails extends StatefulWidget {
  final String? uid;

  const UpdateUserDetails({required this.uid, Key? key}) : super(key: key);

  @override
  State<UpdateUserDetails> createState() => _UpdateUserDetailsState();
}

class _UpdateUserDetailsState extends State<UpdateUserDetails> {
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 70),
                    Center(
                      child: Text(
                        'Add Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: GoogleFonts.kronaOne().fontFamily,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 10),
                      child: Text(
                        "Phone Number : ",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: GoogleFonts.kronaOne().fontFamily,
                        ),
                      ),
                    ),
                    DesignTextFeild(
                      hint: "Phone Number",
                      controller: _phoneNumberController,
                      obscuretext: false,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 10),
                      child: Text(
                        "Address : ",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: GoogleFonts.kronaOne().fontFamily,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                      child: Container(
                        height: 300,
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
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: TextFormField(
                            maxLines: 10,
                            minLines: 2,
                            obscureText: false,
                            controller: _addressController,
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              hintText: "Address with Pin Code",
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      
                        onTap: () async {

                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.uid ?? '')
                    .update({
                  'phnnumber': _phoneNumberController.text,
                  'address': _addressController.text,
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('User updated successfully!'),
                ));
              
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
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Add Details",
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
                    const SizedBox(height: 20),
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
