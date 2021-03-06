import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_poject/Screens/goalBasedResults.dart';

class goal_based extends StatefulWidget {
  const goal_based({Key? key}) : super(key: key);

  @override
  _goal_basedState createState() => _goal_basedState();
}

class _goal_basedState extends State<goal_based> {
  String dropdownValue = 'Education';
  final _tenure = TextEditingController();
  final _amount = TextEditingController();
  final _maxMonthlyInvestment = TextEditingController();
  String _goal = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Column(children: <Widget>[
                  Text(
                    'Select A Goal',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  )
                ])
              //color: Colors.red,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.lightBlueAccent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(32),
              ),
              child: new Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.white,
                ),
                child:DropdownButtonFormField<String>(

                  value: dropdownValue,
                  isExpanded: true,



                  style: TextStyle(
                      color: Colors.black, backgroundColor: Colors.white,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      _goal = dropdownValue;
                    });
                  },
                  items: <String>['Education', 'Travel', 'House Purchase', 'New Gadget']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ));
                  }).toList(),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Column(children: <Widget>[
                  Text(
                    'Tenure in Months',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  )
                ])
              //color: Colors.red,
            ),
            TextFormField(controller: _tenure,
              onChanged: (value) {
                //Do something with the user input.
              },
              style: TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintText: 'Tenure in months',
                filled: true,
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Column(children: <Widget>[
                  Text(
                    'Investment Amount Needed',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  )
                ])
                //color: Colors.red,
            ),
            TextFormField(controller: _amount,
              onChanged: (value) {
                //Do something with the user input.
              },
              style: TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintText: 'Investment Amount Needed',
                filled: true,
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Column(children: <Widget>[
                  Text(
                    'Maximum Monthly Investment',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  )
                ])
                //color: Colors.red,
                ),
            TextFormField(controller: _maxMonthlyInvestment,
              onChanged: (value) {
                //Do something with the user input.
              },
              style: TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintText: 'Maximum amount you can invest each month',
                filled: true,
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () {
                      var goalData = getFinalData(_tenure.text, _amount.text, _maxMonthlyInvestment.text);
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Enter',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void getFinalData(tenure,amount, monthlyInvestment) async {
    var goalData = await fetchData(tenure, amount, monthlyInvestment);


    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return goalBasedResults(
        finalData: jsonDecode(goalData),
      );
    }));
  }
}




Future fetchData(tenure,amount, monthlyInvestment) async {
  print('http://10.0.2.2:5000/goalBasedPage/0.1/'+'$tenure'+'/'+'$amount'+'/'+ '$monthlyInvestment');
  http.Response response = await http.get(Uri.parse('http://10.0.2.2:5000/goalBasedPage/0.1/'+'$tenure'+'/'+'$amount'+'/'+ '$monthlyInvestment'));
  var data;
  if (response.statusCode == 200){
    data = await response.body;
    var breakdown = jsonDecode(data)["Breakdown"];
    var keys = breakdown.keys.toList();

  }

 return await data;

}

