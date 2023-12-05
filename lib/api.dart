import 'dart:convert';

import 'package:flutter_http/post.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Post> fetchPost() async {
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts/1");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      print("Helloo |||||||||||||");
      final data = jsonDecode(response.body);
      print(data["body"]);

      Post newpost = Post(data["userId"], data["title"], data["body"]);

      return newpost;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Post> createPost(String title, String body) async {
    Map<String, dynamic> request = {
      'title': title,
      'body': body,
      'userId': '1'
    };

    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    final response = await http.post(uri, body: request);

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print(data["title"]);
      Post newpost = Post(int.parse(data["userId"]), data["title"], data["body"]);
      return newpost;
    } else {
      throw ('Failed to load post');
    }
  }

  Future<Post> updatePost(String title, String body) async {
    Map<String, dynamic> request = {
      'id': '101',
      'title': title,
      'body': body,
      'userId': '111'
    };

    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts/1");
    final response = await http.put(uri, body: request);

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw ('Failed to load post');
    }
  }

  Future<Post?> deletePost() async {
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts/1");
    final response = await http.delete(uri);

    if (response.statusCode == 200) {
      return null;
    } else {
      throw Exception('Failed to load post ');
    }
  }
}
