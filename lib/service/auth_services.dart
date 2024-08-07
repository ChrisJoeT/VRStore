
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrstore/model/user_model.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');

  Future<UserCredential?> registerUser(UserModel user) async{
      UserCredential userData = await _auth.createUserWithEmailAndPassword(
        email: user.email.toString(), 
        password: user.password.toString());

        if(userData != null){

          FirebaseFirestore.instance.collection('users')
          .doc(userData.user!.uid)
          .set(

            {
              'uid': userData.user!.uid,
              'email': userData.user!.email,
              'name': user.name,
              'createdAt': user.createdAt,
              'status' :user.status,  
            
            }

          );

          return userData;

        }

  }


  Future<DocumentSnapshot?> loginUser(UserModel user) async{

    DocumentSnapshot? snap;

    SharedPreferences _pref= await SharedPreferences.getInstance();

   UserCredential userCredential= await _auth.signInWithEmailAndPassword(email: user.email.toString(), password: user.password.toString());

    String? tocken=await userCredential.user!.getIdToken();

    if(userCredential!= null){

      DocumentSnapshot snap=await _userCollection.doc(userCredential.user!.uid).get();

      await _pref.setString('tocken', tocken!);
      await _pref.setString('name', snap['name']);
      await _pref.setString('email', snap['email']);
      await _pref.setString('uid', snap['uid']);


      return snap;




    }



  }
  

  Future <void> logout()async{
    SharedPreferences _pref=await SharedPreferences.getInstance();
    await _pref.clear();

    _auth.signOut();


  }

  Future<bool>isloggedin()async{

    SharedPreferences _pref = await SharedPreferences.getInstance();
    String? _tocken = await _pref.getString('tocken');

    if(_tocken==null){
      return false;

    }else{

      return true;
    }
  }
}