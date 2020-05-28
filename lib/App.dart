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
  TextEditingController searchText = new TextEditingController();
  var movies = new List<Movie>();
  Map<String, dynamic> list;
  List<dynamic> data = new List<dynamic>();
  _getMovies(var search) {
    API.getUsers(search).then((response) {
      var o = response;
      o = o.body.toString();
      setState(() {
        list = json.decode(o);
        data = list["results"];
      });
      // print(data[1]["genre_ids"][0]);
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
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Form(
                  onChanged: () => {
                    (searchText.text.toString() == "")
                        ? print("nothing")
                        : _getMovies(searchText.text),
                  },
                  child: TextFormField(
                    onFieldSubmitted: (value) => {
                      (value.isEmpty)
                          ? print(
                              "Empty***************************************")
                          : _getMovies(searchText.text),
                      //print("Something")
                    },
                    textInputAction: TextInputAction.go,
                    controller: searchText,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.panorama_vertical),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                        ),
                        onPressed: () {
                          _getMovies(searchText.text);
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Search Movie',
                    ),
                  ),
                ),
                Divider(
                  thickness: 0,
                  color: Colors.white,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: (data == null) ? 0 : data.length,
                    itemBuilder: (context, index) {
                      return Text(data[index]["title"]);
                    },
                    shrinkWrap: true,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
