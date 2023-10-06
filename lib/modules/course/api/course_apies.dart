
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

const String baseUrl = 'https://tailored.meshka.space/api/v1/competition';
const token = 'TOKEN e6ab2a5283ad6bf1edbe15b20aac2ec30d9d4f94';

// Function to handle HTTP requests and responses
Future<dynamic> _apiRequest(String url,
    {String method = 'GET',
    Map<String, dynamic>? body,
    Map<String, String>? headers}) async {
  final response = method == 'GET'
      ? await http.get(Uri.parse(url),
          headers: headers ?? {'Authorization': token})
      : await http.post(Uri.parse(url),
          body: body, headers: headers ?? {'Authorization': token});

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to perform API request');
  }
}

Future<dynamic> getCourseMaterials() async {
  const url = "https://tailored.meshka.space/api/v1/content/courses/86xvmd8C58KJZtgp8e8gxg/materials/";
  final response = await _apiRequest(url, method: 'GET');
  return response;
}


Future<dynamic> joinCourse() async {
  const url = "https://tailored.meshka.space/api/v1/content/courses/86xvmd8C58KJZtgp8e8gxg/join/";
  final response = await _apiRequest(url, method: 'POST');
  return response;
}


Future<dynamic> getCourseDetail() async {
  const url = "https://tailored.meshka.space/api/v1/content/courses/86xvmd8C58KJZtgp8e8gxg/";
  final response = await _apiRequest(url, method: 'GET');
  return response;
}


Future<dynamic> getCourseList() async {
  const url = "https://tailored.meshka.space/api/v1/content/courses/";
  final response = await _apiRequest(url, method: 'GET');
  log(response.toString());
  return response;
}


Future<dynamic> getCourseNextMaterial() async {
  const url = "https://tailored.meshka.space/api/v1/content/courses/86xvmd8C58KJZtgp8e8gxg/materials/next/";
  final response = await _apiRequest(url, method: 'GET');
  return response;
}

Future<dynamic> getCourseMaterialDetail() async {
  const url = "https://tailored.meshka.space/api/v1/content/courses/86xvmd8C58KJZtgp8e8gxg/materials/3H6Eei6iHkzszH6kjmPcy2/";
  final response = await _apiRequest(url, method: 'GET');
  return response;
}

Future<dynamic> readCourseMaterialDetail() async {
  const url = "https://tailored.meshka.space/api/v1/content/courses/86xvmd8C58KJZtgp8e8gxg/materials/3H6Eei6iHkzszH6kjmPcy2/";
  final response = await _apiRequest(url, method: 'POST');
  return response;
}
