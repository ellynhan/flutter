import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar:AppBar(
          title:const Text("Xylophone"),
          backgroundColor:Colors.black,
          centerTitle:true,
        ),
        body: SafeArea(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:<Widget>[
              buildKey(Colors.red,"red"),
              buildKey(Colors.orange,"orange"),
              buildKey(Colors.yellow,"yellow"),
              buildKey(Colors.green,"green"),
              buildKey(Colors.blue,"blue"),
              buildKey(Colors.indigo,"indigo"),
              buildKey(Colors.purple,"purple"),
            ]
          )          
        ),
      ),
    );
  }
}

Expanded buildKey(Color color, String colorString){
  return Expanded(
    child: TextButton(
      style:ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color),
      ),
      child:const Text(""),
      onPressed: (){
       print("You Pressed "+colorString+" color key!"); 
      }
    )
  );
}
