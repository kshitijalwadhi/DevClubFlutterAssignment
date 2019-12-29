import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:async'; // for stream of values

// main function
void main() {
  runApp(GetWidthHeight());
}

// for giving MediaQuery.of() a context (MaterialApp) to decide width and height of device
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
  // timer variable
  Timer timer;

  double top = 0;
  double left=0;
  int count = 0;
  Color color = Colors.green;

  //for starting the reading of data and game evaluation
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
    //for pausing the game after hold successfully for 1 sec and also call for color change
    if (timer == null || !timer.isActive) {
      timer = Timer.periodic(Duration(milliseconds: 200), (_) {
        if (count > 3) {
          pauseTimer();
        } else {
          setColor();
          setPosition(event);
        }
      });
    }
  }

  //changing the color as per requirement
  setColor() {
    var xDelta = (event.x *10).abs();
    var yDelta = (event.y *10).abs();

    if(xDelta<3 && yDelta<3){
      setState(() {
        color= Colors.greenAccent;
        count+=1;
      });
    }
    else{
      setState(() {
        color = Colors.red[300];
        count =0;
      });
    }
  }


  //pause the timer
  pauseTimer(){
    timer.cancel();
    accel.pause();
    setState(() {
      count =0;
      color= Colors.green;
    });
  }

  setPosition(AccelerometerEvent event){
    setState((){
      left=-event.x*10;
      top=event.y*10;
    });
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
            Stack(
              children: <Widget>[
                // empty container to initialise the size of the stack
                Container(
                  width: width,
                  height: height/1.5,
                ),
                Positioned(
                  top: 10,
                  left: 15,

                  child: Text('Get the circle in the centre and hold it for 1 sec', style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),),
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
                Positioned(
                  top: 125,
                  left: (width - 100) / 2,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2.5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),

                // the moving circle (position determined by accelerometer)
                Positioned(
                  top: 125 + top,
                  left: left + (width-100)/2,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(color: Colors.red, width: 2.5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),

                // text for accelerometer values
                Positioned(
                  top: 370.0,
                  left: width/2 -45,
                  child: Text('x: ${(event?.x ?? 0).toStringAsFixed(2)}', style: TextStyle(fontSize: 30.0, letterSpacing: 2.0, ),),
                ),
                Positioned(
                  top: 405.0,
                  left: width/2 - 45,
                  child: Text('y: ${(event?.y ?? 0).toStringAsFixed(2)}', style: TextStyle(fontSize: 30.0, letterSpacing: 2.0, )),
                ),
              ],
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