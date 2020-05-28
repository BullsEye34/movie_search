import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Models/API.dart';
import 'Models/Movie.dart';

class app extends StatefulWidget {
  @override
  _appState createState() => _appState();
}

class _appState extends State<app> {
  var movies = new List<Movie>();
  _getMovies() {
    API.getUsers().then((response) {
      var o = response;
      //print(o.body.toString().substring(3));
      o = o.body.toString().substring(3);
      setState(() {
        Iterable list = json.decode(o);
        movies = list.map((model) => Movie.fromJson(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
