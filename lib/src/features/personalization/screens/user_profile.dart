import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/common_widgets/Screens/circular_image.dart';
import 'package:eduguard/src/common_widgets/Screens/profile_field.dart';
import 'package:eduguard/src/features/personalization/controllers/user_controller.dart';
import 'package:eduguard/src/features/personalization/screens/change_name.dart';
import 'package:eduguard/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final userController =UserController.instance;
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text('User Profile',style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            children: [

              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const CustomCircularImage(image: AppImages.userImage, width: 120, height: 120,),
                    TextButton(
                        onPressed: (){

                        },
                        child: const Text('Change Profile Picture')
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8.0,),
              const Divider(),

              const SizedBox(height: 8.0,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profile Information',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),

              const SizedBox(height: 8.0,),
              CustomProfileField(onPressed: () {}, title: 'userID', icon: Icons.copy, value: userController.user.value.id),
              CustomProfileField(onPressed: () {}, title: 'Email', value: userController.user.value.email),

              const SizedBox(height: 8.0,),
              const Divider(),
              const SizedBox(height: 8.0,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Personal Information',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),

              const SizedBox(height: 8.0,),
              CustomProfileField(onPressed: () {
                Get.to(() => const ChangeName());
              }, title: 'Name', value: userController.user.value.fullName),
              CustomProfileField(onPressed: () {}, title: 'Age', value: userController.user.value.age),
              CustomProfileField(onPressed: () {}, title: 'Contact Number', value: userController.user.value.contactNumber),
              CustomProfileField(onPressed: () {}, title: 'Gender', value: 'Male'),
              CustomProfileField(onPressed: () {}, title: 'Date of Birth', value: '12 Dec, 1999'),

              const SizedBox(height: 8.0,),
              const Divider(),
              const SizedBox(height: 8.0,),

              SizedBox(
                child: TextButton(
                    onPressed: () {
                      userController.deleteAccountWarningPopup();
                    },
                    child: const Text('Delete Account', style: TextStyle(color: Colors.red),)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}