import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taxi_user/Components/ink_well_custom.dart';
import 'package:flutter_taxi_user/app_router.dart';
import 'package:flutter_taxi_user/theme/style.dart';
import 'package:flutter_taxi_user/Components/validations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_taxi_user/utility/network/ApiHelper.dart';
import 'package:flutter_taxi_user/utility/network/Constants.dart' as Constants;
import 'package:flutter_taxi_user/database/userinfo.dart';
import 'dart:io';
import 'package:flutter_taxi_user/database/triphistorydata.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool autovalidate = false;
  bool showpassword = true;
  Validations validations = new Validations();
  final Firestore _db = Firestore.instance;
  bool loginsuccess = true;
  Future _saveDeviceToken() async {
    // Get the current user
    String uid = 'logan';
    //  FirebaseUser user = await _auth.currentUser();
    // Get the token for this device
    fcmToken = await fcm.getToken();
    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _db
          .collection('users')
          .document(uid)
          .collection('tokens')
          .document(fcmToken);
      await tokens.setData({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }
 void test() {
      List<dynamic> testdata = jsonDecode(demotaxidriver);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            "login is wrong",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            FlatButton(
                color: Colors.green,
                child: Text("ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        ),
      );
    }
  _loginconnect() async {
    Map<String, dynamic> data = {
      "token": fcmToken,
      "domain": userinfo.domain,
      "email": userinfo.email,
      "password": userinfo.password,
      "phoneNumber": userinfo.phonenumber,
    };

   

/*    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("login is wrong",textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
        actions: <Widget>[
          FlatButton(
              color: Colors.green,
              child: Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
 */
    Navigator.of(context)
        .pushReplacementNamed(AppRoute.phoneVerificationScreen);
    ApiHelper.postRequest(Constants.BASE_URL_LOGIN, data).then((data) {
      userinfo.ids = data.data.ids;
      userinfo.email = data.data.email;
      if (!data.status) {
      } else {
        print(data.message);
        Navigator.of(context)
            .pushReplacementNamed(AppRoute.phoneVerificationScreen);
      }
    }).catchError((err) {
      print(err);
    });
  }

  submit() {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
    } else {
      form.save();
      _loginconnect();
    }
  }

  @override
  void initState() {
    super.initState();
    _saveDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: InkWellCustom(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Stack(children: <Widget>[
            Container(
              height: 250.0,
              width: double.infinity,
              color: Color(0xFFFDD148),
            ),
            Positioned(
              bottom: 450.0,
              right: 100.0,
              child: Container(
                height: 400.0,
                width: 400.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200.0),
                  color: Color(0xFFFEE16D),
                ),
              ),
            ),
            Positioned(
              bottom: 500.0,
              left: 150.0,
              child: Container(
                  height: 300.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150.0),
                      color: Color(0xFFFEE16D).withOpacity(0.5))),
            ),
            new Padding(
                padding: EdgeInsets.fromLTRB(32.0, 150.0, 32.0, 0.0),
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: new Column(
                      children: <Widget>[
                        new Container(
                            //padding: EdgeInsets.only(top: 100.0),
                            child: new Material(
                          borderRadius: BorderRadius.circular(7.0),
                          elevation: 5.0,
                          child: new Container(
                            width: MediaQuery.of(context).size.width - 20.0,
                            height: MediaQuery.of(context).size.height * 0.4,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: new Form(
                                key: formKey,
                                child: new Container(
                                  padding: EdgeInsets.all(32.0),
                                  child: new Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Login',
                                        style: heading35Black,
                                      ),
                                      new Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          TextFormField(
                                              keyboardType: TextInputType.phone,
                                              validator:
                                                  validations.validateMobile,
                                              onSaved: (value) {
                                                userinfo.phonenumber = value;
                                              },
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  prefixIcon: Icon(Icons.phone,
                                                      color: Color(
                                                          getColorHexFromStr(
                                                              '#FEDF62')),
                                                      size: 20.0),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 15.0,
                                                          top: 15.0),
                                                  hintText: 'Phone',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily:
                                                          'Quicksand'))),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          TextFormField(
                                              keyboardType: TextInputType.phone,
                                              validator:
                                                  validations.validatePassword,
                                              obscureText: showpassword,
                                              onSaved: (value) {
                                                userinfo.password = value;
                                              },
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  prefixIcon: Icon(Icons.lock,
                                                      color: Color(
                                                          getColorHexFromStr(
                                                              '#FEDF62')),
                                                      size: 20.0),
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      showpassword
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color: greyColor2,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        showpassword =
                                                            !showpassword;
                                                      });
                                                    },
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 15.0,
                                                          top: 15.0),
                                                  hintText: 'Password',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily:
                                                          'Quicksand'))),
                                        ],
                                      ),
                                      new ButtonTheme(
                                        height: 50.0,
                                        minWidth:
                                            MediaQuery.of(context).size.width,
                                        child: RaisedButton.icon(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      15.0)),
                                          elevation: 0.0,
                                          color: primaryColor,
                                          icon: new Text(''),
                                          label: new Text(
                                            'NEXT',
                                            style: headingWhite,
                                          ),
                                          onPressed: () {
                                            test();
                                    //        submit();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        )),
                        new Container(
                            padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                  "Create new account? ",
                                  style: textGrey,
                                ),
                                new InkWell(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed(AppRoute.signUpScreen),
                                  child: new Text(
                                    "Sign Up",
                                    style: textStyleActive,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ))),
          ])
        ]),
      )),
    );
  }
}
