import 'package:flutter/material.dart';
import 'dart:math';
void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Ask Me Anything'),
            backgroundColor: Colors.indigoAccent,
          ),
          body: Ball()
        ),
      ),
    );

class Ball extends StatefulWidget {
  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> {
  int ballNumber = 0;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Center(child: Image.asset('images/ball$ballNumber.png')),
      color: Colors.blue,
      onPressed: (){
        setState(() {
          ballNumber = Random().nextInt(4)+1
          ;
        });
        print(ballNumber);
        },
    );
  }
}
