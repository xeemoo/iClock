import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

class ClockWidget extends StatefulWidget {
  final VoidCallback? onPressed;

  const ClockWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ClockWidgetState();
  }
}

class _ClockWidgetState extends State<ClockWidget> {
  var now = DateTime.now();
  Timer? _timer;

  @override
  void initState() {
    Wakelock.toggle(enable: true);
    super.initState();
    _start();
  }

  @override
  void dispose() {
    Wakelock.toggle(enable: false);
    super.dispose();
    _stop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      padding: const EdgeInsets.only(left: 26, right: 26),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AutoSizeText.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "${_formatTime(now.hour)}:${_formatTime(now.minute)}",
              ),
              TextSpan(
                text: " ${_formatTime(now.second)}",
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 100,
                  fontFeatures: [FontFeature.tabularFigures(),],
                ),
              )
            ],
          ),
          maxLines: 1,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 300,
          ),
        ),
      ),
    );
  }

  _start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  _stop() {
    _timer?.cancel();
  }

  String _formatTime(int num) {
    if (num < 10) {
      return "0$num";
    }
    return num.toString();
  }
}
