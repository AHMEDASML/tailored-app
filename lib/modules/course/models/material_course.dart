

import 'dart:convert';

List<CourseMaterial> courseMaterialFromJson(String str) => List<CourseMaterial>.from(json.decode(str).map((x) => CourseMaterial.fromJson(x)));

String courseMaterialToJson(List<CourseMaterial> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourseMaterial {
    String id;
    List<Content> content;
    Question? question;

    CourseMaterial({
        required this.id,
        required this.content,
        required this.question,
    });

    factory CourseMaterial.fromJson(Map<String, dynamic> json) => CourseMaterial(
        id: json["id"],
        content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        question: json["question"] == null ? null : Question.fromJson(json["question"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "question": question?.toJson(),
    };
}

class Content {
    String id;
    String type;
    String text;
    dynamic file;

    Content({
        required this.id,
        required this.type,
        required this.text,
        required this.file,
    });

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        type: json["type"],
        text: json["text"],
        file: json["file"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "text": text,
        "file": file,
    };
}

class Question {
    String id;
    String type;
    String text;
    List<dynamic> answer;
    List<dynamic> options;

    Question({
        required this.id,
        required this.text,
        required this.type,
        required this.answer,
        required this.options,
    });

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        type: json["type"],
        text: json["text"],
        answer: List<dynamic>.from(json["answer"].map((x) => x)),
        options: List<dynamic>.from(json["options"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "text": type,
        "answer": List<dynamic>.from(answer.map((x) => x)),
        "options": List<dynamic>.from(options.map((x) => x)),
    };
}
