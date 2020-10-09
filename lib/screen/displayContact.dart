import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


import 'package:flutter/material.dart';

class DisplayContact extends StatefulWidget {
  DisplayContact({this.id});
  final String id;
  
  @override
  _DisplayContactState createState() => _DisplayContactState();
}

class _DisplayContactState extends State<DisplayContact> {
File imageFile;
List datauser;

 populate() async {
    final response =
        await http.post("http://teamcoded.com.ng/contact_operation.php", body: {
      "request": "GET CONTACT",
      "id": widget.id,
    });

    setState(() {
      datauser = jsonDecode(response.body);
    });

    return 'Success';
  }
  @override
  void initState() {
    super.initState();
    populate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView(
       children: [
         Form(
           child: Column(
             children: [
               datauser !=null ? showImage(context, datauser) : Container(),
               Container(
                 padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 10.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children: [

                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                          children: [
                            CircleAvatar(
                              child: Icon(Icons.mail,),
                              backgroundColor: Color(0xFF1287A5),
                            ),
                            SizedBox(width:20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                                Text('Saved to',
                            style: TextStyle(),
                            ),
                             Text(datauser != null ? datauser[0]['contact_email']: " ",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                            ),
                             ],
                            ),
                          ], 
                         ),
                          Icon(Icons.arrow_forward_ios, size: 15, color: Colors.black54,)
                       ],
                     ),
                     SizedBox(height:20),
                     Row(
                      children: [
                        iconData(Icons.person_outline),
                        SizedBox(width:20.0),
                        Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(datauser != null ? datauser[0]['contact_name']: " "),
                              Divider(),
                            ],
                          ),
                        ),
                       
                      ], 
                     ), 
                      SizedBox(height:20),
                     Row(
                      children: [
                        iconData(Icons.phone),
                        SizedBox(width:20.0),
                        Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(datauser != null ? datauser[0]['contact_no']: " "),
                              Divider(),
                            ],
                          ),
                        ),

                      ], 
                     ),
                      SizedBox(height:20),
                     Row(
                      children: [
                        iconData(Icons.email),
                        SizedBox(width:20.0),
                        Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(datauser != null ? datauser[0]['contact_email']: " "),
                              Divider(),
                            ],
                          ),
                        ),

                      ], 
                     ),
                      SizedBox(height:20),
                     Row(
                      children: [
                        iconData(Icons.location_on),
                        SizedBox(width:20.0),
                        Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(datauser != null ? datauser[0]['contact_address']: " "),
                              Divider(),
                            ],
                          ),
                        ),

                      ], 
                     ),

                     SizedBox(height:20),

                     Padding(
                       padding: const EdgeInsets.only(left:20.0, right: 19.0),
                       child: RaisedButton(onPressed: (){
                         Navigator.of(context).pop();

                       },
                       child: Text('Go Back'),
                       ),
                     )

                   ],
                 ),
               ),
             ],

           ),
         )
       ], 
      ),
      
    );
  }
}

 showImage(context,  datauser) {
if (datauser != null) {
      return Container(
                 decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage('http://teamcoded.com.ng/contact_uploads/${datauser[0]['contact_picture']}',), fit: BoxFit.cover) 
                 ),
                 height: MediaQuery.of(context).size.height*0.4,
                 child: Stack(
                  children: [
                   
                    Positioned(
                      left: 10.0,
                      bottom: 5.0,
                      child:Opacity(
                        opacity: 0.8,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                          color: Colors.black87
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left:10.0),
                            child: Text( datauser !=null ? datauser[0]['contact_name'] : " ", style: TextStyle(
                              color:Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600
                              
                            )
                            ,),
                          ),
                        ),
                      ),)
                  ], 
                 ),
               );
    } else {
      return Container(
                 color: Colors.blueGrey,
                 height: MediaQuery.of(context).size.height*0.4,
                 child: Stack(
                  children: [
                    Center(
                     child: Icon(Icons.person_outline, size: 230, color: Colors.grey[400],), 
                    ),
                    Positioned(
                      left: 10.0,
                      bottom: 4.0,
                      child: Text(datauser != null ? datauser[0]['contact_name'] : " ", style: TextStyle(
                        color:Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600
                        
                      )
                      ,),
                      )
                  ], 
                 ),
               );

    }
  }

Widget iconData(IconData icon){
 
  return CircleAvatar(
    child: Icon(icon, color: Colors.grey[500], size: 40.0,),
    backgroundColor: Colors.grey[200],
    radius: 25,
  );
}