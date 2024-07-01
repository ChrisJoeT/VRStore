import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vrstore/admin/adminlogin.dart';
import 'package:vrstore/pages/adduserdetails.dart';
import 'package:vrstore/provider/cartprovider.dart';
import 'package:vrstore/provider/userprovider.dart';
import 'package:vrstore/service/auth_services.dart';

class PageUserProfile extends StatelessWidget {
  const PageUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.loadUserFromPreferences();
    final cartNotifier = Provider.of<CartNotifier>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = userProvider.user;
      if (user != null && user.uid != null) {
        cartNotifier.fetchOrderDetails(user.uid!);
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Theme.of(context).colorScheme.background,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0, right: 20, left: 20),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: const BorderRadius.all(Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade600,
                            offset: const Offset(0.5, 0.5),
                            blurRadius: 0.5,
                            spreadRadius: 0.5,
                          ),
                          BoxShadow(
                            color: Theme.of(context).colorScheme.secondary,
                            offset: const Offset(-1.0, -1.0),
                            blurRadius: 1.5,
                            spreadRadius: 0.5,
                          ),
                        ],
                      ),
                      child: Consumer<UserProvider>(
                        builder: (context, userProvider, child) {
                          if (userProvider.user == null) {
                            return const Text('No user data');
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(top: 80.0),
                              child: Column(
                                children: [
                                  Text(
                                    userProvider.user!.name ?? "no user",
                                    style: TextStyle(
                                      fontFamily: GoogleFonts.kronaOne().fontFamily,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    userProvider.user!.email ?? "no email",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: GoogleFonts.kronaOne().fontFamily,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "User",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                      fontFamily: GoogleFonts.kronaOne().fontFamily,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UpdateUserDetails(
                                                uid: userProvider.user!.uid ?? "no email",
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Add Details",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: GoogleFonts.kronaOne().fontFamily,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          AuthService().logout().then((value) {
                                            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                                          });
                                        },
                                        child: Text(
                                          "LogOut",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: GoogleFonts.kronaOne().fontFamily,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ClipOval(
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade600,
                                  offset: const Offset(0.5, 0.5),
                                  blurRadius: 0.5,
                                  spreadRadius: 0.5,
                                ),
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.secondary,
                                  offset: const Offset(-1.0, -1.0),
                                  blurRadius: 1.5,
                                  spreadRadius: 0.5,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.person_outlined,
                              color: Theme.of(context).colorScheme.background,
                              size: 60,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: double.infinity)
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 18, left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Order List",
                  style: TextStyle(
                    fontFamily: GoogleFonts.kronaOne().fontFamily,
                  ),
                ),
              ),
            ),
            Consumer<CartNotifier>(
              builder: (context, cartNotifier, child) {
                if (cartNotifier.orderDetails.isEmpty) {
                  return const Center(
                    child: Text("No orders available"),
                  );
                } else {
                  final items = cartNotifier.orderDetails['items'] as List<dynamic>;
                  return Container(
                    height: 400, 
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(item['modelname']),
                              Text('Price: Rs. ${item['price']}'),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminLogin(),
                  ),
                );
              },
              child: const Text("Go to Admin"),
            ),
          ],
        ),
      ),
    );
  }
}
