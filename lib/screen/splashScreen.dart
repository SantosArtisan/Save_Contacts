import 'dart:async';

import 'package:flutter/material.dart';
import 'package:contact/screen/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() { 
    super.initState();
    Timer(Duration(seconds: 3), route);
  }
  route(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color:Colors.white,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('img/icon.png'),
                      SizedBox(height:20),
                      Text('Save Contact',
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'Satisfy',
                        
                      ),
                      ),
                    ],
                  ),
                ) 
              ),
            ],
          )
        ],
      ),
      
    );
  }
}