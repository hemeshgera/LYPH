import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('Demo App'),

        ),
        body: Column(
          children: <Widget>[
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Container(
              height: 125.0,
              width: 125.0,
              margin: EdgeInsets.only(top:20,),
              child: Column(
                children: <Widget>[
                  Icon(
                      Icons.wallet_giftcard_rounded,
                      color: Colors.teal,
                    size: 80,
                  ),
                  Text(
                    'Save For a Goal',
                    style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Colors.teal),)
                ]
              )
              //color: Colors.red,
            ),
              Container(
                  height: 125.0,
                  width: 125.0,
                  margin: EdgeInsets.only(left: 5,right:5,top:20,),
                  child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.wallet_giftcard_rounded,
                          color: Colors.teal,
                          size: 80,
                        ),
                        Text(
                          'Retirement Planner',
                          style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Colors.teal),)
                      ]
                  )
                //color: Colors.red,
              ),
              Container(
                  height: 125.0,
                  width: 125.0,
                  margin: EdgeInsets.only(top:20,),
                  child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.wallet_giftcard_rounded,
                          color: Colors.teal,
                          size: 80,
                        ),
                        Text(
                          'Manage Loans',
                          style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Colors.teal),)
                      ]
                  )
                //color: Colors.red,
              ),
          ],
        ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 125.0,
                    width: 125.0,
                    margin: EdgeInsets.only(top:20,),
                    child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.wallet_giftcard_rounded,
                            color: Colors.teal,
                            size: 80,
                          ),
                          Text(
                            'Track Expenses',
                            style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Colors.teal),)
                        ]
                    )
                  //color: Colors.red,
                ),
                Container(
                    height: 125.0,
                    width: 125.0,
                    margin: EdgeInsets.only(left: 5,right:5,top:20,),
                    child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.wallet_giftcard_rounded,
                            color: Colors.teal,
                            size: 80,
                          ),
                          Text(
                            'Track Portfolio',
                            style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Colors.teal),)
                        ]
                    )
                  //color: Colors.red,
                ),
                Container(
                    height: 125.0,
                    width: 125.0,
                    margin: EdgeInsets.only(top:20,),
                    child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.wallet_giftcard_rounded,
                            color: Colors.teal,
                            size: 80,
                          ),
                          Text(
                            'Manage Taxes',
                            style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Colors.teal),)
                        ]
                    )
                  //color: Colors.red,
                ),
              ],
            ),
     ],
    ),
      ),
    );
  }
}

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: Text('Demo App'),

            ),
            body: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 70.0,
                  backgroundColor: Colors.red,
                )
              ],
        ),
        ),

    );
  }
}

