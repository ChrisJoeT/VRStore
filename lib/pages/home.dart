
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';
import 'package:vrstore/pages/user_cart.dart';
import 'package:vrstore/pages/user_home.dart';
import 'package:vrstore/pages/user_profile.dart';
import 'package:vrstore/provider/theme_provider.dart';
import 'package:vrstore/theme/theme.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  int currentindex = 0;

  List pages = [PageUserHome(), PageUserProfile(), PageUserCart()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "VRStore",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: GoogleFonts.kronaOne().fontFamily,
          ),
        ),
        actions: [
          
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: LiteRollingSwitch(
                value: Provider.of<ThemeProvider>(context).themeData == darkMode,
                textOn: "Dark Mode",
                textOff: "Light Mode ",
                colorOn: const Color.fromARGB(255, 255, 255, 255),
                colorOff: const Color.fromARGB(255, 0, 0, 0),
                iconOn: Icons.dark_mode,
                iconOff: Icons.light_mode,
                onChanged: (bool position) {
                  Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                },
                 onTap: () {},
                onDoubleTap: () {},
                onSwipe: () {},
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 6, right: 6),
        child: SizedBox(
          child: pages[currentindex],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            currentIndex: currentindex,
            onTap: (index) {
              setState(() {
                currentindex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shop_2_rounded),
                label: 'Cart',
              ),
            ],
            selectedItemColor: Theme.of(context).colorScheme.background,
            unselectedItemColor: Color.fromARGB(255, 192, 192, 192),
            backgroundColor: Theme.of(context).colorScheme.primary,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
