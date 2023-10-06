import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tailored/modules/compitions/core/constants.dart';
import 'package:tailored/modules/course/controller/controller.dart';
import 'package:tailored/modules/course/models/material_course.dart';
import 'package:tailored/modules/course/widget/option_card.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final String type;
  final CourseMaterial materialCourse;
  final List<dynamic> options;

  const QuestionCard({
    Key? key,
    required this.question,
    required this.materialCourse,
    required this.type,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    // final CourseController courseController = Get.find<CourseController>();

    return Center(
      child: GetBuilder<CourseController>(
          init: CourseController(),
          builder: (controller) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  if (type == 'TEXT') const Spacer(),
                  // if (matchMaterial.content[0].file != null)
                  //   Image.network(matchMaterial.content[0].file!),
                  Text(
                    question == '' ? 'NO question added ' : question,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: kBlackColor),
                  ),
                  if (type == 'TEXT') const Spacer(),
                  if (type != 'TAPPING' && type != 'MULTIPLE_CHOICE')
                    TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'أدخل الإجابة هنا',
                        hintStyle: const TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .blue, // Change this to your desired border color
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: kDefaultPadding / 2),
                  if (type == 'TAPPING' || type == 'MULTIPLE_CHOICE')
                    Expanded(
                      child: ListView.builder(
                        itemCount: options.length,
                        itemBuilder: (context, index) => MyOption(
                            index: index,
                            option: options[index].toString(),
                            onTap: () => controller.checkOptionAnswer(
                                materialCourse, options[index].toString())
                            // courseController.isAnswered  ?courseController.isCorrect :null ,
                            ),
                      ),
                    ),
                  // const Spacer(),
                  if (type != 'TAPPING' && type != 'MULTIPLE_CHOICE')
                    TextButton(
                        onPressed: () {
                          controller.checkTextFieldAnswer(
                              materialCourse, textController.text);
                        },
                        child: const Text('Submit')),
                  if (type != 'TAPPING' &&
                      type != 'MULTIPLE_CHOICE' &&
                      controller.isTextFiledAnswered)
                    MyOption(
                      onTap: () {},
                      desc:
                          'your answer is ${controller.correctAnswer == controller.selectedAnswer ? "correct " : " not correct \n this is the right answer ${controller.correctAnswer ?? 'no answer provided from server'}"}',
                      option: textController.text,
                    )
                ],
              ),
            );
          }),
    );
  }
}
