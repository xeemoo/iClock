import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iclock_flutter/widget/clock_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Builder(
          builder: (context) {
            bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
            return ClockWidget(onPressed: () {
              if (isLandscape) {
                Scaffold.of(context).openEndDrawer();
              } else {
                _openBottomSheet(context);
              }
            });
          },
        ),
      ),
      endDrawer: Drawer(
        child: _settingsCell(),
      ),
    );
  }

  _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return _settingsCell();
      },
    );
  }

  Widget _settingsCell() {
    return Container(
      height: 300,
      width: 300,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Text("Made with ❤ by xeemoo"),
          SizedBox(height: 14,),
        ],
      ),
    );
  }
}
