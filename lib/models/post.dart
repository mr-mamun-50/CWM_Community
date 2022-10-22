// ignore_for_file: non_constant_identifier_names

import 'package:coding_with_mamun_community/models/user.dart';

class Post {
  int? id;
  String? body;
  String? image;
  String? createdAt;
  int? likes_count;
  int? comments_count;
  User? user;
  bool? selfLiked;

  Post({
    this.id,
    this.body,
    this.image,
    this.createdAt,
    this.likes_count,
    this.comments_count,
    this.user,
    this.selfLiked,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      body: json['body'],
      image: json['image'],
      createdAt: json['created_at'],
      likes_count: json['likes_count'],
      comments_count: json['comments_count'],
      selfLiked: json['likes'].length > 0,
      user: User(
        id: json['user']['id'],
        name: json['user']['name'],
        image: json['user']['image'],
        email: json['user']['email'],
      ),
    );
  }
}
