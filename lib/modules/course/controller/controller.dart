import 'dart:developer';

import 'package:get/get.dart';
import 'package:tailored/modules/course/models/material_course.dart';

import '../api/course_apies.dart';
import '../models/course.dart';

class CourseController extends GetxController {
  var courses = [].obs;
  var courseMaterial = [].obs;
  var courseNextMaterial = [].obs;
  String matchId = '';
  var isLoading = true.obs;
  bool _isAnswered = false;
  bool isTextFiledAnswered = false;

  bool get isAnswered => _isAnswered;

  late var _correctAnswer;
  get correctAnswer => _correctAnswer;

  late var _selectedAnswer;
  get selectedAnswer => _selectedAnswer;

  late String questionId;

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      isLoading.value = true;
      final response = await getCourseList();
      courses.value =
          response.map((courseData) => Course.fromJson(courseData)).toList();
      isLoading.value = false;
      log('get courses successfully');
    } catch (e) {
      log('get courses has error with $e');
    }
  }

  fetchCourseMaterial() async {
    try {
      isLoading.value = true;
      final response = await getCourseMaterials();
      isLoading.value = false;
      log(response.toString());
      log('get CourseMaterial successfully');
      courseMaterial.value = response
          .map((courseData) => CourseMaterial.fromJson(courseData))
          .toList();
    } catch (e) {
      log('get CourseMaterial has error with $e');
    }
  }

  fetchNextCourseMaterial() async {
    try {
      isLoading.value = true;
      final response = await getCourseNextMaterial();
      isLoading.value = false;
      log(response.toString());
      log('get NextCourseMaterial successfully');
      courseNextMaterial.value = response
          .map((courseData) => CourseMaterial.fromJson(courseData))
          .toList();
    } catch (e) {
      log('get NextCourseMaterial has error with $e');
    }
  }

  bool isCorrectAnswer(var userAnswer, var correctAnswer) {
    return userAnswer == correctAnswer;
  }

  void checkOptionAnswer(CourseMaterial courseMaterial, var selectedAnswer) {
    try {
      matchId = courseMaterial.id;
      // because once user press any option then it will run
      _isAnswered = true;
      _correctAnswer = courseMaterial.question?.answer[0].toString();
      _selectedAnswer = selectedAnswer;
      print('answer selected is $selectedAnswer');
      print('answer correct is $_correctAnswer');
      update();
    //  _isAnswered = false;
    } catch (e) {
      log('error when answer is $e');
    }

    // if (_correctAnswer == _selectedAnswer) {}
    // // _numOfCorrectAnswers++;
  }

  void checkTextFieldAnswer(CourseMaterial courseMaterial, var answer) {
    try {
      matchId = courseMaterial.id;
      // because once user press any option then it will run
      _isAnswered = true;
      isTextFiledAnswered=true;
      _correctAnswer = courseMaterial.question?.answer[0].toString();
      _selectedAnswer = answer;
      print('answer selected is $selectedAnswer');
      print('answer correct is $_correctAnswer');
      update();
      // _isAnswered = false;
      //_isAnswered = false;
      //isTextFiledAnswered=false;


      //  _isAnswered = false;
    } catch (e) {
      log('error when answer is $e');
    }

    // if (_correctAnswer == _selectedAnswer) {}
    // // _numOfCorrectAnswers++;
  }

  cancelIsAnswered(){
          _isAnswered = false;
      isTextFiledAnswered=false;
  }
}
