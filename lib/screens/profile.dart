// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:io';

import 'package:coding_with_mamun_community/constant.dart';
import 'package:coding_with_mamun_community/models/api_response.dart';
import 'package:coding_with_mamun_community/models/user.dart';
import 'package:coding_with_mamun_community/screens/login.dart';
import 'package:coding_with_mamun_community/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user;
  bool loading = true;
  File? _imageFile;
  final _picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  //__get user__
  void _getUserDetail() async {
    ApiResponse apiResponse = await getUserDetail();
    if (apiResponse.error == null) {
      setState(() {
        user = apiResponse.data as User;
        loading = false;
        nameController.text = user!.name ?? '';
      });
    } else if (apiResponse.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(apiResponse.error!),
      ));
      setState(() {
        loading = false;
      });
    }
  }

  //__Update profile__
  void updateProfile() async {
    ApiResponse apiResponse =
        await updateUserDetail(nameController.text, getStringImage(_imageFile));
    setState(() {
      loading = false;
    });

    if (apiResponse.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Profile updated successfully'),
          backgroundColor: Colors.green));
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
        loading = false;
      });
    }
  }

  @override
  void initState() {
    _getUserDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
              child: ListView(
                children: [
                  Center(
                    child: GestureDetector(
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: _imageFile == null
                              ? user!.image != null
                                  ? DecorationImage(
                                      image: NetworkImage('${user!.image}'),
                                      fit: BoxFit.cover,
                                    )
                                  : const DecorationImage(
                                      image: AssetImage(
                                          'https://www.pngitem.com/pimgs/m/130-1300253_female-user-icon-png-download-user-image-color.png'),
                                      fit: BoxFit.cover,
                                    )
                              : DecorationImage(
                                  image: FileImage(_imageFile ?? File('')),
                                  fit: BoxFit.cover,
                                ),
                          color: Colors.black12,
                        ),
                      ),
                      onTap: () {
                        getImage();
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: formKey,
                    child: TextFormField(
                      controller: nameController,
                      decoration: inputDecoration('Name'),
                      validator: (value) =>
                          value!.isEmpty ? 'Invalid name' : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  submitBtn('Save changes', loading, () {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      updateProfile();
                    }
                  })
                ],
              ),
            ),
    );
  }
}
