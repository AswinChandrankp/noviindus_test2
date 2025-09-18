class UserModel {
  int id;
  String uniqueId;
  String? name;
  String phone;
  String? image;
  int coins;
  dynamic credit;
  dynamic debit;

  UserModel({
    required this.id,
    required this.uniqueId,
    this.name,
    required this.phone,
    this.image,
    required this.coins,
    this.credit,
    this.debit,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        uniqueId: json['unique_id'],
        name: json['name'],
        phone: json['phone'],
        image: json['image'],
        coins: json['coins'],
        credit: json['credit'],
        debit: json['debit'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'unique_id': uniqueId,
        'name': name,
        'phone': phone,
        'image': image,
        'coins': coins,
        'credit': credit,
        'debit': debit,
      };
}

class Category {
  String id;
  String title;

  Category({required this.id, required this.title});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}

class FeedUser {
  int id;
  String name;
  String? image;

  FeedUser({
    required this.id,
    required this.name,
    this.image,
  });

  factory FeedUser.fromJson(Map<String, dynamic> json) => FeedUser(
        id: json['id'],
        name: json['name'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
      };
}

class FeedResult {
  int id;
  String description;
  String image;
  String video;
  List<int> likes;
  List<int> dislikes;
  List<int> bookmarks;
  List<int> hide;
  String createdAt;
  bool follow;
  FeedUser user;

  FeedResult({
    required this.id,
    required this.description,
    required this.image,
    required this.video,
    required this.likes,
    required this.dislikes,
    required this.bookmarks,
    required this.hide,
    required this.createdAt,
    required this.follow,
    required this.user,
  });

  factory FeedResult.fromJson(Map<String, dynamic> json) => FeedResult(
        id: json['id'],
        description: json['description'],
        image: json['image'],
        video: json['video'],
        likes: List<int>.from(json['likes']),
        dislikes: List<int>.from(json['dislikes']),
        bookmarks: List<int>.from(json['bookmarks']),
        hide: List<int>.from(json['hide']),
        createdAt: json['created_at'],
        follow: json['follow'],
        user: FeedUser.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'image': image,
        'video': video,
        'likes': likes,
        'dislikes': dislikes,
        'bookmarks': bookmarks,
        'hide': hide,
        'created_at': createdAt,
        'follow': follow,
        'user': user.toJson(),
      };
}

class HomeModel {
  UserModel user;
  List<dynamic> banners;
  List<Category> categoryDict;
  List<FeedResult> results;
  bool status;
  bool next;

  HomeModel({
    required this.user,
    required this.banners,
    required this.categoryDict,
    required this.results,
    required this.status,
    required this.next,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        user: UserModel.fromJson(json['user']),
        banners: List<dynamic>.from(json['banners']),
        categoryDict: List<Category>.from(
            json['category_dict'].map((x) => Category.fromJson(x))),
        results: List<FeedResult>.from(
            json['results'].map((x) => FeedResult.fromJson(x))),
        status: json['status'],
        next: json['next'],
      );

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'banners': banners,
        'category_dict': categoryDict.map((x) => x.toJson()).toList(),
        'results': results.map((x) => x.toJson()).toList(),
        'status': status,
        'next': next,
      };
}
