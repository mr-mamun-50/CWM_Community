import 'package:flutter/material.dart';

//__Strings__
const baseURL = 'http://cwm-community-api.herokuapp.com/public/api';
const loginURL = '$baseURL/login';
const registerURL = '$baseURL/register';
const logOutURL = '$baseURL/logout';
const userURL = '$baseURL/user';
const postsURL = '$baseURL/posts';

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

//__Likes & comments button__
Expanded likesCommentsBtn(
    int? value, IconData icon, Color color, Function onPressed) {
  return Expanded(
    child: Material(
      child: InkWell(
        onTap: () => onPressed(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 5),
              value != null ? Text('(${value.toString()})') : const SizedBox(),
            ],
          ),
        ),
      ),
    ),
  );
}
