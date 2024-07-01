import 'package:flutter/material.dart';
import 'package:vrstore/admin/add_update_banner.dart';
import 'package:vrstore/admin/addmainbanner.dart';
import 'package:vrstore/admin/addproduct.dart';
import 'package:vrstore/admin/banner_list.dart';
import 'package:vrstore/admin/delete_product.dart';
import 'package:vrstore/admin/update_banner_list.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddProduct()),
                  );
                },
                child: const Text("Add Product"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddBanner()),
                  );
                },
                child: const Text("Add Banner"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BannerListPage()),
                  );
                },
                child: const Text("View and Delete Banner"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddUpdateBanner()),
                  );
                },
                child: const Text("Add UpdateBanner"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdateBannerList()),
                  );
                },
                child: const Text("Update Banner List"),
              ),

               ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductListPage()),
                  );
                },
                child: const Text("Product List"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
