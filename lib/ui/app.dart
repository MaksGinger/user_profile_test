import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  static const String _title = 'User Profile';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: Scaffold(
        body: SizedBox(),
      ),
    );
  }
}
