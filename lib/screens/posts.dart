// ignore_for_file: use_build_context_synchronously

import 'package:coding_with_mamun_community/constant.dart';
import 'package:coding_with_mamun_community/models/api_response.dart';
import 'package:coding_with_mamun_community/models/post.dart';
import 'package:coding_with_mamun_community/screens/comments.dart';
import 'package:coding_with_mamun_community/screens/login.dart';
import 'package:coding_with_mamun_community/screens/post_form.dart';
import 'package:coding_with_mamun_community/services/post_service.dart';
import 'package:coding_with_mamun_community/services/user_service.dart';
import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<dynamic> _postList = [];
  int userId = 0;
  bool loading = true;

  Future<void> _getPosts() async {
    userId = await getUserId();
    ApiResponse apiResponse = await getPosts();

    if (apiResponse.error == null) {
      setState(() {
        _postList = apiResponse.data as List<dynamic>;
        loading = loading ? !loading : loading;
      });
    } else if (apiResponse.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${apiResponse.error}'),
      ));
      setState(() {
        loading = !loading;
      });
    }
  }

  //__Post like or dislike
  Future<void> _handlePostLikeUnlike(int postId) async {
    ApiResponse apiResponse = await likeUnlikePost(postId);

    if (apiResponse.error == null) {
      _getPosts();
    } else if (apiResponse.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${apiResponse.error}'),
      ));
    }
  }

  //__Post delete
  Future<void> _handleDelete(int postId) async {
    ApiResponse apiResponse = await deletePost(postId);

    if (apiResponse.error == null) {
      _getPosts();
    } else if (apiResponse.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${apiResponse.error}'),
      ));
    }
  }

  @override
  void initState() {
    _getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () => _getPosts(),
            child: ListView.builder(
              itemCount: _postList.length,
              itemBuilder: (BuildContext context, int index) {
                Post post = _postList[index];

                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          '${post.user!.name}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Text(
                            '${'${post.createdAt}'.substring(0, 10)} | ${'${post.createdAt}'.substring(11, 16)}'),
                        leading: CircleAvatar(
                            backgroundImage: post.user!.image == null
                                ? const NetworkImage(
                                    'https://www.pngitem.com/pimgs/m/130-1300253_female-user-icon-png-download-user-image-color.png')
                                : NetworkImage('${post.user!.image}')),
                        trailing: post.user!.id == userId
                            ? PopupMenuButton(
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Icon(Icons.more_vert),
                                ),
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Text('Edit'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ],
                                onSelected: (val) {
                                  if (val == 'edit') {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => PostForm(
                                                title: 'Edit Post',
                                                post: post)));
                                  } else if (val == 'delete') {
                                    _handleDelete(post.id ?? 0);
                                  }
                                },
                              )
                            : const SizedBox(),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(10),
                        child: Text('${post.body}'),
                      ),
                      post.image == null
                          ? const SizedBox()
                          : Container(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage('${post.image}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          likesCommentsBtn(
                            post.likes_count ?? 0,
                            post.selfLiked == true
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            post.selfLiked == true
                                ? Colors.red
                                : Colors.black54,
                            () {
                              _handlePostLikeUnlike(post.id ?? 0);
                            },
                          ),
                          Container(
                              height: 25, width: 0.5, color: Colors.black38),
                          likesCommentsBtn(
                            post.comments_count ?? 0,
                            Icons.comment,
                            Colors.black54,
                            () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      Comments(postId: post.id)));
                            },
                          ),
                          Container(
                              height: 25, width: 0.5, color: Colors.black38),
                          likesCommentsBtn(
                            null,
                            Icons.share,
                            Colors.black54,
                            () {},
                          )
                        ],
                      ),
                      const Divider(thickness: 2),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
