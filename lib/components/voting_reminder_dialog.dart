import 'dart:async';

import 'package:flutter/material.dart';

class VotingReminderDialog extends StatefulWidget {
  @override
  State<VotingReminderDialog> createState() => _VotingReminderDialogState();
}

class _VotingReminderDialogState extends State<VotingReminderDialog> {
  var maxSeconds = 3;
  var secondsLeft = 3;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsLeft > 0) {
          secondsLeft--;
        } else {
          timer.cancel();
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Reminder'),
      content:
          const Text('You only have 3 minutes to vote. Please choose wisely.'),
      actions: [
        Text("Closes in $secondsLeft",
          style: const TextStyle(color: Colors.red),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            _timer?.cancel();
          },
          child: const Text('Understood'),
        ),
      ],
    );
  }
}
