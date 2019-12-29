import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:async'; // for stream

// main function
void main() {
  runApp(GetWidthHeight());
}

class GetWidthHeight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyAppBrain(),
    );
  }
}


// stateful widget
class MyAppBrain extends StatefulWidget {
  @override
  _MyAppBrainState createState() => _MyAppBrainState();
}

class _MyAppBrainState extends State<MyAppBrain> {
  //storing data in event
  AccelerometerEvent event;
  // for getting stream of data from sensor
  StreamSubscription accel;
  //for storing the height and width of the device
  //for starting the reading of data
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Get the circle in the centre and hold it for 1 sec'),
            ),
            Stack(
              children: <Widget>[
                // empty container to initialise the size of the stack
                Container(
                  width: width,
                  height: height/2,
                ),
                // the outer (fixed) circle
                Positioned(
                  top: 50,
                  left: (width - 250) / 2,
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      border: Border.all(color: Colors.deepOrange, width: 3.5),
                      borderRadius: BorderRadius.circular(125),
                    ),
                  ),
                ),
                // the target/ inner circle (also fixed)
                //Positioned(),
                // the moving circle (position determined by accelerometer)
                //Positioned(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 150.0),
              child:  Text('x: ${(event?.x ?? 0).toStringAsFixed(3)}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:  Text('y: ${(event?.y ?? 0).toStringAsFixed(3)}'),
            ),

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
    );
  }
}