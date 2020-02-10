import 'package:flutter/material.dart';
import 'package:pharmacy/Pages/PHome.dart';

import '../globals.dart';

class AdminPro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('البروفايل'),
          ),
          body: SingleChildScrollView(
            child: Column(
              //  crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40,),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'lib/assets/mylogo.jpg',
                          image: baseImageURL + userImage,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ), //_______________LogoApp___________
                    SizedBox(height: 30,),
//===========
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightBlue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: userName != null ? userName : 'الاسم',
                              labelStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              icon: Icon(
                                Icons.business_center,
                                color: Colors.lightBlue.withOpacity(0.8),
                              ),
                            )),
                          ),
                        ), //______circale_______
                      ),
                    ), //________________________
                    SizedBox(
                      height: 20,
                    ), //==========
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightBlue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: '*************',
                              labelStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              icon: Icon(
                                Icons.lock,
                                color: Colors.lightBlue.withOpacity(0.8),
                              ),
                            )),
                          ),
                        ),
                      ),
                    ), //________________________________
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightBlue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: userPhone != null ? userPhone : 'رقم الجوال',
                              labelStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              icon: Icon(
                                Icons.call,
                                color: Colors.lightBlue.withOpacity(0.8),
                              ),
                            )),
                          ),
                        ),
                      ),
                    ), //____________________End_____________________
                    SizedBox(
                      height: 20,
                    ), //========
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightBlue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: userLicence != null ? userLicence : 'رقم الرخصه',
                              labelStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              icon: Icon(
                                Icons.fiber_pin,
                                color: Colors.lightBlue.withOpacity(0.8),
                              ),
                            )),
                          ),
                        ),
                      ),
                    ), //______________End______________
                    SizedBox(
                      height: 20,
                    ), //=======
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightBlue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: userEmail != null ? userEmail : 'البريد الالكتروني',
                              labelStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              icon: Icon(
                                Icons.email,
                                color: Colors.lightBlue.withOpacity(0.8),
                              ),
                            )),
                          ),
                        ),
                      ),
                    ), //________________________End___________________
//                    Padding(
//                      padding: const EdgeInsets.only(
//                        right: 50,
//                      ),
//                      child: Row(
//                        children: <Widget>[
//                          Padding(
//                            padding: EdgeInsets.only(right: 10),
//                          ),
//                          Container(
//                            margin: EdgeInsets.only(
//                              top: 70,
//                            ),
//                            width: 300,
//                            height: 50,
//                            child: RaisedButton(
//                              shape: new RoundedRectangleBorder(
//                                  borderRadius: new BorderRadius.circular(35),
//                                  side: BorderSide(color: Colors.blue)),
//                              onPressed: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => AR()));
//                              },
//                              color: Colors.blue,
//                              textColor: Colors.white,
//                              child: Row(
//                                crossAxisAlignment: CrossAxisAlignment.end,
//                                children: <Widget>[
//                                  Padding(
//                                    padding: const EdgeInsets.only(
//                                      // left: 23,
//                                      right: 110,
//                                    ),
//                                  ),
//                                  Text(
//                                    'حفظ',
//                                    style: TextStyle(fontSize: 30),
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ), //____________End_______________
                  ],
                ), //__________________________To_Slide_Up_page________________________
              ],
            ),
          ),
        ),
      ),
    ); //_____________________________Translate_To_Ar________________
  }
}
