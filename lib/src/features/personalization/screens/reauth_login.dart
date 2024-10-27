import 'package:eduguard/src/features/personalization/controllers/user_controller.dart';
import 'package:eduguard/src/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final userController =UserController.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Re Authenticate User'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
              key: userController.reAuthFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24.0,),
                  TextFormField(
                    controller: userController.verifyEmail,
                    validator: (value) => AppValidations.validateEmail(value),
                    decoration: const InputDecoration(label: Text('Email')),
                  ),

                  Obx(
                        () => TextFormField(
                      controller: userController.verifyPassword,
                      validator: (value) => AppValidations.validatePassword(value),
                      obscureText: userController.hidePassword.value,
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        suffixIcon: IconButton(
                            onPressed:() {
                              userController.hidePassword.value = !userController.hidePassword.value;
                            },
                            icon: Icon(userController.hidePassword.value ? Icons.visibility_off : Icons.visibility)
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12.0,),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        userController.reAuthenticateEmailandPasswordUser();
                      },
                      child: const Text('Verify'),
                    ),
                  ),

                  const SizedBox(height: 12.0,),
                ],

              )
          ),
        ),
      ),
    );
  }
}