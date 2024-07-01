import 'package:flutter/material.dart';
import 'package:vrstore/provider/productprovider.dart' as productProvider;
import 'package:provider/provider.dart';
import 'package:vrstore/Templates/design.dart';
import 'package:vrstore/pages/productdisply.dart';

class ProductView extends StatelessWidget {
  ProductView({super.key});


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            
          SizedBox(
            width: double.infinity,
            child: Consumer<productProvider.ProductViewProvider>(
              builder: (context, provider, child) {
                if (provider.products.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: provider.products.length,
                    itemBuilder: (context, index) {
                      var product = provider.products[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDisplayPage(productid: product['productid']),
                            ),
                          );
                        },
                        child: DesignProductBox(
                          url: product['url'],
                          modelname: product['modelname'],
                          companyname: product['companyname'],
                          price: product['price'],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      )
    );
  }

}
