import 'dart:convert';

import 'package:coding_with_mamun_community/constant.dart';
import 'package:coding_with_mamun_community/models/api_response.dart';
import 'package:coding_with_mamun_community/models/post.dart';
import 'package:coding_with_mamun_community/services/user_service.dart';
import 'package:http/http.dart' as http;

//__get all posts__
Future<ApiResponse> getPosts() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(postsURL), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['posts']
            .map((p) => Post.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//__create post__
Future<ApiResponse> createPost(String body, String? image) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(postsURL), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    }, body: {
      'body': body,
      'image': image,
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body);
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//__Edit post__
Future<ApiResponse> editPost(int postId, String body) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.put(Uri.parse('$postsURL/$postId'), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    }, body: {
      'body': body,
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['msg'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['msg'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//__Delete post__
Future<ApiResponse> deletePost(int postId) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response =
        await http.delete(Uri.parse('$postsURL/$postId'), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['msg'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['msg'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = response.statusCode.toString();
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//__Like or Unlike post__
Future<ApiResponse> likeUnlikePost(int postId) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response =
        await http.post(Uri.parse('$postsURL/$postId/like'), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['msg'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}
