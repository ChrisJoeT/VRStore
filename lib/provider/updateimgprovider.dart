import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UpdateBanner extends ChangeNotifier {
  List<String> _bannerUrls = [];
  bool _hasFetchedBanners = false;

  List<String> get bannerUrls => _bannerUrls;
  bool get hasFetchedBanners => _hasFetchedBanners;

  Future<void> uploadBanner(File image) async {
    try {
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      Reference storageReference = FirebaseStorage.instance.ref().child("Updatebanners/$fileName");
      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot storageTaskSnapshot = await uploadTask;

      if (storageTaskSnapshot.state == TaskState.success) {
        String imageUrl = await storageReference.getDownloadURL();
        await FirebaseFirestore.instance.collection('Updatebanners').add({'url': imageUrl});
        notifyListeners();
      } else {
        throw Exception("Failed to upload image");
      }
    } catch (e) {
      print("Error uploading image: $e");
      throw Exception("Failed to upload image");
    }
  }

  Future<void> fetchBanners() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Updatebanners').get();
      _bannerUrls = snapshot.docs.map((doc) => doc['url'] as String).toList();
      _hasFetchedBanners = true;
      notifyListeners();
    } catch (e) {
      print("Error fetching banners: $e");
    }
  }


  
}
