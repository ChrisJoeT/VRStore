import 'package:flutter/material.dart';

class PageProducts extends StatefulWidget {
  const PageProducts({super.key});

  @override
  State<PageProducts> createState() => _PageProductsState();
}

class _PageProductsState extends State<PageProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
          SizedBox(
              height: 40,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    color: Colors.amberAccent,
                  ),
                  Container(
                    width: 100,
                    color: Colors.red,
                  ),              
                ],
              ),
          ),
          ],
        ) ),
    );
  }
}