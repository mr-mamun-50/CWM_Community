import 'dart:convert';

import 'package:coding_with_mamun_community/constant.dart';
import 'package:coding_with_mamun_community/models/api_response.dart';
import 'package:coding_with_mamun_community/models/comment.dart';
import 'package:coding_with_mamun_community/services/user_service.dart';
import 'package:http/http.dart' as http;

//__get all comments__
Future<ApiResponse> getComments(int postId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse('$postsURL/$postId/comments'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['comments']
            .map((p) => Comment.fromJson(p))
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

//__create comment__
Future<ApiResponse> createComment(int postId, String? comment) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse('$postsURL/$postId/comment'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
        body: {
          'comment': comment
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['msg'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        // apiResponse.error = somethingWrong;
        apiResponse.error = apiResponse.error.toString();
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//__Edit comment__
Future<ApiResponse> editComment(int commentId, String comment) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.put(Uri.parse('$postsURL/$commentId/comment/0'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
        body: {
          'comment': comment
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

//__Delete comment__
Future<ApiResponse> deleteComment(int commentId) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http
        .delete(Uri.parse('$postsURL/$commentId/comment/0'), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
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
