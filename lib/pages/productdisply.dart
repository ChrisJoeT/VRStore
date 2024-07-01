import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vrstore/pages/directorder.dart';
import 'package:vrstore/provider/cartprovider.dart';
import 'package:vrstore/provider/productviewprovider.dart';
import 'package:vrstore/provider/userprovider.dart';

class ProductDisplayPage extends StatefulWidget {
  final String? productid;

  const ProductDisplayPage({super.key, required this.productid});

  @override
  State<ProductDisplayPage> createState() => _ProductDisplayPageState();
}

class _ProductDisplayPageState extends State<ProductDisplayPage> {


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SpecProductViewProvider>(context, listen: false).fetchProductById(widget.productid ?? "");
    });

    Provider.of<UserProvider>(context, listen: false).loadUserFromPreferences();
  }

  @override
  Widget build(BuildContext context) {

    
       final cartNotifier = Provider.of<CartNotifier>(context);
         final userProvider = Provider.of<UserProvider>(context);
    final userId = userProvider.user?.uid;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Consumer2<UserProvider, SpecProductViewProvider>(
          builder: (context, userProvider, productProvider, child) {
            if (userProvider.user == null) {
              return const Center(child: Text("No user found"));
            }
            
            if (productProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (productProvider.errorMessage != null) {
              return Center(child: Text(productProvider.errorMessage!));
            }
            
            if (productProvider.product == null) {
              return const Center(child: Text('Product not found.'));
            }

            return Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: ClipRRect(
                        child: Image.network(productProvider.product!['url']),
                      ),
                    ),


                    Padding(
                      padding: const  EdgeInsets.only(left: 8,right: 8,top: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(productProvider.product!['modelname'],
                        maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      overflow: TextOverflow.fade,
                                      fontSize: 25,
                                      fontFamily: GoogleFonts.kronaOne().fontFamily,
                                    ),
                                    ),
                      ),
                    ),

                                        Padding(
                                          padding: const EdgeInsets.only(left: 8,right: 8,top: 3),
                                          child: Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Opacity(
                                                                opacity: 0.5,
                                                                child: Text(productProvider.product!['companyname'],
                                                              
                                                              
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                              
                                                                              
                                                                              fontSize: 15,
                                                                              fontFamily: GoogleFonts.kronaOne().fontFamily,
                                                                            ),
                                                                            ),
                                                              ),
                                                            ),
                                        ),

                        Row(
                                          children: [

                                         Expanded(
                                           child: Row(
                                             children: [

                                                  Padding(
                                          padding: const EdgeInsets.only(left: 8,right: 8,top: 3),
                                          child: Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Opacity(
                                                                opacity: 0.5,
                                                                child: Text("RAM",
                                                              
                                                              
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                              
                                                                              
                                                                              fontSize: 10,
                                                                              fontFamily: GoogleFonts.kronaOne().fontFamily,
                                                                            ),
                                                                            ),
                                                              ),
                                                            ),
                                        ),







                                               Padding(
                                                                   padding: const  EdgeInsets.only(left: 8,right: 8,top: 15),
                                                                   child: Align(
                                                                     alignment: Alignment.centerLeft,
                                                                     child: Text(productProvider.product!['ram'],
                                                                     maxLines: 3,
                                                                                 overflow: TextOverflow.ellipsis,
                                                                                 style: TextStyle(
                                                                                   overflow: TextOverflow.fade,
                                                                                   fontSize: 15,
                                                                                   fontFamily: GoogleFonts.kronaOne().fontFamily,
                                                                                 ),
                                                                                 ),
                                                                   ),
                                                                 ),
                                             ],
                                           ),
                                         ),



                                         Expanded(
                                           child: Row(
                                             children: [

                                                  Padding(
                                          padding: const EdgeInsets.only(left: 8,right: 8,top: 3),
                                          child: Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Opacity(
                                                                opacity: 0.5,
                                                                child: Text("Storage",
                                                              
                                                              
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                              
                                                                              
                                                                              fontSize: 10,
                                                                              fontFamily: GoogleFonts.kronaOne().fontFamily,
                                                                            ),
                                                                            ),
                                                              ),
                                                            ),
                                        ),







                                               Padding(
                                                                   padding: const  EdgeInsets.only(left: 8,right: 8,top: 15),
                                                                   child: Align(
                                                                     alignment: Alignment.centerLeft,
                                                                     child: Text(productProvider.product!['storage'],
                                                                     maxLines: 3,
                                                                                 overflow: TextOverflow.ellipsis,
                                                                                 style: TextStyle(
                                                                                   overflow: TextOverflow.fade,
                                                                                   fontSize: 15,
                                                                                   fontFamily: GoogleFonts.kronaOne().fontFamily,
                                                                                 ),
                                                                                 ),
                                                                   ),
                                                                 ),
                                             ],
                                           ),
                                         ),


                                       
                                          ],
                                        ),

                                        
                        Row(
                                             children: [

                                                  Padding(
                                          padding: const EdgeInsets.only(left: 8,right: 8,top: 3),
                                          child: Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Opacity(
                                                                opacity: 0.5,
                                                                child: Text("Rs.   ",
                                                              
                                                              
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                              
                                                                              
                                                                              fontSize: 10,
                                                                              fontFamily: GoogleFonts.kronaOne().fontFamily,
                                                                            ),
                                                                            ),
                                                              ),
                                                            ),
                                        ),







                                               Padding(
                                                                   padding: const  EdgeInsets.only(left: 8,right: 8,top: 15),
                                                                   child: Align(
                                                                     alignment: Alignment.centerLeft,
                                                                     child: Text(productProvider.product!['price'],
                                                                     maxLines: 3,
                                                                                 overflow: TextOverflow.ellipsis,
                                                                                 style: TextStyle(
                                                                                   overflow: TextOverflow.fade,
                                                                                   fontSize: 15,
                                                                                   fontFamily: GoogleFonts.kronaOne().fontFamily,
                                                                                 ),
                                                                                 ),
                                                                   ),
                                                                 ),
                                             ],
                                           ),
                      
                      const SizedBox(height: 30,),
                      
                      Padding(
                        padding: const  EdgeInsets.only(left: 8,right: 8,top: 3),
                        child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(productProvider.product!['description'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 30,
                                    style: TextStyle(

                                      
                                      fontSize: 10,
                                      fontFamily: GoogleFonts.kronaOne().fontFamily,
                                    ),
                                    ),
                                          ),
                      ),

                  ],
                ),

                Row(
                    children: [
                     Expanded(child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: ElevatedButton(onPressed: (){

                        final productDetails={
                              'productid': productProvider.product!['productid'],
                              'url': productProvider.product!['url'],
                              'modelname': productProvider.product!['modelname'],
                              'companyname': productProvider.product!['companyname'],
                              'price': productProvider.product!['price'],

            };

            Navigator.push(context, MaterialPageRoute(builder: (context) => DirectOrderPage(uid: userId, productDetails: productDetails),));


                       }, child: Text("Buy")),
                     )),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(onPressed: (){
                          
                            final cartItemData = {
                              'userid': userId,
                              'productid': productProvider.product!['productid'],
                              'url': productProvider.product!['url'],
                              'modelname': productProvider.product!['modelname'],
                              'companyname': productProvider.product!['companyname'],
                              'price': productProvider.product!['price'],

            };

            cartNotifier.addToCart(userId!, cartItemData);

            



                        }, child: Text("Add to Cart")),
                      ))
                    ],
                   ),






               SizedBox(height: 10,)
              ],
            );
          },
        ),
      ),
    );
  }
}
