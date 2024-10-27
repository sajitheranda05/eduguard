import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/std_detection/models/std_model.dart';
import 'package:eduguard/src/features/std_detection/models/symptom_model.dart';
import 'package:eduguard/src/features/std_detection/wigets/symptom_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class STDView extends StatelessWidget {
  const STDView({super.key, required this.std, required this.symptoms});

  final STDModel std;
  final List<SymptomModel> symptoms;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(
          title: Text(
            std.stdName,
            style: const TextStyle(fontSize: 18.0),
          ),
          showBackArrow: true, // Show the back arrow
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xfff6faf9),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 2 / 1, // 2:1 ratio
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the radius as needed
                                    child: Image.network(
                                      std.stdImg,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        std.caption,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 10,
                                            color: Color(0xff9fa2a2),
                                            fontFamily: 'Poppins-Regular',
                                            fontWeight: FontWeight.normal),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                child: Text(
                                  'About',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 14,
                                      color: Color(0xff1e2425),
                                      fontFamily: 'Poppins-Medium',
                                      fontWeight: FontWeight.normal),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      std.stdDescription,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 12,
                                          color: Color(0xff9fa2a2),
                                          fontFamily: 'Poppins-Regular',
                                          fontWeight: FontWeight.normal),
                                      maxLines: 100,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                child: Text(
                                  'Symptoms',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 14,
                                      color: Color(0xff1e2425),
                                      fontFamily: 'Poppins-Medium',
                                      fontWeight: FontWeight.normal),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 5),
                              /*SizedBox(
                                // width: 321,
                                child: Text(
                                  std.stdSymptoms,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 12,
                                    color: Color(0xff9fa2a2),
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.normal,
                                  ),
                                  maxLines: 100,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),*/

                              // Update the GridView to display symptoms
                              GridView.builder(
                                itemCount: std.stdSymptoms?.length ??
                                    0, // Using std.stdSymptoms to determine the count
                                shrinkWrap:
                                    true, // Adjusts the grid to fit its content
                                physics:
                                    const NeverScrollableScrollPhysics(), // Disables grid scrolling
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent:
                                      185, // Fixed height of each grid item
                                  crossAxisSpacing: 10, // Space between columns
                                  mainAxisSpacing: 10, // Space between rows
                                ),
                                itemBuilder: (_, index) {
                                  final symptom = std.stdSymptoms![
                                      index]; // Accessing the symptom from std.stdSymptoms
                                  return SymptomCard(
                                    symptomImg: symptom
                                        .symptomImg, // Use the property for the image URL
                                    symptomName: symptom
                                        .symptomName, // Use the property for the name
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                // width: 321,
                                child: Text(
                                  'Transmission',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 14,
                                      color: Color(0xff1e2425),
                                      fontFamily: 'Poppins-Medium',
                                      fontWeight: FontWeight.normal),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                // width: 321,
                                child: Text(
                                  std.stdTransmission,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 12,
                                    color: Color(0xff9fa2a2),
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.normal,
                                  ),
                                  maxLines: 100,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                child: Text(
                                  'Prevention Methods',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 14,
                                      color: Color(0xff1e2425),
                                      fontFamily: 'Poppins-Medium',
                                      fontWeight: FontWeight.normal),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                // width: 321,
                                child: Text(
                                  std.stdPrevention,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 12,
                                    color: Color(0xff9fa2a2),
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.normal,
                                  ),
                                  maxLines: 100,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: TextButton(
                        onPressed: () => launchUrl(Uri.parse(std.externalURL)),
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
                          minimumSize: const Size(200, 40), // Button size
                        ),
                        child: const Text(
                          'Read more about this STD',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins-Medium',
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    )
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
