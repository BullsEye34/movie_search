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
                      //return Text(data[index]["title"]);
                      return (list.isEmpty)
                          ? CupertinoActivityIndicator()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                    height: 140,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(.1),
                                            offset: Offset(0, 0),
                                            blurRadius: 10,
                                            spreadRadius: 3)
                                      ],
                                    ),
                                    child:
                                        /* Text(
                                      list["results"][index]["title"].toString(),
                                    ), */
                                        Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 120,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                list["results"][index]["title"]
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(40),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Divider(),
                                            Flexible(
                                              child: Text(
                                                "Year: " +
                                                    list["results"][index]
                                                            ["description"]
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Divider(),
                                            Flexible(
                                              child: Text(
                                                "Rating to Come Here",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          image(index),
                                          SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
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

  image(index) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: CupertinoActivityIndicator(),
        ),
        Container(
          height: 150,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(0, 0),
                  blurRadius: 10,
                  spreadRadius: 3)
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            list["results"][index]["image"].toString(),
            width: 100,
            height: 150,
          ),
        ),
      ],
    );
  }
}
