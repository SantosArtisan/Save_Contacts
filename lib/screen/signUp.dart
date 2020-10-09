
import 'dart:async';
import 'package:contact/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
_showSnackBar(context) {
  final snackbar = new SnackBar(
    content: Text(
      'Sign up Sucessfully',
      style: TextStyle(
        color: Colors.white,
        backgroundColor: Colors.black,
      ),
    ),
    onVisible: (){
      Timer(Duration(seconds: 3), (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      });
    },
  );
  _scaffoldKey.currentState.showSnackBar(snackbar);
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  TextEditingController firstnameController = new TextEditingController();
  TextEditingController surnameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController middlenamesController = new TextEditingController();

  String firstname;
  String surname;
  String middlenames;
  String email;
  String phone;
  String password;
  File imageFile;

  void _signUp() async {

    final uri = Uri.parse('http://teamcoded.com.ng/contact_operation.php');
    var request = http.MultipartRequest('Post', uri);
    request.fields['request'] = "ADD USER";
    request.fields['userFname'] = firstname;
    request.fields['userSname'] = surname;
    request.fields['userMname'] = middlenames;
    request.fields['phone'] = phone;
    request.fields['email'] = email;
    request.fields['password'] = password;

    var pick = await http.MultipartFile.fromPath('image', imageFile.path);
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
      _signUp();
      
    } else {
      //_showErrorDialog();

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
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Center(child: showImage() ),
                    Positioned(
                      right: 10.0,
                      bottom: 15.0,
                      child: IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                          ),
                          onPressed: () {
                            selectImage();
                          }),
                    )
                  ],
                ),
                Container(
                    child: Column(
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1287A5),
                      ),
                    ),
                    Text(
                      'Create a new account',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1287A5),
                      ),
                    ),
                  ],
                )),
                SizedBox(height: 20),
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: firstnameController,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                          cursorColor: Color(0xFF1287A5),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person, color: Color(0xFF1287A5),),
                            hintText: 'FirstName',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) => firstname = value,
                          validator: (value) => value.length == 0
                              ? " Firstname cannot be empty"
                              : null,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: surnameController,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                          cursorColor: Colors.teal,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person, color: Color(0xFF1287A5),),
                            hintText: 'SurName',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) => surname = value,
                          validator: (value) => value.length == 0
                              ? " Surname cannot be empty"
                              : null,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: middlenamesController,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.name,
                          cursorColor: Colors.teal,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person, color: Color(0xFF1287A5),),
                            hintText: 'MiddleName',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) => middlenames = value,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.teal,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Color(0xFF1287A5),),
                            hintText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) => email = value,
                          validator: (value) =>
                              value.length == 0 ? "Email cannot be empty" : null,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          cursorColor: Colors.teal,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone, color: Color(0xFF1287A5),),
                            hintText: 'Mobile Number',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) => phone = value,
                          validator: (value) => value.length == 0
                              ? " Mobile Number cannot be empty"
                              : null,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          cursorColor: Colors.teal,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock, color: Color(0xFF1287A5),),
                            hintText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) => password = value,
                          validator: (value) => value.length == 0
                              ? 'Password cannot be empty'
                              : null,
                        ),
                        SizedBox(height: 10),
                        RaisedButton(
                          onPressed: () {
                            submitForm();
                          },
                          color: Color(0xFF1287A5),
                          textColor: Colors.white,
                          child: Text('CREATE ACCOUNT'),
                        ),
                        SizedBox(height: 20),
                        Container(
                            child: Center(
                                child: Row(
                          children: [
                            Text("Already have a account"),
                            SizedBox(width: 10.0),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Login()));
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Color(0xFF1287A5),
                                ),
                              ),
                            )
                          ],
                        )))
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  showImage() {
    if (imageFile != null) {
      return CircleAvatar(
        backgroundImage: FileImage(imageFile),
        radius: 70,
      );
    } else {
      return CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: Icon(
          Icons.person,
          size: 90,
        ),
        radius: 70,
      );

    }
  }

  void selectImage(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: (){
               Navigator.of(context, rootNavigator: true).pop('dialog');

                chooseImage(ImageSource.camera);

              },
              child: Row(
                children: [
                Icon(Icons.camera_alt),
                SizedBox(width:20),
                Text('Take Photo'),
              ],),
            ),
            SizedBox(height:29),
            InkWell(
              onTap: (){
                chooseImage(ImageSource.gallery);
               Navigator.of(context, rootNavigator: true).pop('dialog');


              },
              child: Row(children: [
                Icon(Icons.photo_library),
                SizedBox(width:20),
                Text('Choose Photo'),
              ],),
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

  }


}
