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
  Map<String, dynamic> list;
  List<dynamic> data;
  _getMovies(var search) {
    API.getUsers(search).then((response) {
      var o = response;
      o = o.body.toString();
      setState(() {
        list = json.decode(o);
        data = list["results"];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMovies("John");
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
