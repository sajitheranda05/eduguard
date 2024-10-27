import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/std_detection/controllers/specialist_controller.dart';
import 'package:eduguard/src/features/std_detection/screens/add_specialists.dart';
import 'package:eduguard/src/features/std_detection/wigets/specialist_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecialistsPage extends StatelessWidget {
  const SpecialistsPage({super.key});

  final String adminEmail = 'sithminavodhya0115@gmail.com';

  @override
  Widget build(BuildContext context) {
    final controller = SpecialistController.instance;

    // Retrieve the currently signed-in user's email
    User? user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(
            0xfff6faf9), // Set background color for the entire screen
        appBar: const CustomAppBar(
          title: Text(
            'Medical Specialists',
            style: TextStyle(fontSize: 18.0),
          ),
          showBackArrow: true, // Show the back arrow
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.all(20.0), // Optional: Add padding if needed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search bar container
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    border: Border.all(
                      color: const Color(0xffe8e8e8),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search_outlined,
                        color: Color(0xFFBFC5C6),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            controller.updateSearchQuery(value);
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 12,
                              color: Color(0xff9fa2a2),
                              fontFamily: 'Poppins-Regular',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Add New Specialist button (visible only to admin)
                if (user != null && user.email == adminEmail)
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => AddSpecialistForm());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xff0c6170), // Background color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(40), // Rounded corners
                            ),
                            minimumSize: const Size(160, 40), // Button size
                            padding: const EdgeInsets.all(
                                10), // Padding inside the button
                          ),
                          child: const Text(
                            'Add New Specialist',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: 'Poppins-Medium',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                // Specialist list
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(), // Loader widget
                    );
                  }
                  if (controller.paginatedSpecialists.isEmpty) {
                    return const Center(
                      child: Text('No data found'),
                    );
                  }
                  return GridView.builder(
                    itemCount: controller.paginatedSpecialists.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      mainAxisExtent: 110,
                    ),
                    itemBuilder: (_, index) {
                      final specialist = controller.paginatedSpecialists[index];
                      return SpecialistCard(specialist: specialist);
                    },
                  );
                }),
                const SizedBox(height: 15),
                // Pagination buttons
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: controller.prevPage,
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  Colors.transparent, // Transparent background
                              foregroundColor:
                                  const Color(0xff37be9d), // Text color
                              side: const BorderSide(
                                color: Color(0xff37be9d),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    40), // Rounded corners
                              ),
                              minimumSize: const Size(80, 35), // Button size
                            ),
                            child: const Text(
                              'Prev',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins-Medium',
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          const SizedBox(width: 40),
                          TextButton(
                            onPressed: controller.nextPage,
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  Colors.transparent, // Transparent background
                              foregroundColor:
                                  const Color(0xff37be9d), // Text color
                              side: const BorderSide(
                                color: Color(0xff37be9d),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    40), // Rounded corners
                              ),
                              minimumSize: const Size(80, 35), // Button size
                            ),
                            child: const Text(
                              'Next',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins-Medium',
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ],
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
