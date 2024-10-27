import 'package:eduguard/src/common_widgets/Screens/circular_image.dart';
import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/features/personalization/controllers/user_controller.dart';
import 'package:eduguard/src/features/personalization/screens/user_profile.dart';
import 'package:eduguard/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer ({super.key});

  @override
  Widget build(BuildContext context) {
    final userController =UserController.instance;
    return Drawer(
      elevation: 5.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children:[
          UserAccountsDrawerHeader(
            accountName: Text(userController.user.value.fullName),
            accountEmail: Text(userController.user.value.email),
            currentAccountPicture: const CustomCircularImage(
              image: AppImages.userImage,
              width: 48,
              height: 48,
            ),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            onDetailsPressed: () {
              Get.to(() => const UserProfile());
            },
            arrowColor: Colors.black,
          ),

          ListTile(
            leading: Icon(Icons.home_rounded, color: Colors.teal[900],),
            title: const Text('Emergency SOS System'),
            onTap: () {
              //Get.to(() => const SOSHomePage());
            },
          ),

          ListTile(
            leading: const Icon(Icons.school_rounded),
            title: const Text('Education'),
            onTap: () {
              //Get.to(() => const TestPage());
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.manage_accounts_rounded),
            title: const Text('User Profile'),
            onTap: () {
              Get.to(() => const UserProfile());
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Logout'),
            onTap: () {
              AuthenticationRepository.instance.logout();
            },
          ),

        ],
      ),
    );
  }
}
