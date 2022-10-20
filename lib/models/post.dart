import 'package:coding_with_mamun_community/models/user.dart';

class Post {
  int? id;
  String? body;
  String? image;
  int? likes_cnt;
  int? comments_cnt;
  User? user;
  bool? selfLiked;

  Post({
    this.id,
    this.body,
    this.image,
    this.likes_cnt,
    this.comments_cnt,
    this.user,
    this.selfLiked,
  });
}
