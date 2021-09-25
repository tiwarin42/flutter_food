import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('FLUTTER FOOD'),
      ),
      body: Container(
        child: Center(
            child: Text(
          'THIS IS A HOME PAGE',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.blueGrey),
        )),
      ),
    );
  }
}
