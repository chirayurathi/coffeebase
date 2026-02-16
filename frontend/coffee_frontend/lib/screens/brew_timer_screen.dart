import 'dart:async';
import 'package:flutter/material.dart';

class BrewTimerScreen extends StatefulWidget {
  final List<Map<String, dynamic>> steps;
  const BrewTimerScreen({super.key, required this.steps});

  @override
  _BrewTimerScreenState createState() => _BrewTimerScreenState();
}

class _BrewTimerScreenState extends State<BrewTimerScreen> {
  int _currentStepIndex = 0;
  int _remainingSeconds = 0;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.steps[_currentStepIndex]['duration'];
  }

  void _startTimer() {
    setState(() => _isRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _nextStep();
        }
      });
    });
  }

  void _nextStep() {
    if (_currentStepIndex < widget.steps.length - 1) {
      _currentStepIndex++;
      _remainingSeconds = widget.steps[_currentStepIndex]['duration'];
    } else {
      _timer?.cancel();
      _isRunning = false;
      _showFinishedDialog();
    }
  }

  void _showFinishedDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Brew Finished!'),
        content: const Text('Enjoy your coffee.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = widget.steps[_currentStepIndex];
    return Scaffold(
      appBar: AppBar(title: const Text('Brew Timer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(currentStep['title'], style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(currentStep['description'], style: const TextStyle(fontSize: 18, color: Colors.white54)),
            const SizedBox(height: 64),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: CircularProgressIndicator(
                    value: _remainingSeconds / currentStep['duration'],
                    strokeWidth: 12,
                    color: const Color(0xFF8D6E63),
                    backgroundColor: Colors.white10,
                  ),
                ),
                Text(
                  '$_remainingSeconds',
                  style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 64),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 64,
                  icon: Icon(_isRunning ? Icons.pause_circle : Icons.play_circle),
                  onPressed: _isRunning ? () => setState(() { _isRunning = false; _timer?.cancel(); }) : _startTimer,
                  color: const Color(0xFF8D6E63),
                ),
                IconButton(
                  iconSize: 64,
                  icon: const Icon(Icons.skip_next),
                  onPressed: _nextStep,
                  color: Colors.white54,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
