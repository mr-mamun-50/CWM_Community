// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:io';

import 'package:coding_with_mamun_community/constant.dart';
import 'package:coding_with_mamun_community/models/api_response.dart';
import 'package:coding_with_mamun_community/screens/login.dart';
import 'package:coding_with_mamun_community/services/post_service.dart';
import 'package:coding_with_mamun_community/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostForm extends StatefulWidget {
  const PostForm({super.key});

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController descController = TextEditingController();
  bool loading = false;
  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _createPost() async {
    String? image = _imageFile == null ? null : getStringImage(_imageFile);
    ApiResponse apiResponse = await createPost(descController.text, image);

    if (apiResponse.error == null) {
      Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create post'),
      ),
      body: ListView(
        children: [
          Container(
            height: 200,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: _imageFile == null
                  ? null
                  : DecorationImage(
                      image: FileImage(_imageFile ?? File('')),
                      fit: BoxFit.cover,
                    ),
            ),
            child: IconButton(
              onPressed: () {
                getImage();
              },
              icon: const Icon(Icons.image, size: 50, color: Colors.black38),
            ),
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: descController,
                decoration: const InputDecoration(
                    hintText: 'Post description', border: OutlineInputBorder()),
                keyboardType: TextInputType.multiline,
                maxLines: 7,
                validator: (value) =>
                    value!.isEmpty ? 'Description is required' : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: submitBtn("Add Post", loading, () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  loading = !loading;
                });
                _createPost();
              }
            }),
          ),
        ],
      ),
    );
  }
}
