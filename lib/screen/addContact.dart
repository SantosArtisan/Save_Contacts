
import 'dart:async';
import 'dart:io';

import 'package:contact/screen/dashboard.dart';
import 'package:contact/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:image_picker/image_picker.dart';

String user;
String useremail;
 
class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
_showSnackBar(context) {
  final snackbar = new SnackBar(
    content: Text(
      'Sucessfully',
      style: TextStyle(
        color: Colors.white,
        backgroundColor: Colors.black,
      ),
    ),
    onVisible: (){
      Timer(Duration(seconds: 1), (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dashboard()));
      });
    },
  );
  _scaffoldKey.currentState.showSnackBar(snackbar);
}

class _AddContactState extends State<AddContact> {
  String name;
  String phone;
  String address;
  String email;
 File imageFile;

  final _formKey = new GlobalKey<FormState>();

  TextEditingController nameController = new TextEditingController(); 
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  bool isLoading = false;

    getData(){
   user = Constants.sharedPreferences.getString('user');
   useremail = Constants.sharedPreferences.getString('useremail');
  }

  @override
  void initState() {
    super.initState();
    getData();
  }


  void _addContact() async {

    final uri = Uri.parse('http://teamcoded.com.ng/contact_operation.php');
    var request = http.MultipartRequest('Post', uri);
    request.fields['request'] = "ADD CONTACT";
    request.fields['cName'] = name;
    request.fields['cNo'] = phone;
    request.fields['cAddress'] = address;
    request.fields['cEmail'] = email;
    request.fields['user'] = user;

    var pick = await http.MultipartFile.fromPath('image', imageFile .path);
    request.files.add(pick);
    var response = await request.send();

    // final response =
    //     await http.post("http://teamcoded.com.ng/contact_operation.php", body: {
    //   "request": "ADD USER",
    //   "userFname": firstname,
    //   "userSname": surname,
    //   "userMname": middlenames,
    //   "email": email,
    //   "password": password,
    // });

    if (response.statusCode == 200) {
       setState(() {
        isLoading = false;
      });
      isLoading ?
      _showDialog()
      : Navigator.of(context, rootNavigator: true).pop('dialog');
      _showSnackBar(context);
    }

    setState(() {
      isLoading = false;
    });
  }
   submitForm(){
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        isLoading = true;
      });
      isLoading ?
      _showDialog()
      : Navigator.of(context, rootNavigator: true).pop('dialog');
      Timer(Duration(seconds: 3), (){});
      _addContact();
      
    } else {
      _showErrorDialog();

    }

  }

  _showDialog(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width:25.0),
            Text('Please wait...'),
            

          ],)
      );
    },);
  }

   _showErrorDialog(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content: Row(
          children: [
            Icon(Icons.cancel, color: Colors.orangeAccent,),
            SizedBox(width:25.0),
            Text('Fill all required fields'),
          
          ],)
      );
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
         backgroundColor: Color(0xFF1287A5),
       title: Text('Create new contact'), 
       actions: [
        FlatButton(onPressed: (){
          submitForm();
        }, 
        child: Text('SAVE', style: TextStyle(
          color:Colors.white,
        ),)),
       ],
      ),
      body: ListView(
       children: [
         Form(
           key: _formKey,
           child: Column(
             children: [
               showImage(context, selectImage, imageFile),
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
                                Text('Saving to',
                            style: TextStyle(),
                            ),
                             Text(useremail,
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
                          child: TextFormField(
                            validator: (value) => value.length == 0 ? 'Fullname cannot be empty' : null,
                            controller: nameController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding: EdgeInsets.all(10.0),
                              hintText: 'FullName',
                              fillColor: Colors.transparent,
                            ),
                            onSaved: (value) => name  = value,
                            
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
                          child: TextFormField(
                            validator: (value) => value.length == 0 ? 'Mobile Number cannot be empty' : null,
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding: EdgeInsets.all(10.0),
                              hintText: 'Mobile Number',
                              fillColor: Colors.transparent,
                            ),
                            onSaved: (value) => phone  = value,
                            
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
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding: EdgeInsets.all(10.0),
                              hintText: 'Email Address',
                              fillColor: Colors.transparent,
                            ),
                            onSaved: (value) => email  = value,
                            
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
                          child: TextFormField(
                            controller: addressController,
                             textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding: EdgeInsets.all(10.0),
                              hintText: 'Address',
                              fillColor: Colors.transparent,
                            ),
                            onSaved: (value) => address  = value,
                            
                          ),
                        ),

                      ], 
                     ),

                     SizedBox(height:50),

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

  void selectImage(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: (){
                chooseImage(ImageSource.camera);
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width:20),
                  Text('Take Photo'),
                ],),
              ),
            ),
           
            InkWell(
              onTap: (){
                chooseImage(ImageSource.gallery);

              },
              child: Padding(
                padding: const EdgeInsets.only(left:20.0, right: 20.0, top: 20.0, bottom: 20.0),
                child: Row(children: [
                  Icon(Icons.photo_library),
                  SizedBox(width:20),
                  Text('Choose Photo'),
                ],),
              ),
            )

          ],)
      );
    },);
  }

  chooseImage(ImageSource source) async{
    var pickedImage = await ImagePicker.pickImage(source: source);
    setState(() {
      imageFile = pickedImage;
    });
  Navigator.of(context, rootNavigator: true).pop('dialog');
  }
}

  showImage(context, selectImage, imageFile) {
if (imageFile != null) {
      return Container(
                 decoration: BoxDecoration(
                  image: DecorationImage(image: FileImage(imageFile,), fit: BoxFit.cover) 
                 ),
                 height: MediaQuery.of(context).size.height*0.3,
                 child: Stack(
                  children: [
                   
                    Positioned(
                      right: 10.0,
                      bottom: 20.0,
                      child: IconButton(icon: Icon(Icons.camera_alt, size: 30.0, color: Colors.grey[200],), onPressed: (){
                        selectImage();
                      }))
                  ], 
                 ),
               );
    } else {
      return Container(
                 color: Colors.blueGrey,
                 height: MediaQuery.of(context).size.height*0.3,
                 child: Stack(
                  children: [
                    Center(
                     child: Icon(Icons.person_outline, size: 230, color: Colors.grey[400],), 
                    ),
                    Positioned(
                      right: 10.0,
                      bottom: 20.0,
                      child: IconButton(icon: Icon(Icons.camera_alt, size: 30.0, color: Colors.grey[200],), onPressed: (){
                        selectImage();
                      }))
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

