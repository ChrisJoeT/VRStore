import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vrstore/Templates/design.dart';
import 'package:vrstore/pages/product_view.dart';
import 'package:vrstore/pages/productdisply.dart';
import 'package:vrstore/provider/mainbannerProvider.dart';
import 'package:vrstore/provider/productprovider.dart' as productProvider;
import 'package:vrstore/provider/updateimgprovider.dart';



class PageUserHome extends StatelessWidget {
  const PageUserHome({super.key});


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<BannerProvider>(builder: (context, bannerProvider, child) {
              if (!bannerProvider.hasFetchedBanners) {
                bannerProvider.fetchBanners(); 
                return const Center(child: CircularProgressIndicator());
              } else {
                return SizedBox(
                  height: 190,
                  width: double.infinity,
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: bannerProvider.bannerUrls.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(bannerProvider.bannerUrls[index], fit: BoxFit.cover),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
        

          const SizedBox(height: 10),
          _buildSectionHeader(context, "Popular VR's", onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductView(),));
          }),
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

           _buildSectionHeader(context, "VR Updates"),


          

          Consumer<UpdateBanner>(builder: (context, bannerProvider, child) {
              if (!bannerProvider.hasFetchedBanners) {
                bannerProvider.fetchBanners(); 
                return const Center(child: CircularProgressIndicator());
              } else {
                return SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: bannerProvider.bannerUrls.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(bannerProvider.bannerUrls[index], fit: BoxFit.cover),
                        ),
                      );
                    },
                  ),
                );
              }
            }),

          
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            width: 320,
            child: Column(
              children: [
                Text(
                  "Your Ultimate VR Shopping Destination",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: GoogleFonts.kronaOne().fontFamily,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 155,
                      child: Text(
                        textAlign: TextAlign.justify,
                        "VR Store is a comprehensive VR e-commerce app that offers a seamless and personalized shopping experience.  Users receive personalized recommendations based on their preferences and browsing history, and can easily find their ideal VR Gadget using advanced filters. The app's comparison tool allows side-by-side evaluations of up to four smartphones, highlighting key differences to aid decision-making.",
                        style: TextStyle(
                          fontSize: 6,
                          fontFamily: GoogleFonts.kronaOne().fontFamily,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      height: 110,
                      width: 155,
                      child: Text(
                        textAlign: TextAlign.justify,
                        "VR Store provides exclusive deals, flash sales, and coupon codes, ensuring the best prices. Shopping is secure with multiple payment options, including credit/debit cards, digital wallets, and EMI plans, all protected by advanced encryption. The user-friendly interface features intuitive navigation, a powerful search function, and a wishlist for saving favorite items. Users can track orders in real-time, manage order history, and receive delivery notifications.",
                        style: TextStyle(
                          fontSize: 6,
                          fontFamily: GoogleFonts.kronaOne().fontFamily,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      )
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, {VoidCallback? onTap}) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontFamily: GoogleFonts.kronaOne().fontFamily,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          if (onTap != null)
            TextButton(
              onPressed: onTap,
              child: Row(
                children: [
                  Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: GoogleFonts.kronaOne().fontFamily,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const Icon(Icons.arrow_right_rounded),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
