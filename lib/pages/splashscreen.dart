import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  String? name;
  String? email;
  String? uid;
  String? tocken;


  getdata()async{
    SharedPreferences _pref =await SharedPreferences.getInstance();
    tocken = await _pref.getString('tocken');
    email = await _pref.getString('email');
    uid = await _pref.getString('uid');
    name = await _pref.getString('name');

 


  }


@override
  void initState() {
    getdata();

    var d=Duration(seconds: 5);
    Future.delayed(d, (){
   checkLoginStatus();
    });
    
    super.initState();
  }

Future<void>checkLoginStatus() async{

  if(tocken==null){
    Navigator.pushNamed(context,"/" );
  }
else{

  Navigator.pushNamed(context,"/home" );
}
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [




          

            Positioned(
              top: 0,
              right: 0,
              child: Container(
              width:150,
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(210),),
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
            )),




            Center(
              child: Container(
              width:300,
              height: 600,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
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
            )),


            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
              width:150,
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(topRight: Radius.circular(210),),
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
            )),


                        Center(
              child:  SizedBox(
                child: Text("VRStore",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: GoogleFonts.kronaOne().fontFamily,
                ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}