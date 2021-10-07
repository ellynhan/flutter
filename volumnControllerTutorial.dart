import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VolumnControl(),
    );
  }
}

class VolumnControl extends StatefulWidget {
  @override
  _VolumnControlState createState() => _VolumnControlState();
}

class _VolumnControlState extends State<VolumnControl> {
  double _volume = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Volumn Controller"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.volume_up),
          Text('Volume : $_volume'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon:const Icon(Icons.keyboard_arrow_up),
                onPressed: () {
                  if(_volume<100){
                    setState(() {
                      _volume += 10;
                    });
                  }
                },
              ),
              IconButton(
                icon:const Icon(Icons.keyboard_arrow_down),
                onPressed: () {
                  if(_volume>0){
                    setState(() {
                      _volume -= 10;
                    });
                  }
                },
              )
            ],
          )
        ],
      )
    );
  }
}


