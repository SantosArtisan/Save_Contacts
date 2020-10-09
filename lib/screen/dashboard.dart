import 'dart:convert';
import 'package:contact/screen/about.dart';
import 'package:contact/screen/addContact.dart';
import 'package:contact/screen/displayContact.dart';
import 'package:contact/screen/login.dart';
import 'package:contact/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

List datauser;
int count = 0;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

final _formKey = GlobalKey<FormState>();

class _DashboardState extends State<Dashboard> {
  bool isSearching = false;

  String search;
  String userfname;
  String usersname;
  String usermname;
  String useremail;
  TextEditingController searchController = new TextEditingController();

  submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      populateContact();
    } else {}
  }

  ConnectivityResult result;
  checkConnection() async {
    result = await Connectivity().checkConnectivity();
  }

  populate() async {
    final response =
        await http.post("http://teamcoded.com.ng/contact_operation.php", body: {
      "request": "SEARCH CONTACTS",
      "search": '',
      "user": user,
    });

    setState(() {
      datauser = jsonDecode(response.body);
    });

    return 'Success';
  }

  populateContact() async {
    final response =
        await http.post("http://teamcoded.com.ng/contact_operation.php", body: {
      "request": "SEARCH CONTACTS",
      "search": search,
      "user": user,
    });

    setState(() {
      datauser = jsonDecode(response.body);
    });

    return 'Success';
  }

//

  getData() {
    user = Constants.sharedPreferences.getString('user');
    useremail = Constants.sharedPreferences.getString('useremail');
    userfname = Constants.sharedPreferences.getString('userfname');
    usersname = Constants.sharedPreferences.getString('usersname');
    usermname = Constants.sharedPreferences.getString('usermname');
  }

  @override
  void initState() {
    super.initState();
    getData();
    populate();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    checkConnection();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1287A5),
        title: !isSearching
            ? Text(
                'Contacts',
                style: TextStyle(fontFamily: 'Alike'),
              )
            : Form(
                key: _formKey,
                child: TextFormField(
                  controller: searchController,
                  onSaved: (value) => search = value,
                  onChanged: (val) {
                    submitForm();
                  },
                  style: TextStyle(color: Colors.black54, fontFamily: 'Alike'),
                  cursorColor: Colors.black87,
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.white),
                    hintText: 'Search Here',
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.black87),
                  ),
                ),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                    });
                  })
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  })
        ],
      ),
      body: datauser.isNotEmpty ? 
           ListView(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: datauser == null ? 0 : datauser.length,
                        itemBuilder: (BuildContext context, int index) {
                          return contact(
                            char: datauser[index]['contact_name'][0]
                                .toUpperCase(),
                            name: datauser[index]['contact_name'],
                            id: count++,
                            populate: populate,
                            contactId: datauser[index]['contact_id'],
                            route:  () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DisplayContact(id: datauser[index]['contact_id'],)));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            )
          : Center(child: Text('No record found')),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1287A5),
              ),
              accountName: Text(userfname != null ? userfname+ " " + usersname+" " + usermname :" "), 
              accountEmail: Text(useremail != null ?useremail : " "),
              currentAccountPicture: CircleAvatar(
                radius: 50,
                child: Icon(Icons.phone, size: 60, color: Colors.grey),
                backgroundColor: Colors.grey[200],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.home),
              title: Text('Home'),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => About()));
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              onTap: () {
                Constants.sharedPreferences.clear();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Login()));
              },
              leading: Icon(Icons.lock),
              title: Text('Logout'),
              trailing: Icon(Icons.arrow_right),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddContact()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF1287A5),
      ),
    );
  }
}

contact(
    {String char,
    String name,
    int id,
    context,
    populate,
    String contactId,
    Function route}) {
  return InkWell(
    onTap: route,
    child: Padding(
      padding: const EdgeInsets.only(
          left: 10.0, right: 0.0, top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: id.isEven ? Colors.blue : Colors.green,
                child: Text(char),
              ),
              SizedBox(width: 15.0),
              Text(
                name,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                  child: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text('Confirm'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        'Are you sure you want to delete this contact ?'),
                                    SizedBox(height: 25.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RaisedButton(
                                          onPressed: () {
                                             Navigator.of(context, rootNavigator: true)
                                              .pop('dialog');
                                          },
                                          child: Text(
                                            'No',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Colors.green,
                                        ),
                                        RaisedButton(
                                          onPressed: () async {
                                            await http.post(
                                                'http://teamcoded.com.ng/contact_operation.php',
                                                body: {
                                                  'request': 'DELETE CONTACT',
                                                  'id': contactId,
                                                });

                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop('dialog');
                                            populate();
                                          },
                                          child: Text('Yes',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          color: Colors.red,
                                        ),
                                      ],
                                    )
                                  ],
                                ));
                          },
                        );
                      }))
            ];
          }),
        ],
      ),
    ),
  );
}
