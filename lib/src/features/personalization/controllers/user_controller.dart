import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/data/repositories/user_repository.dart';
import 'package:eduguard/src/features/authentication/user/login/screens/user_login.dart';
import 'package:eduguard/src/features/authentication/user/register/models/user_model.dart';
import 'package:eduguard/src/features/personalization/screens/reauth_login.dart';
import 'package:eduguard/src/utils/network_manager.dart';
import 'package:eduguard/src/utils/popups/full_screen_loader.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController{
  static UserController get instance => Get.find();

  final profileLoading =false.obs;
  Rx<UserModel> user =UserModel.empty().obs;

  final hidePassword =false.obs;
  final verifyEmail =TextEditingController();
  final verifyPassword =TextEditingController();
  final userRepository =Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey =GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      final user =await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    }
  }

  //save user record for any registration provider(google, facebook)
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        final nameParts =UserModel.nameParts(userCredentials.user!.displayName ?? '');
        const age = '';

        final user =UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            age: age,
            email: userCredentials.user!.email ?? '',
            contactNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? ''
        );

        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      AppSnackBars.warningSnackBar(
          title: 'Data not saved',
          message: 'Something went wrong while saving your information. Please try again...'
      );
    }
  }

  //Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(24),
        title: 'Delete Account',
        middleText: 'Are you sure you want to delete your account permannently? This action is not reversible and all of your dara will be removed permanently.',
        confirm: ElevatedButton(
            onPressed: () async{
              deleteUseracount();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text('Delete'),
            )
        ),
        cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text('Cancel'),
        )
    );
  }

  void deleteUseracount() {
    try {
      AppFullScreenLoader.openLoadingDialog('Processing...');
      final auth =AuthenticationRepository.instance;
      final provider =auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        AppFullScreenLoader.stopLoading();
        Get.to(() => const ReAuthLoginForm());
      }
    } catch (e) {
      AppFullScreenLoader.stopLoading();
      AppSnackBars.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailandPasswordUser() async {
    try {
      AppFullScreenLoader.openLoadingDialog('Processing');

      //check network connectivity
      final isConnected =await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.reAuthenticateEmailandPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      AppFullScreenLoader.stopLoading();
      Get.offAll(() => const UserLogin());

    } catch (e) {
      AppFullScreenLoader.stopLoading();
      AppSnackBars.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

}