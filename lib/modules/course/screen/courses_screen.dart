import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tailored/utilities/color_manager.dart';

import '../controller/controller.dart';
import '../models/course.dart';
import 'course_details.dart';

class CoursesScreen extends StatelessWidget {
  final CourseController courseController = Get.put(CourseController());

  CoursesScreen({super.key});

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
        actions: [
          IconButton(
            icon: Icon(
              Icons.circle_notifications_outlined,
              color: ColorManager.white,
              size: 50,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Obx(() {
        if (courseController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Courses',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.primary,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox.expand(
                  child: ListView.builder(
                    itemCount: courseController.courses.length,
                    itemBuilder: (context, index) {
                      final course = courseController.courses[index] as Course;

                      return CourseItem(course: course);
                    },
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}

class CourseItem extends StatelessWidget {
  final Course course;

  CourseItem({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CourseDetailsScreen(
                courseId: course.id,
              ),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  course.image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      course.description,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              course.isJoined
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.check_circle_outline, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
