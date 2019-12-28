import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:async'; // for stream

// main function
void main() {
  runApp(MyAppBrain());
}


// stateful widget
class MyAppBrain extends StatefulWidget {
  @override
  _MyAppBrainState createState() => _MyAppBrainState();
}

class _MyAppBrainState extends State<MyAppBrain> {

  AccelerometerEvent event;
  StreamSubscription accel;


  startTimer()
  {
    if (accel == null)
      {
        accel = accelerometerEvents.listen((AccelerometerEvent temp) {
          setState(() {
            event=temp;
          });
        });
      }
    else
      {
        accel.resume();
      }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF009688),
          leading: Icon(
            Icons.code,
            size: 38.0,
          ),
          centerTitle: true,
          titleSpacing: 5.0,
          title: Text(
            'DevClub Assignment',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontSize: 22.0),
          ),
        ),
        backgroundColor: Colors.teal[200],
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Text('x: ${(event?.x ?? 0).toStringAsFixed(3)}'),
              Text('y: ${(event?.y ?? 0).toStringAsFixed(3)}'),
              Text('z: ${(event?.z ?? 0).toStringAsFixed(3)}'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            startTimer();
          },
          icon: Icon(
            Icons.play_arrow,
            size: 30.0,
          ),
          label: Text(
            'BEGIN',
            style: TextStyle(fontSize: 20.0),
          ),
          backgroundColor: Color(0xFF03a9f4),
        ),
      ),
    );
  }
}