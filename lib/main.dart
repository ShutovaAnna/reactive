import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterPage(),
    );
 }
}

class CounterPage extends StatefulWidget {
 @override
 _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
 final _counterController = StreamController<int>();
 int _counter = 0;

 @override
 void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      _counter++;
      _counterController.sink.add(_counter);
    });
 }

 @override
 void dispose() {
    _counterController.close();
    super.dispose();
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<int>(
          stream: _counterController.stream,
          initialData: 0,
          builder: (context, snapshot) {
            return Text(
              'Секундомер: ${snapshot.data}',
              style: Theme.of(context).textTheme.headlineMedium,
            );
          },
        ),
      ),
    );
 }
}
