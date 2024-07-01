import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vrstore/provider/updateimgprovider.dart';

class AddUpdateBanner extends StatefulWidget {
  const AddUpdateBanner({super.key});

  @override
  State<AddUpdateBanner> createState() => _AddUpdateBannerState();
}

class _AddUpdateBannerState extends State<AddUpdateBanner> {

 File? _image;
 final ImagePicker _picker= ImagePicker();


 Future _pickImage() async{

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }

 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          child: Text("Add Main Banner",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: GoogleFonts.kronaOne().fontFamily,
                          ),
                          ),
                        ),
                  
                        const SizedBox(height: 50,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                _pickImage();
                              },
                              child: Container(
                                height: 200,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),

                                child: _image!=null 
                                ? Image.file(_image!.absolute, fit: BoxFit.cover,)
                                :const Center(
                                  child: Icon(
                                    Icons.add_a_photo_outlined
                                  ),
                                )
                                ,
                            
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: 20,),
                  
                        GestureDetector(

                                        onTap: () {
                        if (_image != null ) {
                          context.read<UpdateBanner>().uploadBanner(_image!);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sucessfully uploaded")));
                          
                                
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please fill in all fields and add an image")),
                          );
                        }
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
                                  child: Text("Add Banner ",
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

                        const SizedBox(height: 20,),
                  
                  
                        
                      ],
                    ),
                  ),
                ],
              ),


              

            ],


          ),
          
        ),
      ),


    );
  }
}