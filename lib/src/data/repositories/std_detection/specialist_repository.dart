import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/features/std_detection/models/specialist_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SpecialistRepository extends GetxController {
  static SpecialistRepository get instance => Get.find();

  ///Firestore instance for database interactions
  final _db = FirebaseFirestore.instance;

  ///Get all specialists
  Future<List<SpecialistModel>> getAllSpecialists() async {
    try {
      final snapshot = await _db.collection('Specialists').get();
      return snapshot.docs.map((e) => SpecialistModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw ('Firebase Exception : $e');
    } on PlatformException catch (e) {
      throw ('Platform Exception : $e');
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  /// Add a new specialist to the Firestore database
  Future<void> addSpecialist(SpecialistModel specialist) async {
    try {
      await _db.collection('Specialists').add(specialist.toJson());
    } on FirebaseException catch (e) {
      throw ('Firebase Exception : $e');
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
}
