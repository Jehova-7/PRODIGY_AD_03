import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(StopwatchApp());

class StopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StopwatchHome(),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StopwatchHome extends StatefulWidget {
  @override
  _StopwatchHomeState createState() => _StopwatchHomeState();
}

class _StopwatchHomeState extends State<StopwatchHome> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startStopwatch() {
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {}); // Rebuilds the widget every 10 ms to update the display.
    });
    _stopwatch.start();
  }

  void _pauseStopwatch() {
    _stopwatch.stop();
    _timer.cancel();
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    setState(() {}); // Updates the display immediately after resetting.
  }

  String _formattedTime() {
    final milliseconds = _stopwatch.elapsedMilliseconds;
    final minutes = (milliseconds ~/ 60000).toString().padLeft(2, '0');
    final seconds = ((milliseconds ~/ 1000) % 60).toString().padLeft(2, '0');
    final ms = (milliseconds % 1000 ~/ 10).toString().padLeft(2, '0');
    return "$minutes:$seconds:$ms";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://cdnb.artstation.com/p/assets/images/images/001/655/501/large/chandra-mouli-kondeti-test-03.jpg?1450220137"), // Background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Stopwatch Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Circular container to mimic a watch face
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[850]!.withOpacity(0.8), // Semi-transparent dark background
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 4), // Shadow effect
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      _formattedTime(),
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 232, 221, 77), // Neon green text
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _stopwatch.isRunning ? _pauseStopwatch : _startStopwatch,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Color.fromARGB(255, 250, 245, 173),
                      ),
                      child: Text(_stopwatch.isRunning ? "Pause" : "Start"),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _resetStopwatch,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor:Color.fromARGB(255, 232, 221, 77),
                      ),
                      child: Text("Reset"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
