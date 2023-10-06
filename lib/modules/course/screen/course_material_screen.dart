import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tailored/modules/course/screen/material_questions.dart';
import 'package:tailored/modules/course/widget/content_item.dart';
import 'package:tailored/utilities/color_manager.dart';

import '../controller/controller.dart';

class CourseMaterialScreen extends StatefulWidget {
  final List courseMaterials;

  const CourseMaterialScreen({super.key, required this.courseMaterials});

  @override
  State<CourseMaterialScreen> createState() => _CourseMaterialScreenState();
}

class _CourseMaterialScreenState extends State<CourseMaterialScreen> {
  final CourseController courseController = Get.find<CourseController>();
  int currentPage = 0;
  late final PageController _pageController;

  void nextPage() {
    setState(() {
      if (currentPage >= widget.courseMaterials.length - 1) {
        currentPage = 0;
      } else {
        currentPage++;
      }
      if (_pageController.hasClients) {
        _pageController.jumpToPage(currentPage);
      }
    });
  }

  void previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
    }
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CourseController courseController = Get.find<CourseController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: Image.asset(
          "assets/images/logo.png",
          height: 70,
          width: 70,
          color: ColorManager.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'Course content',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w500,
                color: ColorManager.primary,
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemCount: widget.courseMaterials.length,
                itemBuilder: (context, indexOfPage) {
                  log('currentPage$currentPage');
                  log('indexOfPage$indexOfPage');

                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: widget
                                .courseMaterials[indexOfPage].content.length,
                            itemBuilder: (context, index) {
                              // log('indexOfContent$index');

                              return ContentItem(
                                  content: widget.courseMaterials[indexOfPage]
                                      .content[index]);
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (widget.courseMaterials[indexOfPage].question ==
                                    null ||
                                widget.courseMaterials[indexOfPage].question ==
                                    '') {
                              Fluttertoast.showToast(
                                msg: "No Question added for this material!!",
                                toastLength: Toast.LENGTH_SHORT,
                                // Duration of the toast (Toast.LENGTH_SHORT or Toast.LENGTH_LONG)
                                gravity: ToastGravity.BOTTOM,
                                // Location where the toast will appear (e.g., BOTTOM, TOP)
                                timeInSecForIosWeb: 1,
                                // Duration for iOS (ignored on Android)
                                backgroundColor: Colors.grey,
                                // Background color of the toast
                                textColor: Colors.white,
                                // Text color of the toast
                                fontSize:
                                    16.0, // Font size of the toast message
                              );
                            } else {
                              courseController.cancelIsAnswered();
                              Get.to(MaterialQuestionsPage(
                                  courseMaterial:
                                      widget.courseMaterials[indexOfPage],
                                  question: widget
                                      .courseMaterials[indexOfPage].question));
                            }
                          },
                          child: const Text(
                            'Answer Question Of this Material',
                            style: TextStyle(color: Colors.green, fontSize: 18),
                          ), // Replace with your button text
                        ),
                      ],
                    ),
                  );
                }),
          ),
          const Divider(),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    widget.courseMaterials.length,
                    (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _pageController.jumpToPage(index);
                                currentPage = index;
                              });
                            },
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Center(
                                  child: Text((index + 1).toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: index == currentPage
                                            ? Colors.black
                                            : Colors.white,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ))
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                widget.courseMaterials.length - 1 == currentPage
                    ? null
                    : nextPage();
              },
              child: Container(
                child: const Center(
                  child: Text(
                    'Get Next Material',
                    // widget.courseMaterials.length - 1 == currentPage
                    //     ? 'Get Questions Of Course '
                    //     : 'Get Next Material',
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
