import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrstore/admin/delete_product.dart';
import 'package:vrstore/firebase_options.dart';
import 'package:vrstore/pages/home.dart';
import 'package:vrstore/pages/login.dart';
import 'package:vrstore/pages/register.dart';
import 'package:vrstore/pages/splashscreen.dart';
import 'package:vrstore/provider/cartprovider.dart';
import 'package:vrstore/provider/directorder.dart';
import 'package:vrstore/provider/productviewprovider.dart';
import 'package:vrstore/provider/theme_provider.dart';
import 'package:vrstore/provider/updateimgprovider.dart';
import 'package:vrstore/provider/userprovider.dart';
import 'package:vrstore/provider/mainbannerProvider.dart' as mainBanner;
import 'package:vrstore/provider/productprovider.dart' as productProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform, );
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: productProvider.ProductProviderModel()),
        ChangeNotifierProvider(create: (context) => productProvider.ProductViewProvider()..fetchProducts()),
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: SpecProductViewProvider()),
        ChangeNotifierProvider.value(value: CartNotifier()),
        ChangeNotifierProvider.value(value: DirectOrderNotifier()),
        ChangeNotifierProvider.value(value: mainBanner.BannerProvider()),
        ChangeNotifierProvider.value(value: UpdateBanner()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'VRStore',
            initialRoute: "/splash",
            theme: themeProvider.themeData,
            routes: {
              "/": (context) => const PageLogin(),
              "/register": (context) => const PageRegister(),
              "/home": (context) => const PageHome(),
              "/splash": (context) => const SplashScreen(),
              "/product_list": (context) => const ProductListPage(),
            },
          );
        },
      ),
    );
  }
}
