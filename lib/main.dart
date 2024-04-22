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
 int _counter = 0; //управляет счетчиком

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
    super.dispose(); //метод, чтобы избежать уутечек памяти
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<int>( //отображает текущее значение
          stream: _counterController.stream,
          initialData: 0,
          builder: (context, snapshot) {
            return Text(
              'Счет ${snapshot.data}',
              style: Theme.of(context).textTheme.headlineMedium,
            );
          },
        ),
      ),
    );
 }
}
