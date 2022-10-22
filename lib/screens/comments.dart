// ignore_for_file: use_build_context_synchronously

import 'package:coding_with_mamun_community/constant.dart';
import 'package:coding_with_mamun_community/models/api_response.dart';
import 'package:coding_with_mamun_community/models/comment.dart';
import 'package:coding_with_mamun_community/screens/login.dart';
import 'package:coding_with_mamun_community/services/comment_service.dart';
import 'package:coding_with_mamun_community/services/user_service.dart';
import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  final int? postId;

  const Comments({
    super.key,
    this.postId,
  });

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  List<dynamic> _commentList = [];
  bool loading = true;
  int userId = 0;
  int _editCommentId = 0;
  TextEditingController commentController = TextEditingController();

  Future<void> _getComments() async {
    userId = await getUserId();
    ApiResponse apiResponse = await getComments(widget.postId ?? 0);

    if (apiResponse.error == null) {
      setState(() {
        _commentList = apiResponse.data as List<dynamic>;
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

  //__create comment__
  void _createComment() async {
    ApiResponse apiResponse =
        await createComment(widget.postId ?? 0, commentController.text);

    if (apiResponse.error == null) {
      commentController.clear();
      _getComments();
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

  //__edit comment__
  void _editComment() async {
    ApiResponse apiResponse =
        await editComment(_editCommentId, commentController.text);

    if (apiResponse.error == null) {
      _editCommentId = 0;
      commentController.clear();
      _getComments();
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

  //__delete comment__
  void _deleteComment(int commentId) async {
    ApiResponse apiResponse = await deleteComment(commentId);

    if (apiResponse.error == null) {
      _getComments();
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
    _getComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => _getComments(),
                    child: _commentList.isNotEmpty
                        ? ListView.builder(
                            itemCount: _commentList.length,
                            itemBuilder: (context, index) {
                              Comment comment = _commentList[index];
                              return ListTile(
                                title: Text('${comment.user!.name}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                  '${comment.comment}',
                                  style: const TextStyle(
                                      color: Colors.black87, height: 2),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage('${comment.user!.image}'),
                                ),
                                trailing: userId == comment.user!.id
                                    ? PopupMenuButton(
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
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
                                            setState(() {
                                              _editCommentId = comment.id ?? 0;
                                              commentController.text =
                                                  comment.comment ?? '';
                                            });
                                          } else if (val == 'delete') {
                                            _deleteComment(comment.id ?? 0);
                                          }
                                        },
                                      )
                                    : const SizedBox(),
                                shape: const Border(
                                    top: BorderSide(
                                        color: Colors.black26, width: 0.5)),
                              );
                            },
                          )
                        : const Center(child: Text('No comments yet')),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black26, width: 0.5)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Write a comment...',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                          controller: commentController,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if (commentController.text.isNotEmpty) {
                              setState(() {
                                loading = true;
                              });
                              _editCommentId > 0
                                  ? _editComment()
                                  : _createComment();
                            }
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.deepOrange,
                          ))
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
