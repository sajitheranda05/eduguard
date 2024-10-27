import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/std_detection/controllers/specialist_controller.dart';
import 'package:eduguard/src/features/std_detection/controllers/std_controller.dart';
import 'package:eduguard/src/features/std_detection/screens/std_info.dart';
import 'package:eduguard/src/features/std_detection/screens/std_list.dart';
import 'package:eduguard/src/features/std_detection/screens/std_specialists.dart';
import 'package:eduguard/src/features/std_detection/wigets/specialist_card.dart';
import 'package:eduguard/src/features/std_detection/wigets/std_card.dart';
import 'package:eduguard/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class STDHomePage extends StatelessWidget {
  const STDHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(STDController());
    final controller2 = Get.put(SpecialistController());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const CustomAppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Matteo Perera...',
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              Text(
                'Sexual Health Platform',
                style: TextStyle(fontSize: 16.0),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xfff6faf9),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 0, top: 20, right: 0, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          top: 0,
                                          right: 20,
                                          bottom: 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'Most Common Diseases',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xff1e2425),
                                                          fontFamily:
                                                              'Poppins-Medium',
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(width: 71),
                                                    GestureDetector(
                                                      onTap: () => Get.to(
                                                          const STDListPage()),
                                                      child: const Text(
                                                        'See All',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontSize: 12,
                                                            color: Color(
                                                                0xff37be9d),
                                                            fontFamily:
                                                                'Poppins-Regular',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Obx(() {
                                            if (controller.isLoading.value) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(), // Loader widget
                                              );
                                            }
                                            if (controller
                                                .featuredSTDs.isEmpty) {
                                              return const Center(
                                                child: Text('No data found'),
                                              );
                                            }

                                            return GridView.builder(
                                              itemCount: controller
                                                  .featuredSTDs.length,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 10.0,
                                                crossAxisSpacing: 10.0,
                                                mainAxisExtent: 195,
                                              ),
                                              itemBuilder: (_, index) {
                                                final std = controller
                                                    .featuredSTDs[index];
                                                return STDCard(
                                                  std: std,
                                                );
                                              },
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xffd4e4e1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            'Do you suspect you have infected with STD ?',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontSize: 16,
                                                                color: Color(
                                                                    0xff1e2425),
                                                                fontFamily:
                                                                    'Poppins-Regular',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 15),
                                                    ElevatedButton(
                                                      onPressed: () => Get.to(
                                                          const STDInfo()),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xff0c6170), // Background color
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  40), // Rounded corners
                                                        ),
                                                        minimumSize: const Size(
                                                            140,
                                                            40), // Button size
                                                        padding: const EdgeInsets
                                                            .all(
                                                            10), // Padding inside the button
                                                      ),
                                                      child: const Text(
                                                        'Detect Now',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'Poppins-Medium',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Image.asset(
                                              AppImages.think,
                                              width: 120,
                                              height: 120,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          top: 0,
                                          right: 20,
                                          bottom: 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'Popular Medical Specialists',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xff1e2425),
                                                          fontFamily:
                                                              'Poppins-Medium',
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(width: 71),
                                                    GestureDetector(
                                                      onTap: () => Get.to(
                                                          const SpecialistsPage()),
                                                      child: const Text(
                                                        'See All',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xff37be9d),
                                                          fontFamily:
                                                              'Poppins-Regular',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Obx(() {
                                            if (controller.isLoading.value) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(), // Loader widget
                                              );
                                            }
                                            if (controller2
                                                .allSpecialists.isEmpty) {
                                              return const Center(
                                                child: Text('No data found'),
                                              );
                                            }
                                            return GridView.builder(
                                              itemCount: controller2
                                                  .popularSpecialists.length,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 1,
                                                mainAxisSpacing: 10.0,
                                                crossAxisSpacing: 10.0,
                                                mainAxisExtent: 110,
                                              ),
                                              itemBuilder: (_, index) {
                                                final specialist = controller2
                                                    .allSpecialists[index];
                                                return SpecialistCard(
                                                    specialist: specialist);
                                              },
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
        ),
      ),
    );
  }
}
