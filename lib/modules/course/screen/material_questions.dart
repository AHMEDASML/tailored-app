import 'package:flutter/material.dart';
import 'package:tailored/modules/course/models/material_course.dart';
import 'package:tailored/modules/course/widget/quesation_card.dart';
import 'package:tailored/utilities/color_manager.dart';

class MaterialQuestionsPage extends StatelessWidget {
  const MaterialQuestionsPage(
      {super.key, required this.question, required this.courseMaterial});
  final Question question;
  final CourseMaterial courseMaterial;

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: QuestionCard(
            question: question.text,
            materialCourse: courseMaterial,
            type: question.type,
            options: question.options),
      ),
    );
  }
}
