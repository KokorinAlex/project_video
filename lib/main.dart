// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import './logic.dart';

void main(List<String> args) => runApp(FilmsApp());

class FilmsApp extends StatefulWidget {
  const FilmsApp({Key? key}) : super(key: key);

  @override
  State<FilmsApp> createState() => _FilmsAppState();
}

class _FilmsAppState extends State<FilmsApp> {
  Icon customIcon = Icon(
    Icons.search,
    size: 28,
  );
  Widget customSearchBar = Text('Films');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Quicksand',
          primarySwatch: Colors.deepPurple,
          appBarTheme: AppBarTheme(
              centerTitle: true,
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans-Bold',
                  //fontWeight: FontWeight.bold,
                  fontSize: 28))),
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: customSearchBar,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (customIcon.icon == Icons.search) {
                      customIcon = Icon(Icons.cancel);
                      customSearchBar = ListTile(
                        trailing: IconButton(
                          icon: Icon(Icons.send, color: Colors.white),
                          onPressed: () {},
                        ),
                        leading: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 28,
                        ),
                        title: TextField(
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Enter the name of film',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      customIcon = const Icon(Icons.search);
                      customSearchBar = const Text('Films');
                    }
                  });
                },
                icon: customIcon)
          ],
        ),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
