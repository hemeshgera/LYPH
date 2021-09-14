import 'package:flutter/material.dart';
import 'Screens/goal_based.dart';


void main() {
  runApp(FlashChat());
}


class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: 'my_app',
      routes: {
        'my_app': (context) => MyApp(),
        'goal_based': (context) => goal_based(),

      },
      //home: WelcomeScreen(),
    );
  }
}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: NavDrawer(),
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
              child:TextButton(
                onPressed:
                      () {
                    Navigator.pushNamed(context, 'goal_based');
                    //Go to login screen.
                  },
                  //Implement send functionality.

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

                ),
              ),


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


class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.teal,

          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: Text('Item 1'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('Item 2'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
      ],
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

