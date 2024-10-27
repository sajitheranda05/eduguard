import 'package:eduguard/src/data/repositories/user_repository.dart';
import 'package:eduguard/src/features/personalization/controllers/user_controller.dart';
import 'package:eduguard/src/features/personalization/screens/user_profile.dart';
import 'package:eduguard/src/utils/network_manager.dart';
import 'package:eduguard/src/utils/popups/full_screen_loader.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName =TextEditingController();
  final lastName =TextEditingController();
  final userController =UserController.instance;
  final userRepository =Get.put(UserRepository());
  GlobalKey<FormState> updateNameFormKey =GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initializeName();
  }

  Future<void> initializeName() async {
    firstName.text =userController.user.value.firstName;
    lastName.text =userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      AppFullScreenLoader.openLoadingDialog('We are updating your information...');

      //check network connectivity
      final isConnected =await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      if (!updateNameFormKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> name ={
        'FirstName' : firstName.text.trim(),
        'LastName' : lastName.text.trim()
      };
      await userRepository.updateSingleField(name);

      userController.user.value.firstName =firstName.text.trim();
      userController.user.value.lastName =lastName.text.trim();

      AppFullScreenLoader.stopLoading();

      AppSnackBars.successSnackBar(title: 'Congratulations', message: 'Your name has been updated');

      Get.off(() => const UserProfile());

    } catch (e) {
      AppFullScreenLoader.stopLoading();
      AppSnackBars.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

}