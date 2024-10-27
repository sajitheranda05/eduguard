import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/authentication/user/register/controllers/signup_controller.dart';
import 'package:eduguard/src/features/authentication/user/register/screens/email_verification.dart';
import 'package:eduguard/src/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSignUp extends StatelessWidget {
  const UserSignUp({super.key});

  @override
  Widget build(BuildContext context) {

    final signUpcontroller =Get.put(SignUpController());

    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [

              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('EduguardLK', style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),),
                  Text('SIGN IN', style: TextStyle(fontSize: 20.0))
                ],
              ),

              const SizedBox(height: 24.0),

              Form(
                  key: signUpcontroller.signupFormKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: signUpcontroller.firstName,
                              validator: (value) => AppValidations.validateEmptyText('First Name', value),
                              expands: false,
                              decoration: const InputDecoration(label: Text('First Name')),
                            ),
                          ),
                          const SizedBox(width: 24.0,),
                          Expanded(
                            child: TextFormField(
                              controller: signUpcontroller.lastName,
                              validator: (value) => AppValidations.validateEmptyText('Last name', value),
                              expands: false,
                              decoration: const InputDecoration(label: Text('Last Name')),
                            ),
                          ),
                        ],
                      ),

                      TextFormField(
                        controller: signUpcontroller.age,
                        validator: (value) => AppValidations.validateEmptyText('Age', value),
                        decoration: const InputDecoration(label: Text('Age')),
                      ),
                      const SizedBox(height: 12.0,),

                      TextFormField(
                        controller: signUpcontroller.email,
                        validator: (value) => AppValidations.validateEmail(value),
                        decoration: const InputDecoration(label: Text('Email')),
                      ),
                      const SizedBox(height: 12.0,),

                      TextFormField(
                        controller: signUpcontroller.contactNumber,
                        validator: (value) => AppValidations.validatePhoneNumber(value),
                        decoration: const InputDecoration(label: Text('Contact Number')),
                      ),
                      const SizedBox(height: 12.0,),

                      Obx(
                            () => TextFormField(
                          controller: signUpcontroller.password,
                          validator: (value) => AppValidations.validatePassword(value),
                          obscureText: signUpcontroller.hidePassword.value,
                          decoration: InputDecoration(
                            label: const Text('Password'),
                            suffixIcon: IconButton(
                                onPressed:() {
                                  signUpcontroller.hidePassword.value = !signUpcontroller.hidePassword.value;
                                },
                                icon: Icon(signUpcontroller.hidePassword.value ? Icons.visibility_off : Icons.visibility)
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0,),

                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 21,
                            child: Obx (
                                  ()=> Checkbox(
                                  value: signUpcontroller.termsCheck.value,
                                  onChanged: (value) => signUpcontroller.termsCheck.value = !signUpcontroller.termsCheck.value
                              ),
                            ),
                          ),
                          const SizedBox(width: 12.0,),
                          const Text('I agree to privacy policy and terms of use'),
                        ],
                      ),

                      const SizedBox(height: 24.0,),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            //Get.to(() => const EmailVerification());
                            signUpcontroller.signup();
                          },
                          child: const Text('Create Account'),
                        ),
                      ),

                    ],
                  ))
            ],
          ),
        ),

      ),
    );
  }
}
