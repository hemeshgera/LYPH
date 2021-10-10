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
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder<List<Album>>(
        future: fetchAlbum(tenure, amount, maxMonthlyInvestment),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return DataList(photos: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }


}



Future<List<Album>> fetchAlbum(tenure,amount, monthlyInvestment) async {
  print('http://10.0.2.2:5000/goalBasedPage/0.1/'+'$tenure'+'/'+'$amount'+'/'+ '$monthlyInvestment');
  final response = await http
      .get(Uri.parse('http://10.0.2.2:5000/goalBasedPage/0.1/'+'$tenure'+'/'+'$amount'+'/'+ '$monthlyInvestment'));
  int data;
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);

    return parseData(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

List<Album> parseData(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Album>((json) => Album.fromJson(json)).toList();
}

class Album {
  final String overall;


  Album({
    required this.overall,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    print(json["Overall"]["Total Monthly Amount"]);
    return Album(
      overall: json["Overall"]["Total Monthly Amount"] as String,
    );
  }
}


class DataList extends StatelessWidget {
  const DataList({Key? key, required this.photos}) : super(key: key);

  final List<Album> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        print('reached here'+'$photos[index].overall');
        return Image.network(photos[index].overall);
      },
    );
  }
}