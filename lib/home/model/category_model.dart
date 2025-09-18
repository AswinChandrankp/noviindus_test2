class CategoryModel {
  List<Categories>? categories;
  bool? status;

  CategoryModel({this.categories, this.status});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null && json['categories'] is List) {
      categories = (json['categories'] as List)
          .map((v) => Categories.fromJson(v as Map<String, dynamic>))
          .toList();
    } else {
      categories = [];
    }
    status = json['status'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (categories != null && categories!.isNotEmpty) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Categories {
  int? id;
  String? title;
  String? image;

  Categories({this.id, this.title, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'] as String?;
    image = json['image'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    return data;
  }
}