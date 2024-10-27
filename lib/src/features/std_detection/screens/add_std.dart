import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eduguard/src/features/std_detection/controllers/std_controller.dart';
import 'package:eduguard/src/utils/validators/validations.dart';

class AddSTDForm extends StatelessWidget {
  AddSTDForm({super.key});

  final STDController controller = Get.put(STDController());
  final TextEditingController _symptomNameController = TextEditingController();
  final TextEditingController _symptomImgController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          'Add New STD',
          style: TextStyle(fontSize: 18.0),
        ),
        showBackArrow: true, // Show the back arrow
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.stdFormKey,
            child: Column(
              children: [
                // Image URL Input Field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Image URL',
                    floatingLabelBehavior:
                        FloatingLabelBehavior.always, // Label stays at the top
                    border:
                        UnderlineInputBorder(), // Keeping the bottom stroke design
                  ),
                  validator: (value) =>
                      AppValidations.validateEmptyText('STD Image', value),
                  onChanged: (value) => controller.stdImageUrl.value = value,
                ),

                const SizedBox(height: 10),

                // STD Caption
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Image Caption',
                    floatingLabelBehavior:
                        FloatingLabelBehavior.always, // Label stays at the top
                    border:
                        UnderlineInputBorder(), // Keeping the bottom stroke design
                  ),
                  validator: (value) =>
                      AppValidations.validateEmptyText('Caption', value),
                  onChanged: (value) => controller.caption.value = value,
                ),
                const SizedBox(height: 10),

                // STD Name
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'STD Name',
                    floatingLabelBehavior:
                        FloatingLabelBehavior.always, // Label stays at the top
                    border:
                        UnderlineInputBorder(), // Keeping the bottom stroke design
                  ),
                  validator: (value) =>
                      AppValidations.validateEmptyText('STD Name', value),
                  onChanged: (value) => controller.stdName.value = value,
                ),

                const SizedBox(height: 10), // Adding 10px gap between inputs

                // STD Description
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'STD Description',
                    floatingLabelBehavior:
                        FloatingLabelBehavior.always, // Label stays at the top
                    border:
                        UnderlineInputBorder(), // Keeping the bottom stroke design
                  ),
                  minLines: 1, // Minimum lines when idle
                  maxLines: 3, // Expands to 3 lines when focused
                  validator: (value) =>
                      AppValidations.validateEmptyText('Description', value),
                  onChanged: (value) => controller.stdDescription.value = value,
                ),

                const SizedBox(height: 10), // Adding 10px gap between inputs

                // Transmission Methods
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Transmission Methods',
                    floatingLabelBehavior:
                        FloatingLabelBehavior.always, // Label stays at the top
                    border:
                        UnderlineInputBorder(), // Keeping the bottom stroke design
                  ),
                  minLines: 1, // Minimum lines when idle
                  maxLines: 3, // Expands to 3 lines when focused
                  validator: (value) => AppValidations.validateEmptyText(
                      'Transmission Methods', value),
                  onChanged: (value) =>
                      controller.stdTransmission.value = value,
                ),

                const SizedBox(height: 10), // Adding 10px gap between inputs

                // Prevention Methods
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Prevention Methods',
                    floatingLabelBehavior:
                        FloatingLabelBehavior.always, // Label stays at the top
                    border:
                        UnderlineInputBorder(), // Keeping the bottom stroke design
                  ),
                  minLines: 1, // Minimum lines when idle
                  maxLines: 3, // Expands to 3 lines when focused
                  validator: (value) => AppValidations.validateEmptyText(
                      'Prevention Methods', value),
                  onChanged: (value) => controller.stdPrevention.value = value,
                ),

                const SizedBox(height: 10), // Gap after Prevention Methods
                //External Website URL

                TextFormField(
                  controller: _websiteController,
                  decoration: const InputDecoration(
                    labelText: 'External Website URL',
                    floatingLabelBehavior:
                        FloatingLabelBehavior.always, // Label stays at the top
                  ),
                  keyboardType: TextInputType.url,
                  validator: (value) =>
                      AppValidations.validateEmptyText('URL', value),
                  onChanged: (value) => controller.websiteUrl.value = value,
                ),

                const SizedBox(height: 20),

                // Symptoms Section
                Container(
                  padding: const EdgeInsets.all(
                      10.0), // 10px padding inside the container
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        10), // Rounded corners with 10px radius
                    border: Border.all(
                        color: const Color(0xffE9E9E9),
                        width: 1), // Light grey outline
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Symptoms',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Symptom Name Field
                      TextFormField(
                        controller: _symptomNameController,
                        decoration: const InputDecoration(
                          labelText: 'Symptom Name',
                          floatingLabelBehavior: FloatingLabelBehavior
                              .always, // Label stays at the top
                        ),
                      ),

                      const SizedBox(height: 10), // 10px gap between items

                      // Symptom Image URL Field
                      TextFormField(
                        controller: _symptomImgController,
                        decoration: const InputDecoration(
                          labelText: 'Symptom Image URL',
                          floatingLabelBehavior: FloatingLabelBehavior
                              .always, // Label stays at the top
                        ),
                      ),

                      const SizedBox(height: 20), // 10px gap between items

                      // Add Symptom Button (Styled as per the Next Button)
                      Align(
                        alignment: Alignment
                            .centerRight, // Aligns the button to the right
                        child: TextButton(
                          onPressed: () {
                            if (_symptomNameController.text.isNotEmpty &&
                                _symptomImgController.text.isNotEmpty) {
                              controller.addSymptom(
                                _symptomNameController.text,
                                _symptomImgController.text,
                              );
                              _symptomNameController.clear();
                              _symptomImgController.clear();
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Colors.transparent, // Transparent background
                            foregroundColor:
                                const Color(0xff37be9d), // Text color
                            side: const BorderSide(
                              color: Color(0xff37be9d), // Border color
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(40), // Rounded corners
                            ),
                            minimumSize: const Size(80, 40), // Button size
                          ),
                          child: const Text(
                            'Add Symptom',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins-Medium',
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                          height: 10), // 10px gap before symptom list

                      // List of Added Symptoms
                      Obx(() {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.symptoms.length,
                          itemBuilder: (context, index) {
                            final symptom = controller.symptoms[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10.0), // 10px gap between items
                              child: Container(
                                padding: const EdgeInsets.all(
                                    0.0), // Padding inside each symptom item
                                decoration: BoxDecoration(
                                  color: const Color(
                                      0xffDBF5F0), // Light green background for symptoms
                                  borderRadius: BorderRadius.circular(
                                      20), // Rounded corners for items
                                ),
                                child: ListTile(
                                  title: Text(symptom.symptomName),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),

                const SizedBox(height: 20), // Gap after symptoms section

                // Most Common STD Checkbox
                Obx(() {
                  return Row(
                    children: [
                      Checkbox(
                        value: controller.isCommon.value,
                        onChanged: (value) =>
                            controller.isCommon.value = value!,
                      ),
                      const Text('Is this a common STD ?'),
                    ],
                  );
                }),

                const SizedBox(height: 20), // Adding gap before Submit button
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly, // Space buttons evenly
                  children: [
                    // Clear Form Button
                    ElevatedButton(
                      onPressed: () {
                        controller
                            .clearForm(); // Call the function to reset the form
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                            0xFF9FA2A3), // Use grey color to indicate 'clear'
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

                    // Add STD Button
                    Align(
                      alignment: Alignment
                          .centerRight, // Aligns the button to the right
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.stdFormKey.currentState!.validate()) {
                            if (controller.symptoms.isEmpty) {
                              Get.snackbar(
                                'Validation Error',
                                'You must add at least one symptom',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            } else {
                              controller.addSTD();
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
                          'Add STD',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: 'Poppins-Medium',
                            fontWeight: FontWeight.normal,
                          ),
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
}
