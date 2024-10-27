import 'package:eduguard/src/data/repositories/std_detection/std_repository.dart';
import 'package:eduguard/src/features/std_detection/models/std_model.dart';
import 'package:eduguard/src/features/std_detection/models/symptom_model.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class STDController extends GetxController {
  static STDController get instance => Get.find();

  final isLoading = true.obs;
  final stdRepository = Get.put(STDRepository());

  final RxList<STDModel> featuredSTDs = <STDModel>[].obs;
  final RxList<STDModel> allSTDs = <STDModel>[].obs;
  final RxList<STDModel> paginatedSTDs = <STDModel>[].obs;

  final int itemsPerPage = 6;
  final RxInt currentPage = 0.obs;

  // Reactive variable for search query
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    fetchFeaturedSTDs();
    fetchPaginatedSTDs();
    super.onInit();
  }

//load stds
  Future<void> fetchFeaturedSTDs() async {
    try {
      //show loader while loading stds
      isLoading.value = true;

      //Fetch STDs
      final stds = await stdRepository.getAllSTDs();
      //Assign STDs
      allSTDs.assignAll(stds);

      featuredSTDs
          .assignAll(allSTDs.where((std) => std.isCommon ?? false).take(2));
    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Oops!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Load paginated STDs for the list page
  Future<void> fetchPaginatedSTDs() async {
    try {
      isLoading.value = true;
      final stds = await stdRepository.getAllSTDs();
      allSTDs.assignAll(stds);

      paginateSTDs();
    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Oops!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Helper function to paginate the STDs
  void paginateSTDs() {
    final startIndex = currentPage.value * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    // Ensure the end index doesn't exceed the total number of STDs
    paginatedSTDs.assignAll(allSTDs.sublist(
        startIndex, endIndex > allSTDs.length ? allSTDs.length : endIndex));
  }

  // Navigate to the next page
  void nextPage() {
    if ((currentPage.value + 1) * itemsPerPage < allSTDs.length) {
      currentPage.value++;
      paginateSTDs();
    }
  }

  // Navigate to the previous page
  void prevPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
      paginateSTDs();
    }
  }

  // Global key for the form
  final GlobalKey<FormState> stdFormKey = GlobalKey<FormState>();
// Reactive variables to hold user inputs
  final stdName = ''.obs;
  final caption = ''.obs;
  final stdDescription = ''.obs;
  final websiteUrl = ''.obs;
  final stdImageUrl = ''.obs; // For image URL
  final stdPrevention = ''.obs;
  final stdTransmission = ''.obs;
  final isCommon = false.obs;
  final List<SymptomModel> symptoms = <SymptomModel>[].obs; // List of symptoms

  Future<void> addSTD() async {
    if (!stdFormKey.currentState!.validate()) {
      return;
    }
    try {
      final stdModel = STDModel(
        stdId: '',
        stdImg: stdImageUrl.value,
        caption: caption.value,
        stdName: stdName.value,
        stdDescription: stdDescription.value,
        externalURL: websiteUrl.value,
        isCommon: isCommon.value,
        stdSymptoms: symptoms, // Include symptoms
        stdPrevention: stdPrevention.value,
        stdTransmission: stdTransmission.value,
      );

      await stdRepository.addSTD(stdModel);
      // Show success message
      AppSnackBars.successSnackBar(
          title: 'Success', message: 'STD added successfully!');

      // Clear the form lists after successful addition
      symptoms.clear();

      // Optionally, you can clear other form fields as well
      stdImageUrl.value = '';
      caption.value = '';
      stdName.value = '';
      stdDescription.value = '';
      websiteUrl.value = '';
      stdPrevention.value = '';
      stdTransmission.value = '';
      isCommon.value = false;
    } catch (e) {
      AppSnackBars.errorSnackBar(title: 'Oops!', message: e.toString());
    }
  }

  void addSymptom(String symptomName, String symptomImg) {
    final symptom = SymptomModel(
      symptomId: '', // Generate or assign as needed
      symptomName: symptomName,
      symptomImg: symptomImg,
    );
    symptoms.add(symptom);
  }

  // Method to clear the form
  void clearForm() {
    stdFormKey.currentState?.reset(); // Reset form fields
    stdImageUrl.value = '';
    caption.value = '';
    stdName.value = '';
    stdDescription.value = '';
    websiteUrl.value = '';
    stdPrevention.value = '';
    stdTransmission.value = '';
    isCommon.value = false;

    // Clear the clinics and qualifications lists
    symptoms.clear();

    // Optionally, show a message indicating the form has been cleared
    Get.snackbar(
      'Form Cleared',
      'All fields and lists have been reset.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

// Method to filter the paginated STDs based on the search query
  void filterSTDs() {
    if (searchQuery.value.isEmpty) {
      paginateSTDs(); // Show all STDs if search is empty
    } else {
      paginatedSTDs.assignAll(allSTDs.where((std) =>
          std.stdName.toLowerCase().contains(searchQuery.value.toLowerCase())));
    }
  }

  // Update the search query and filter the list
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterSTDs();
  }
}
