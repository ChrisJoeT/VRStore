import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UpdateBannerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Banner List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Updatebanners').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot> banners = snapshot.data!.docs;

          if (banners.isEmpty) {
            return Center(child: Text('No banners found'));
          }

          return ListView.builder(
            itemCount: banners.length,
            itemBuilder: (context, index) {
              var banner = banners[index];
              String bannerId = banner.id;

              String? imageUrl = banner['url'] as String?;

              return ListTile(
                title: imageUrl != null ? Image.network(imageUrl) : Text('Image not found'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteBanner(context, bannerId, imageUrl),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _deleteBanner(BuildContext context, String bannerId, String? imageUrl) async {
    try {
      if (imageUrl == null) {
        throw Exception('imageUrl is null or empty');
      }


      await FirebaseFirestore.instance.collection('Updatebanners').doc(bannerId).delete();

      await FirebaseStorage.instance.refFromURL(imageUrl).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Banner deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete banner: $e')),
      );
    }
  }
}
