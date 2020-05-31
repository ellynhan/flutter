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
              Container(
                color:Colors.white,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Row(
                  children: <Widget>[
                    Icon(
                        Icons.call,
                        color: Colors.teal.shade800
                    ),
                    SizedBox(
                      width:10,
                    ),
                    Text(
                        '+81 010 1111 2222',
                        style: TextStyle(
                            color: Colors.teal.shade900,
                            fontFamily: 'SourceSans',
                            fontSize:20
                        )
                    )
                  ],
                ),
              ),
              Card(
                color:Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                          Icons.email,
                          color: Colors.teal.shade800
                      ),
                      SizedBox(
                        width:10,
                      ),
                      Text(
                          'gkrp11@gmail.com',
                          style: TextStyle(
                              color: Colors.teal.shade900,
                              fontFamily: 'SourceSans',
                              fontSize:20
                          )
                      )
                    ],
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

