import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('images/EDA0404.png'),
              ),
              Text(
                'Jaewon Han',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Project Manager',
                style: TextStyle(
                  fontFamily: 'SourceSans',
                  fontSize: 20,
                  color: Colors.teal.shade100,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height:20,
                width:150,
                child: Divider(
                  color:Colors.teal.shade100,
                ),
              ),
              Card(
                color:Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: Icon(
                      Icons.call,
                      color: Colors.teal.shade800
                  ),
                  title: Text(
                      '+81 010 1111 2222',
                      style: TextStyle(
                          color: Colors.teal.shade900,
                          fontFamily: 'SourceSans',
                          fontSize:20
                      )
                  ),
                ),
              ),
              Card(
                color:Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                    leading: Icon(
                        Icons.email,
                        color: Colors.teal.shade800
                    ),
                    title: Text(
                        'gkrp11@gmail.com',
                        style: TextStyle(
                            color: Colors.teal.shade900,
                            fontFamily: 'SourceSans',
                            fontSize:20
                        )
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}

