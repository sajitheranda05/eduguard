import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/std_detection/controllers/specialist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eduguard/src/utils/validators/validations.dart';

class AddSpecialistForm extends StatelessWidget {
  AddSpecialistForm({super.key});

  final SpecialistController controller = Get.put(SpecialistController());
  final TextEditingController _clinicNameController = TextEditingController();
  final TextEditingController _clinicPhoneController = TextEditingController();
  final TextEditingController _clinicAddressController =
      TextEditingController();
  final TextEditingController _clinicDescriptionController =
      TextEditingController();
  final TextEditingController _campusNameController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          'Add New Specialist',
          style: TextStyle(fontSize: 18.0),
        ),
        showBackArrow: true, // Show the back arrow
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.specialistFormKey,
            child: Column(
              children: [
                // Specialist Image URL
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Specialist Image URL',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) => AppValidations.validateEmptyText(
                      'Specialist Image', value),
                  onChanged: (value) =>
                      controller.specialistImageUrl.value = value,
                ),
                const SizedBox(height: 10),

                // Specialist Name
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Specialist Name',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) => AppValidations.validateEmptyText(
                      'Specialist Name', value),
                  onChanged: (value) => controller.specialistName.value = value,
                ),
                const SizedBox(height: 10),

                // Specialist City
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'City',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) =>
                      AppValidations.validateEmptyText('City', value),
                  onChanged: (value) => controller.specialistCity.value = value,
                ),
                const SizedBox(height: 10),

                // Specialist Specialization
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Specialization',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) =>
                      AppValidations.validateEmptyText('Specialization', value),
                  onChanged: (value) => controller.specialization.value = value,
                ),
                const SizedBox(height: 10),

                // Specialist experience
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Years of Experience',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) => controller.years.value = value,
                ),
                const SizedBox(height: 10),

                // Specialist About
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'About Specialist',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  minLines: 1,
                  maxLines: 3,
                  validator: (value) =>
                      AppValidations.validateEmptyText('About', value),
                  onChanged: (value) =>
                      controller.specialistAbout.value = value,
                ),
                const SizedBox(height: 20),

                // Clinics Section
                _buildClinicsSection(),

                const SizedBox(height: 20),

                // Qualifications Section
                _buildQualificationsSection(),

                const SizedBox(height: 20),

                // Popular Checkbox
                Obx(() {
                  return Row(
                    children: [
                      Checkbox(
                        value: controller.isPopular.value,
                        onChanged: (value) =>
                            controller.isPopular.value = value!,
                      ),
                      const Text('Is this specialist popular?'),
                    ],
                  );
                }),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // Space evenly between buttons
                  children: [
                    // Clear Form Button
                    ElevatedButton(
                      onPressed: () {
                        controller
                            .clearForm(); // Call the function to reset the form
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                            0xFF9FA2A3), // Use red color to indicate 'clear'
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(40), // Rounded corners
                        ),
                        minimumSize: const Size(140, 40), // Button size
                        padding: const EdgeInsets.all(
                            10), // Padding inside the button
                      ),
                      child: const Text(
                        'Clear Form',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),

                    // Add Specialist Button
                    ElevatedButton(
                      onPressed: () {
                        if (controller.specialistFormKey.currentState!
                            .validate()) {
                          if (controller.clinics.isEmpty) {
                            Get.snackbar(
                              'Validation Error',
                              'You must add at least one clinic',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          } else if (controller.qualifications.isEmpty) {
                            Get.snackbar(
                              'Validation Error',
                              'You must add at least one qualification',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          } else {
                            controller.addSpecialist();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xff0c6170), // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(40), // Rounded corners
                        ),
                        minimumSize: const Size(140, 40), // Button size
                        padding: const EdgeInsets.all(
                            10), // Padding inside the button
                      ),
                      child: const Text(
                        'Add Specialist',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClinicsSection() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xffE9E9E9), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Clinics',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins-Medium',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _clinicNameController,
            decoration: const InputDecoration(
              labelText: 'Clinic Name',
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _clinicPhoneController,
            decoration: const InputDecoration(
              labelText: 'Clinic Phone',
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _clinicAddressController,
            decoration: const InputDecoration(
              labelText: 'Clinic Address',
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            minLines: 1,
            maxLines: 3,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _clinicDescriptionController,
            decoration: const InputDecoration(
              labelText: 'Clinic Description',
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(height: 20),
          // Add Clinic Button
          Align(
            alignment: Alignment.centerRight, // Aligns the button to the right
            child: TextButton(
              onPressed: () {
                if (_clinicNameController.text.isNotEmpty &&
                    _clinicPhoneController.text.isNotEmpty &&
                    _clinicAddressController.text.isNotEmpty &&
                    _clinicDescriptionController.text.isNotEmpty) {
                  // Add clinic to the list
                  controller.addClinic(
                    _clinicNameController.text,
                    _clinicPhoneController.text,
                    _clinicAddressController.text,
                    _clinicDescriptionController.text,
                  );
                  _clinicNameController.clear();
                  _clinicPhoneController.clear();
                  _clinicAddressController.clear();
                  _clinicDescriptionController.clear();
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: const Color(0xff37be9d),
                side: const BorderSide(
                  color: Color(0xff37be9d),
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                minimumSize: const Size(120, 40),
              ),
              child: const Text(
                'Add Clinic',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins-Medium',
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // List of Added Clinics
          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.clinics.length,
              itemBuilder: (context, index) {
                final clinic = controller.clinics[index];
                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10.0), // 10px gap between items
                  child: Container(
                    padding: const EdgeInsets.all(
                        0.0), // Padding inside each clinic item
                    decoration: BoxDecoration(
                      color: const Color(
                          0xffDBF5F0), // Light green background for clinics
                      borderRadius: BorderRadius.circular(
                          20), // Rounded corners for items
                    ),
                    child: ListTile(
                      title: Text(clinic.clinicName), // Display clinic name
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildQualificationsSection() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xffE9E9E9), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Qualifications',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins-Medium',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _campusNameController,
            decoration: const InputDecoration(
              labelText: 'Campus Name',
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _degreeController,
            decoration: const InputDecoration(
              labelText: 'Degree',
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(height: 20),
          // Add Qualification Button
          Align(
            alignment: Alignment.centerRight, // Aligns the button to the right
            child: TextButton(
              onPressed: () {
                if (_campusNameController.text.isNotEmpty &&
                    _degreeController.text.isNotEmpty) {
                  // Add qualification to the list
                  controller.addQualification(
                    _campusNameController.text,
                    _degreeController.text,
                  );
                  _campusNameController.clear();
                  _degreeController.clear();
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: const Color(0xff37be9d),
                side: const BorderSide(
                  color: Color(0xff37be9d),
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                minimumSize: const Size(80, 40),
              ),
              child: const Text(
                'Add Qualification',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins-Medium',
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // List of Added Qualifications
          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.qualifications.length,
              itemBuilder: (context, index) {
                final qualification = controller.qualifications[index];
                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10.0), // 10px gap between items
                  child: Container(
                    padding: const EdgeInsets.all(
                        0.0), // Padding inside each qualification item
                    decoration: BoxDecoration(
                      color: const Color(
                          0xffDBF5F0), // Light green background for qualifications
                      borderRadius: BorderRadius.circular(
                          20), // Rounded corners for items
                    ),
                    child: ListTile(
                      title:
                          Text(qualification.campusName), // Display campus name
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
