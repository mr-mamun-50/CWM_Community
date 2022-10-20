import 'package:flutter/material.dart';

//__Strings__
const baseURL = 'http://192.168.42.3:8000/api';
const loginURL = '$baseURL/login';
const registerURL = '$baseURL/register';
const logOutURL = '$baseURL/logout';
const userURL = '$baseURL/user';
const postsURL = '$baseURL/posts';
const commentsURL = '$baseURL/comments';

//__Error Messages__
const serverError = 'Server Error';
const noInternet = 'No Internet Connection';
const unauthorized = 'Unauthorized';
const somethingWrong = 'Something went wrong, try again!';

//__input_decoration__
InputDecoration inputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    border: const OutlineInputBorder(),
  );
}

//__Button__
ElevatedButton submitBtn(String label, bool loading, Function onPressed) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
    child: loading
        ? const SizedBox(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(color: Colors.white),
          )
        : Text(label),
    onPressed: () => onPressed(),
  );
}