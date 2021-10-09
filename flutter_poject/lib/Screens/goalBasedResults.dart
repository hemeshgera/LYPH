import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class goalBasedResults extends StatefulWidget {
  final String tenure;
  final String amount;
  final String maxMonthlyInvestment;
  goalBasedResults(this.tenure, this.amount, this.maxMonthlyInvestment);

  @override
  _goalBasedResults createState() => _goalBasedResults(tenure, amount, maxMonthlyInvestment);
}

class _goalBasedResults extends State<goalBasedResults> {
  final String tenure;
  final String amount;
  final String maxMonthlyInvestment;
  _goalBasedResults(this.tenure, this.amount, this.maxMonthlyInvestment);
  late Future<Album> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(tenure, amount, maxMonthlyInvestment);
    print(futureAlbum.toString());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

    );
  }


}



Future<Album> fetchAlbum(tenure,amount, monthlyInvestment) async {
  print('http://10.0.2.2:5000/goalBasedPage/0.1/'+'$tenure'+'/'+'$amount'+'/'+ '$monthlyInvestment');
  final response = await http
      .get(Uri.parse('http://10.0.2.2:5000/goalBasedPage/0.1/'+'$tenure'+'/'+'$amount'+'/'+ '$monthlyInvestment'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String overall;


  Album({
    required this.overall,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    print(json["Overall"]["Total Monthly Amount"]);
    return Album(
      overall: json["Overall"],
    );
  }
}