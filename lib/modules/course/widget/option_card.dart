import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tailored/modules/compitions/core/constants.dart';
import 'package:tailored/modules/course/controller/controller.dart';

class MyOption extends StatelessWidget {
  const MyOption({
    super.key,
    required this.onTap,
    this.index,
    this.desc,
    required this.option,
  });

  final VoidCallback onTap;
  final String option;
  final String? desc;
  final int? index;

  @override
  Widget build(BuildContext context) {
    // final CourseController questionController=Get.find();
    return GetBuilder<CourseController>(
        init: CourseController(),
        builder: (questionController) {
          Color getTheRightColor() {
            if (questionController.isAnswered) {
              if (option == questionController.correctAnswer) {
                return kGreenColor;
              } else if (option == questionController.selectedAnswer &&
                  questionController.selectedAnswer !=
                      questionController.correctAnswer) {
                return kRedColor;
              }
            }
            print('grey');
            return kGrayColor;
          }

          IconData getTheRightIcon() {
            return getTheRightColor() == kRedColor ? Icons.close : Icons.done;
          }

          return InkWell(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.only(top: kDefaultPadding),
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                border: Border.all(color: getTheRightColor()),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    index == null ? desc?? '' : "${index! + 1}. $option",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: getTheRightColor(), fontSize: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      color: getTheRightColor() == kGrayColor
                          ? Colors.transparent
                          : getTheRightColor(),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: getTheRightColor()),
                    ),
                    child: getTheRightColor() == kGrayColor
                        ? null
                        : Icon(getTheRightIcon(), size: 16),
                  )
                ],
              ),
            ),
          );
        });
  }
}

// getTheRightColor(bool? isCorrect) {
//   return isCorrect == null
//       ? kGrayColor
//       : isCorrect
//           ? kGreenColor
//           : kRedColor;
// }

//   IconData getTheRightIcon(isCorrect) {
//   return getTheRightColor(isCorrect) == kRedColor ? Icons.close : Icons.done;
// }

// Color getBorderColor(bool? isCorrect) {
//   return isCorrect == null
//       ? kGrayColor
//       : isCorrect
//           ? kGreenColor
//           : kRedColor;
// }

// Color getIconColor(bool? isCorrect) {
//   return getBorderColor(isCorrect);
// }

// IconData getIconData(bool? isCorrect) {
//   return getIconColor(isCorrect) == kRedColor ? Icons.close : Icons.done;
// }
