import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vrstore/Templates/design.dart';
import 'package:vrstore/provider/productprovider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

 File? _image;
 final ImagePicker _picker= ImagePicker();

 final _modelNameController = TextEditingController();
 final _companyNameController = TextEditingController();
 final _priceController = TextEditingController();
 final _ramController = TextEditingController();
 final _storageController = TextEditingController();
 final _descriptionController = TextEditingController();


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
                          child: Text("Add Product",
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

                        const SizedBox(height: 15,),
                  
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0 , ),
                          child: Text("Model Name :",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: GoogleFonts.kronaOne().fontFamily,
                            ),
                            ),
                        ),
                        
                        DesignTextFeild(
                          hint: "ModelName", 
                          controller: _modelNameController, 
                          obscuretext: false,
                         ),

                        const SizedBox(height: 10,),
                  
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0 , top: 10 ),
                          child: Text("Company Name : ",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: GoogleFonts.kronaOne().fontFamily,
                            ),
                            ),
                        ),
                  
                        DesignTextFeild(hint: "Company Name", controller: _companyNameController, obscuretext: false),

                        const SizedBox(height: 10,),


                  
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0 , top: 10 ),
                          child: Text("Price : ",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: GoogleFonts.kronaOne().fontFamily,
                            ),
                            ),
                        ),
                  
                        DesignTextFeild(hint: "Price", controller: _priceController, obscuretext: false),

                  
                        const SizedBox(height: 10,),
                  
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0 , top: 10 ),
                          child: Text("RAM : ",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: GoogleFonts.kronaOne().fontFamily,
                            ),
                            ),
                        ),
                  
                        DesignTextFeild(hint: "RAM", controller: _ramController, obscuretext: false),


                         const SizedBox(height: 10,),
                  
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0 , top: 10 ),
                          child: Text("Storage : ",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: GoogleFonts.kronaOne().fontFamily,
                            ),
                            ),
                        ),
                  
                        DesignTextFeild(hint: "Storage", controller: _storageController, obscuretext: false),

                        const SizedBox(height: 10,),

                        Padding(
                          padding: const EdgeInsets.only(left: 18.0 , top: 10 ),
                          child: Text("Description : ",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: GoogleFonts.kronaOne().fontFamily,
                            ),
                            ),
                        ),
                  
                        

                        Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15, top:8 ),
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
                            ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6.0,right: 6.0,top: 3),
                    child: TextFormField(
                      maxLines: 10,
                      minLines: 2,
                     
                      obscureText: false,
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: "Description (Min 2 line Max 10 line)",
                        
                      ),
                    ),
                  ),
                ),
              ),
                  


                  const SizedBox(height: 20,),
                  
                        GestureDetector(

                                        onTap: () {
                        if (_image != null &&
                            _modelNameController.text.isNotEmpty &&
                            _companyNameController.text.isNotEmpty &&
                            _priceController.text.isNotEmpty &&
                            _ramController.text.isNotEmpty &&
                            _storageController.text.isNotEmpty &&
                            _descriptionController.text.isNotEmpty) {
                          context.read<ProductProviderModel>().uploadProduct(
                                _image!,
                                _modelNameController.text,
                                _companyNameController.text,
                                _priceController.text,
                                _ramController.text,
                                _storageController.text,
                                _descriptionController.text,
                              );
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
                                  child: Text("Add Product ",
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