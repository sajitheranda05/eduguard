import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/features/std_detection/models/std_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class STDRepository extends GetxController {
  static STDRepository get instance => Get.find();

  ///Firestore instance for database interactions
  final _db = FirebaseFirestore.instance;

  /// final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///Get all stds
  Future<List<STDModel>> getAllSTDs() async {
    try {
      final snapshot = await _db.collection('STDs').get();
      return snapshot.docs.map((e) => STDModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw ('Firebase Exception : $e');
    } on PlatformException catch (e) {
      throw ('Platform Exception : $e');
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<String?> uploadImage(String assetPath) async {
    try {
      // Load the image from assets
      final ByteData bytes = await rootBundle.load(assetPath);
      final Uint8List imageData = bytes.buffer.asUint8List();

      // Create a reference to Firebase Storage
      final fileName = assetPath.split('/').last;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images/std_detection/$fileName');

      // Upload the image
      final uploadTask = storageRef.putData(imageData);

      // Wait for the upload to complete
      await uploadTask.whenComplete(() {});

      // Get the download URL
      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> addSTD(STDModel std) async {
    try {
      final dataToAdd = std.toJson();
      await _db.collection('STDs').add(dataToAdd);
    } catch (e) {
      throw Exception('Error adding STD: $e');
    }
  }
}
