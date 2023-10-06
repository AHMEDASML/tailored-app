 class Course {
  String id;
  String name;
  String description;
  String image;
  String slug;
  bool isJoined;

 Course({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.slug,
    required this.isJoined,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      slug: json['slug'] as String,
      isJoined: json['is_joined'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'slug': slug,
      'isJoined': isJoined,
    };
  }

 }