import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:eduguard/src/features/blogs/model/blogmodel.dart';

class BlogRepository extends GetxService {
  static BlogRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save blog data to Firestore
  Future<void> saveBlogRecord(Map<String, dynamic> blogData) async {
    try {
      await _db.collection('Blogs').add(blogData); // Auto-generates an ID
    } on FirebaseException catch (e) {
      throw ('Firebase Exception: $e');
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Fetch blog details by blog ID
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchBlogDetails(
      String blogId) async {
    try {
      return await _db.collection('Blogs').doc(blogId).get();
    } on FirebaseException catch (e) {
      throw ('Firebase Exception: $e');
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  //* Update blog details by blog ID
  /*Future<void> updateBlogDetails(
      String blogId, Map<String, dynamic> blogData) async {
    try {
      await _db.collection('Blogs').doc(blogId).update(blogData);
    } on FirebaseException catch (e) {
      throw ('Firebase Exception: $e');
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }*/

  Future<void> updateBlogDetails(
      String blogId, Map<String, dynamic> blogData) async {
    try {
      // Logging the ID and data being sent to Firestore
      print('Updating Firestore document with ID: $blogId');
      print('Data to update: $blogData');

      // Attempt to update the document in Firestore
      await _db.collection('Blogs').doc(blogId).update(blogData);

      // Log success if the operation is successful
      print('Firestore update successful');
    } catch (e) {
      // Log the error if the operation fails
      print('Firestore update failed: ${e.toString()}');
      throw ('Failed to update Firestore document: $e');
    }
  }

  // Update a single field of the blog by blog ID
  Future<void> updateSingleBlogField(
      String blogId, Map<String, dynamic> updatedField) async {
    try {
      await _db.collection('Blogs').doc(blogId).update(updatedField);
    } on FirebaseException catch (e) {
      throw ('Firebase Exception: $e');
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Remove blog data by blog ID
  Future<void> removeBlogDetails(String blogId) async {
    try {
      await _db.collection('Blogs').doc(blogId).delete();
    } on FirebaseException catch (e) {
      throw ('Firebase Exception: $e');
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  //Get all Blogs
  Future<List<BlogModel>> getallblogs() async {
    try {
      final snapshot = await _db.collection('Blogs').get();
      return snapshot.docs.map((e) => BlogModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw ('Firebase Exception : $e');
    } on PlatformException catch (e) {
      throw ('Platform Exception : $e');
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
}
