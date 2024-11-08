import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  int _initialMilliseconds = 0;
  int _initialDSeconds = 59;
  int _initialMinutes = 59;
  int _initialHours = 23;


  void _toggleStopwatch() {
    if (_stopwatch.isRunning) {
      _stopStopwatch();
    } else {
      _startStopwatch();
    }
  }

  void _startStopwatch() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
    _stopwatch.start();
  }

  void _stopStopwatch() {
    _timer?.cancel();
    _stopwatch.stop();
  }

  void _resetStopwatch() {
    _timer?.cancel();
    _stopwatch.reset();
    setState(() {});
  }

  String _formatTime(int milliseconds) {
    int dSeconds = _initialDSeconds * 1000;
    int dMinutes = _initialMinutes * 60000;
    int dHours = _initialHours * 3600000;
    int totalMilliseconds = milliseconds + _initialMilliseconds + dSeconds + dMinutes + dHours;

    int hundreds = (totalMilliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 24).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr:$hundredsStr";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: const Color.fromARGB(255, 220, 121, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatTime(_stopwatch.elapsedMilliseconds),
              style: TextStyle(fontSize: 48.0, color: Colors.white),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _toggleStopwatch,
                  child: Text(_stopwatch.isRunning ? 'Stop' : 'Start'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
