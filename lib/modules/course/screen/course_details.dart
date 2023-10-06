import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tailored/modules/course/screen/course_material_screen.dart';
import 'package:tailored/utilities/color_manager.dart';

import '../controller/controller.dart';
import '../models/course.dart';

class CourseDetailsScreen extends StatelessWidget {
  final CourseController courseController = Get.find();
  final String courseId;

  CourseDetailsScreen({super.key, required this.courseId});

// Get.to(CourseDetailsScreen(courseId: 'YOUR_COURSE_ID'));

  @override
  Widget build(BuildContext context) {
    final course = courseController.courses.firstWhere(
      (course) => course.id == courseId,
      orElse: () => Course(
          id: '',
          name: '',
          description: '',
          image: '',
          slug: '',
          isJoined: false), // Provide a default course if not found
    );

    return Scaffold(
      appBar: 
      
       AppBar(
        backgroundColor: ColorManager.primary,
        title: Image.asset(
          "assets/images/logo.png",
          height: 70,
          width: 70,
          color: ColorManager.white,
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.circle_notifications_outlined,
        //       color: ColorManager.white,
        //       size: 50,
        //     ),
        //     onPressed: () {},
        //   )
        // ],
      ),
   
   
   
   
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              course.name,
              style:   TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.5)),
            ),
            const SizedBox(height: 8),
            Text(
              course.description,
              style:  TextStyle(fontSize: 18,color:  Colors.black.withOpacity(0.5)),
            ),
            const SizedBox(height: 16),
            InkWell(
                onTap: () async {
                  log(courseController.courseMaterial.length.toString());
                  var courseMaterial =
                      await courseController.fetchCourseMaterial();
                  Get.to(() => CourseMaterialScreen(
                        courseMaterials: courseController.courseMaterial.value,
                      ));
                },
                child: Image.network(course.image)),
            const SizedBox(height: 16),
            Text(
              'Course ID: ${course.id}',
              style:   TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5)),
            ),
            const SizedBox(height: 16),
            Text(
              'Enrollment Status: ${course.isJoined ? 'Joined' : 'Not Joined'}',
              style:   TextStyle(fontSize: 16,color: Colors.black.withOpacity(0.5)),
            ),
          ],
        ),
      ),
    );
  }
}
