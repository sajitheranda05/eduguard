import 'package:eduguard/src/data/repositories/std_detection/specialist_repository.dart';
import 'package:eduguard/src/features/std_detection/models/clinic_model.dart';
import 'package:eduguard/src/features/std_detection/models/qualification_model.dart';
import 'package:eduguard/src/features/std_detection/models/specialist_model.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecialistController extends GetxController {
  static SpecialistController get instance => Get.find();

  final isLoading = true.obs;
  final specialistRepository = Get.put(SpecialistRepository());

  final RxList<SpecialistModel> popularSpecialists = <SpecialistModel>[].obs;
  final RxList<SpecialistModel> allSpecialists = <SpecialistModel>[].obs;
  final RxList<SpecialistModel> paginatedSpecialists = <SpecialistModel>[].obs;

  final int itemsPerPage = 6;
  final RxInt currentPage = 0.obs;

  // Reactive variable for search query
  final RxString searchQuery = ''.obs;

// Form key and other Rx fields for form inputs
  final GlobalKey<FormState> specialistFormKey = GlobalKey<FormState>();
  final RxString specialistImageUrl = ''.obs;
  final RxString specialistName = ''.obs;
  final RxString specialization = ''.obs;
  final RxString specialistAbout = ''.obs;
  final RxString years = ''.obs;
  final RxString specialistCity = ''.obs;
  final RxBool isPopular = false.obs;

  // Clinic and Qualification lists
  final RxList<ClinicModel> clinics = <ClinicModel>[].obs;
  final RxList<QualificationModel> qualifications = <QualificationModel>[].obs;

  @override
  void onInit() {
    fetchPopularSpecialists();
    fetchPaginatedSpecialists();
    super.onInit();
  }

  Future<void> fetchPopularSpecialists() async {
    try {
      //show loader while loading specialists
      isLoading.value = true;

      //Fetch STDs
      final specialists = await specialistRepository.getAllSpecialists();
      //Assign STDs
      allSpecialists.assignAll(specialists);
      popularSpecialists.assignAll(allSpecialists
          .where((specialist) => specialist.isPopular ?? false)
          .take(2));
    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Oops!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Load paginated STDs for the list page
  Future<void> fetchPaginatedSpecialists() async {
    try {
      isLoading.value = true;
      final specialists = await specialistRepository.getAllSpecialists();
      allSpecialists.assignAll(specialists);

      paginateSpecialists();
    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Oops!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Helper function to paginate the STDs
  void paginateSpecialists() {
    final startIndex = currentPage.value * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    // Ensure the end index doesn't exceed the total number of STDs
    paginatedSpecialists.assignAll(allSpecialists.sublist(startIndex,
        endIndex > allSpecialists.length ? allSpecialists.length : endIndex));
  }

  // Navigate to the next page
  void nextPage() {
    if ((currentPage.value + 1) * itemsPerPage < allSpecialists.length) {
      currentPage.value++;
      paginateSpecialists();
    }
  }

  // Navigate to the previous page
  void prevPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
      paginateSpecialists();
    }
  }

  /// Add a specialist to Firestore
  Future<void> addSpecialist() async {
    if (!specialistFormKey.currentState!.validate()) {
      return;
    }

    try {
      final specialist = SpecialistModel(
        specialistId: '', // Firestore will generate this.
        specialistImg: specialistImageUrl.value,
        specialistName: specialistName.value,
        specialization: specialization.value,
        specialistAbout: specialistAbout.value,
        years: years.value,
        specialistCity: specialistCity.value,
        isPopular: isPopular.value,
        specialistClinic: clinics,
        specialistQualifications: qualifications,
      );

      await specialistRepository.addSpecialist(specialist);

      // Show success messge
      AppSnackBars.successSnackBar(
          title: 'Success', message: 'Specialist added successfully!');

      // Clear the form lists after successful addition
      clinics.clear();
      qualifications.clear();

      // Optionally, you can clear other form fields as well
      specialistImageUrl.value = '';
      specialistName.value = '';
      specialization.value = '';
      specialistAbout.value = '';
      years.value = '';
      specialistCity.value = '';
      isPopular.value = false;
    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Oops!', message: e.toString());
    }
  }

  // Method to add clinic to the list
  void addClinic(
      String name, String phone, String address, String description) {
    clinics.add(ClinicModel(
      clinicId: '',
      clinicName: name,
      clinicPhone: phone,
      clinicAddress: address,
      clinicDescription: description,
    ));
  }

  // Method to add qualification to the list
  void addQualification(String campusName, String degree) {
    qualifications.add(QualificationModel(
      campusId: '',
      campusName: campusName,
      degree: degree,
    ));
  }

  // Method to clear the form
  void clearForm() {
    specialistFormKey.currentState?.reset(); // Reset form fields
    specialistImageUrl.value = '';
    specialistName.value = '';
    specialization.value = '';
    specialistAbout.value = '';
    years.value = '';
    specialistCity.value = '';
    isPopular.value = false;

    // Clear the clinics and qualifications lists
    clinics.clear();
    qualifications.clear();

    // Optionally, show a message indicating the form has been cleared
    Get.snackbar(
      'Form Cleared',
      'All fields and lists have been reset.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

// Method to filter the paginated STDs based on the search query
  void filterSpecialists() {
    if (searchQuery.value.isEmpty) {
      paginateSpecialists(); // Show all STDs if search is empty
    } else {
      paginatedSpecialists.assignAll(allSpecialists.where((specialist) =>
          specialist.specialistName
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()) ||
          specialist.specialistCity
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase())));
    }
  }

  // Update the search query and filter the list
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterSpecialists();
  }
}
