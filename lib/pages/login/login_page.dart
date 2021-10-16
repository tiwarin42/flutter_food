import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_food/pages/home/home_page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var input = '';
  var count = 0;
  // var password = '123456';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // ไล่เฉดจากมุมบนซ้ายไปมุมล่างขวาของ Container
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // ไล่เฉดจากสีแดงไปสีน้ำเงิน
            // stops: [
            //   0.0,
            //   0.95,
            //   1.0,
            // ],
            colors: [
              Colors.white,
              Colors.teal,
              // Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 100.0,
                        color: Colors.teal.shade700,
                      ),
                      Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade700,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Enter PIN to login',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.blueGrey[700],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var i = 0; i < count; i++)
                              Icon(
                                Icons.circle,
                                color: Colors.teal,
                                size: 30.0,
                              ),
                            for (var j = 0; j < (6 - count); j++)
                              Icon(
                                Icons.circle_outlined,
                                color: Colors.teal,
                                size: 30.0,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    // for (var row = 0; row < 3; row++)
                    //   Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       for (var col = 1; col <= 3; col++)
                    //         LoginButton(number: row * 3 + col),
                    //       //right click => refactor Extract flutter Widget OR Ctrl + Alt + W
                    [1, 2, 3],
                    [4, 5, 6],
                    [7, 8, 9],
                    [-2, 0, -1],
                  ].map((row) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: row.map((item) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LoginButton(
                            number: item,
                            onClick: _handleClickButton,
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleClickButton(int num) async {
    print('Number: $num');
    setState(() {
      if (num == -1) {
        if (input.length > 0) input = input.substring(0, input.length - 1);
        count--;
      } else {
        input = '$input$num';
        count++;
      }
    });
    if (input.length == 6) {
      var url = Uri.parse('https://cpsu-test-api.herokuapp.com/login');
      var response = await http.post(url, body: {'pin': input});
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonbody = json.decode(response.body);
        bool data = jsonbody['data'];
        setState(() {
          if (data == true) {
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          } else {
            input = '';
            count = 0;
            return _showMaterialDialog(
                'ERROR', 'Invalid PIN. Please try again.');
          }
        });
      }
    }
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: 30, color: Colors.red),
          ),
          content: Text(
            msg,
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              style: TextButton.styleFrom(
                textStyle: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  final int number;
  final Function(int) onClick;

  const LoginButton({
    Key? key,
    required this.number,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: number == -2 ? null : () => onClick(number),
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: number == -2
            ? null
            : BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
                border: Border.all(width: 3.0, color: Colors.teal),
              ),
        child: Center(
          child: number >= 0
              ? Text(
                  '$number',
                  style: Theme.of(context).textTheme.headline6,
                )
              : number == -1
                  ? Icon(
                      Icons.backspace_outlined,
                      size: 28.0,
                    )
                  : SizedBox.shrink(),
        ),
      ),
    );
  }
}
