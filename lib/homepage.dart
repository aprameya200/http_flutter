import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_http/post.dart';
import 'package:flutter_http/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Post?>? post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FutureBuilder<Post?>(
                future: post,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return Container(
                      height: 200,color: Colors.red,
                    );
                  } else {
                    if (snapshot.hasData) {
                      return buildDataWidget(context, snapshot);
                    } else if (snapshot.hasError){
                      return Text(snapshot.toString());
                    }else {
                      return Container(height: 200,color: Colors.purple,);
                    }
                  }
                }),
            generateButton("Get", 4),
            generateButton("Post", 1),
            generateButton("Put", 2),
            generateButton("Delete", 3),
          ],
        ),
      ),
    );
  }

  ElevatedButton generateButton(String text, int httpMethods) {
    return ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
        onPressed: () {
          switch(text){
            case "Get": clickGetButton(); break;
            case "Post": clickPostButton(); break;
            case "Put": clickUpdatePost(); break;
            case "Delete": clickDeleteButton(); break;
          }
        },
        child: Text(
          text,
          style: TextStyle(fontSize: 40, color: Colors.green),
        ));
  }

  void clickGetButton() {
    setState(() {
      post = ApiService().fetchPost();
    });
  }

  void clickDeleteButton() {
    setState(() {
      post = ApiService().deletePost();
    });
  }

  void clickPostButton() {
    setState(() {
      post =
          ApiService().createPost("Top Post", "This is an example of the post");
    });
  }

  void clickUpdatePost() {
    setState(() {
      post = ApiService().updatePost(
          "Update Post", "UPDATE!! This is an example of the update");
    });
  }

  Widget buildDataWidget(context,snapshot)  =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(snapshot.data.title,style: TextStyle(fontSize: 30),),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(snapshot.data.description),
        ),
      ],
    );

}
