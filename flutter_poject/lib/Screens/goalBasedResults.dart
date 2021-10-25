import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class goalBasedResults extends StatefulWidget {

  goalBasedResults({this.finalData});
  final finalData;

  @override
  _goalBasedResults createState() => _goalBasedResults();
}

class _goalBasedResults extends State<goalBasedResults> {
  _goalBasedResults();

  @override
  void initState(){
    super.initState();

    print('rpinting fata');
    print(widget.finalData.keys.toList());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


    );
  }


}








