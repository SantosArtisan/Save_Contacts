import 'dart:async';
import 'dart:convert';

import 'package:contact/screen/dashboard.dart';
import 'package:contact/screen/signUp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:contact/util/constant.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
final GlobalKey <ScaffoldState>_scaffoldKey = new GlobalKey<ScaffoldState>();


class _LoginState extends State<Login> {
 
final _formKey = GlobalKey<FormState>();
 bool isLoading = false;
_showSnackBar(){
  final snackbar = new SnackBar(
    content: Text('Login Sucessfully',
    style: TextStyle(
      color: Colors.white,
      backgroundColor: Colors.black,  
    ),), 
    onVisible: (){
      Timer(Duration(seconds: 3), (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dashboard()));
      });
    },
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
}

_showIncorrectSnackBar(){
  final snackbar = new SnackBar(
    content: Text('Login Fail',
    style: TextStyle(
      color: Colors.white,
      backgroundColor: Colors.black,  
    ),), 
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
}
String user;
String email;
String password;
 var varemail ;
 var varpassword;
 List varid;

 TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

 Future<List> _login() async{

    final response = await http.post("http://teamcoded.com.ng/contact_operation.php", body:{
      "request" : "USER LOGIN",
      "email": email,
      "password": password,

    });

    var datauser = json.decode(response.body);
    print(datauser);

    
     if (datauser.length==0) {
      setState(() {
        isLoading=false;
      isLoading ?
      _showDialog()
      : Navigator.of(context, rootNavigator: true).pop('dialog');
        _showIncorrectSnackBar();
      
      });
      
    }else{

    if(response.statusCode ==200){
      setState(() {
        varemail = datauser[0]['email'];
        varpassword = datauser[0]['password'];
        Constants.sharedPreferences.setString("user", datauser[0]['user_id']);
        Constants.sharedPreferences.setString("useremail", datauser[0]['email']);
        Constants.sharedPreferences.setString("userfname", datauser[0]['user_fname']);
        Constants.sharedPreferences.setString("usersname", datauser[0]['user_sname']);
        Constants.sharedPreferences.setString("usermname", datauser[0]['user_mname']);
        varid = datauser;
        setState(() {
        isLoading = false;
      });
      isLoading ?
      _showDialog()
      : Navigator.of(context, rootNavigator: true).pop('dialog');
      Timer(Duration(seconds: 3), (){});
        _showSnackBar();
        
      });
    
    }
      return datauser;
      
    }


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
      _login();
      
    } else {
     // _showErrorDialog();

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

  getData(){
   user = Constants.sharedPreferences.getString('user');
  }

  checkLogin(){

    if (user != null) {
      Future.delayed(Duration.zero,(){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Dashboard()));
      });
      
    } else {

    }

  }


  @override
  void initState() {
    super.initState();
    getData();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
       body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 80.0, 15.0, 10.0),
            child: Column(
              children: [
                Container(
                  child:Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        child: Image.asset('img/icon.png'),
                      
                      ),
                      SizedBox(height:20),
                      Text('Welcome Back',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1287A5),
                      ),
                      ),
                      Text('Sign in to continue',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1287A5),
                      ),
                      ),
                    ],
                  )
                ),
                SizedBox(height:20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.teal,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email, color: Color(0xFF1287A5),),
                          hintText: 'Email',
                          border: OutlineInputBorder(),  
                        ),
                        onSaved: (value) => email =  value,
                        validator: (value)=> value.length == 0? "Email cannot be empty" : null, 
                      ),
                      SizedBox(height:20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        cursorColor: Colors.teal,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Color(0xFF1287A5),),
                          hintText: 'Password',
                          border: OutlineInputBorder(),  
                        ),
                        onSaved: (value) => password =  value,
                        validator: (value)=> value.length == 0? "Password cannot be empty" : null, 
                      ),
                      SizedBox(height:20),
                      Container(
                        child:InkWell(
                          child: Text('Forget Password ?', 
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color:Color(0xFF1287A5),
                          ),
                          )
                        )
                      ),
                       SizedBox(height:20),
                      RaisedButton(
                        onPressed: (){
                         submitForm();
                        },
                        color: Color(0xFF1287A5),
                        textColor: Colors.white,
                        child: Text('LOGIN'),
                      ),
                      SizedBox(height:20),
                     Container(
                        child: Center(
                          child: Row(
                            children: [
                              Text("Don't have account ?"),
                              SizedBox(width:10.0),
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp()));
                                },
                                child: Text('Create a new account',
                                style: TextStyle(
                                  color:Color(0xFF1287A5),
                                ),
                                ),
                              )
                            ],
                          )
                        )
                      )
                    ],
                  )
                ) 
              ],
            ),
          ),
        ],
      ),  
    );
  }
}