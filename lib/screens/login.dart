// ignore_for_file: use_build_context_synchronously

import 'package:coding_with_mamun_community/constant.dart';
import 'package:coding_with_mamun_community/models/api_response.dart';
import 'package:coding_with_mamun_community/models/user.dart';
import 'package:coding_with_mamun_community/screens/home.dart';
import 'package:coding_with_mamun_community/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/user_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse apiResponse =
        await login(emailController.text, passwordController.text);
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
        title: const Text('Login'),
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
                    value!.length < 8 ? 'Password at least 8 character' : null,
                obscureText: true,
                decoration: inputDecoration('Password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: submitBtn('LOGIN', loading, () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                    _loginUser();
                  });
                }
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const Register()),
                        (route) => false);
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
