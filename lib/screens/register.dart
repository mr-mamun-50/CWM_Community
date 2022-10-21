// ignore_for_file: use_build_context_synchronously

import 'package:coding_with_mamun_community/constant.dart';
import 'package:coding_with_mamun_community/models/api_response.dart';
import 'package:coding_with_mamun_community/models/user.dart';
import 'package:coding_with_mamun_community/screens/home.dart';
import 'package:coding_with_mamun_community/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  void _registerUser() async {
    ApiResponse apiResponse = await register(
        nameController.text, emailController.text, passwordController.text);
    if (apiResponse.error == null) {
      _saveAndRedirectHome(apiResponse.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(apiResponse.error!),
        ),
      );
    }
  }

  void _saveAndRedirectHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('id', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                  controller: nameController,
                  validator: (value) =>
                      value!.isEmpty ? 'Name is required' : null,
                  decoration: inputDecoration('name')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: emailController,
                validator: (value) =>
                    value!.isEmpty ? 'Email is required' : null,
                keyboardType: TextInputType.emailAddress,
                decoration: inputDecoration('Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: passwordController,
                validator: (value) =>
                    value!.isEmpty ? 'Password is required' : null,
                obscureText: true,
                decoration: inputDecoration('Password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                validator: (value) => value!.isEmpty
                    ? 'Re-enter the password'
                    : value != passwordController.text
                        ? 'Password does not match'
                        : null,
                obscureText: true,
                decoration: inputDecoration('Confirm Password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: submitBtn('REGISTER', loading, () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                    _registerUser();
                  });
                }
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const Login()),
                        (route) => false);
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
