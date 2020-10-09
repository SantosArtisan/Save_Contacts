import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1287A5),
        title: Text('About'),
      ),

      body: Column(
        children:<Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
            child: Text('This application is design to allow registered users to save their contacts online for easy access to the saved contacts',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontFamily: 'satisfy',
                    ),
                    textAlign: TextAlign.center,
           
            ),
          ),
          SizedBox(height:20),
          Container(
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
                      Text('Version 1.0.0')
                    ],
                  ),
                ) 
          
          
        ]
      ),
      
    );
  }
}