// import 'dart:html';
import 'dart:io';
// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pharmacy/Pages/Home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy/globals.dart';

class UserPro extends StatefulWidget {
  @override
  _UserProState createState() => _UserProState();
}

class _UserProState extends State<UserPro> {
//  File _image;
//  Future getImage(bool isCamera) async {
//    File image;
//    if (isCamera) {
//      image = await ImagePicker.pickImage(source: ImageSource.camera);
//    } else
//      image = await ImagePicker.pickImage(source: ImageSource.gallery);
//    setState(() {
//      _image = image;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('الشخصــية'),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: FadeInImage.assetNetwork(
                        placeholder: 'lib/assets/mylogo.jpg',
                        image: userImage != null ? baseImageURL + userImage : baseImageURL + '',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightBlue),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                          hintText: userName != null ? userName : 'الاسم',
                          labelStyle: TextStyle(color: Colors.grey),
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          icon: Icon(
                            Icons.business_center,
                            color: Colors.lightBlue.withOpacity(0.8),
                          ),
                        )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightBlue),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: TextFormField(
                          enabled: false,
                            decoration: InputDecoration(
                              hintText: '*************',
                          labelStyle: TextStyle(color: Colors.grey),
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          icon: Icon(
                            Icons.lock,
                            color: Colors.lightBlue.withOpacity(0.8),
                          ),
                        )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightBlue),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: userPhone != null ? userPhone : 'رقم الجوال',
                          labelStyle: TextStyle(color: Colors.grey),
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          icon: Icon(
                            Icons.call,
                            color: Colors.lightBlue.withOpacity(0.8),
                          ),
                        )),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                //+++++++++++++++++++++++++++++++
                SizedBox(
                    // height: 20,
                    ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightBlue),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: userEmail != null ? userEmail : 'البريد الالكتروني',
                          labelStyle: TextStyle(color: Colors.grey),
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          icon: Icon(
                            Icons.email,
                            color: Colors.lightBlue.withOpacity(0.8),
                          ),
                        )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ), //+++++++++++++++++++++++++++++
                Padding(
                  padding: const EdgeInsets.only(
                    right: 50,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                      ),

//
                      Container(
                        margin: EdgeInsets.only(
                          top: 170,
                        ),
                        width: 300,
                        height: 50,
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(35),
                              side: BorderSide(color: Colors.blue)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  // left: 23,
                                  right: 110,
                                ),
//
                              ),

                              Text(
                                'حفظ',
                                style: TextStyle(fontSize: 30),
                              ),

//
                            ],
                          ),

//
                        ),
                      ),
                    ],
                  ),
                )

                //+++++++++++++++++++++++++++++
                //+++++++++++++++++++++++++++++++++++++++++++++++++++++
              ],
            ),
          ),
        ),
      ),
    );
  }
}
