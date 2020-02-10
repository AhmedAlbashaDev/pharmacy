import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy/Pages/Admn.dart';
import 'package:pharmacy/Pages/Home.dart';
import 'package:pharmacy/Pages/UserRe.dart';
import 'package:pharmacy/Pages/think.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pharmacy/Pages/UserCall.dart';
import 'package:pharmacy/Pages/UserPro.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreen();
}

class _FirstScreen extends State<FirstScreen> {
  GoogleMapController mapController;

  var currentLocation;

  // _requstDialog(BuildContext context){
  // return showDialog(context: context,builder: (context){
  //     return AlertDialog(title: Text('طلب دواء'),content: TextField(),actions: <Widget>[
  //       MaterialButton(elevation: 5.0,child: Text("اطلب"),onPressed: (){},),
  //       MaterialButton(elevation: 5.0,child: Text("الغاء"),onPressed: (){
  //         Navigator.of(context).pop();
  //       },)
  //     ],);
  //   });
  // }
  File _image;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
        topLeft: Radius.circular(45), topRight: Radius.circular(45));

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('بـحث عــن دواء'),
          ),
          drawer: Drawer(
              child: ListView(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: new EdgeInsets.all(30.0),
       
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          image: new DecorationImage(
                              image: new ExactAssetImage('lib/assets/per.jpg'),
                              fit: BoxFit.cover),
                          border:
                              Border.all(color: Colors.blue[100], width: 5.0),
                          borderRadius: new BorderRadius.all(
                              const Radius.circular(80.0))
                              ),
                    ), //____________________________________________
                  
                  ],
                ),
              ), //________________________________________________
              SizedBox(
                height: 15,
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                title: Text('الــبروفــايــل'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPro()),
                  );
                },
              ), //________________________________________
              SizedBox(
                  // height: 15,
                  ), //+++++++++++++++++++++++
              ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Colors.blue,
                  ),
                  title: Text('طلباتي'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserRe()),
                    );
                  }), //_________________________________________
              SizedBox(
                  // height: 15,
                  ), //+++++++++++
              ListTile(
                leading: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
                title: Text('اتصل بنا '),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserCall()));
                },
              ), //________________________________________________
              ListTile(
                leading: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.blue,
                ),
                title: Text('المنتجات'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Think()));
                },
              ),//___________________________________________

              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.blue,
                ),
                title: Text('تسجيل خروج'),
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage()));

                  Fluttertoast.showToast(
                      msg: "تم تسجيل الخروج بنجاح",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                },
              ), //_________________________________________
              SizedBox(
                height: 320,
                width: 20,
              ), //++++++++++++++
              Row(
                
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                  ),
                  Text(
                    ' جميع الحــقوق محفوظة لدي بندول ',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  )
                ],
              )
            ],
          ),//______________________
          ),//_______________________________________________________________________ 
          body: currentLocation == null
              ? Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ) //____________________________________
              : Stack(
                  children: <Widget>[
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(currentLocation.latitude,
                              currentLocation.longitude),
                          zoom: 13.4746),
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                    ), // _____________MapCode___________
                     //__________________Start SlideupPanel____________
                    SlidingUpPanel(
                        backdropColor: Colors.blue[100],
                        borderRadius: radius,
                        panel: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(top: 90)),
                              _image == null
                                  ? Container(
                                      child: Column(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(
                                              Icons.add_a_photo,
                                              size: 45,
                                            ),
                                            color: Colors.blue,
                                            disabledColor: Colors.blue,
                                            onPressed: () {
                                              getImage();
                                            },
                                          ), //+++++++++++++++++++++
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'اضافة صـــورة',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.blue),
                                          ),
                                          SizedBox(
                                            height: 50,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      height: 200,
                                      width: 300,
                                      child: Image.file(_image)), //++++++++

                              SizedBox(
                                height: 50,
                              ), //+++++++++++++
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Container(
                                  height: 90,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.lightBlue),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 40, top: 20),
                                      child: TextFormField(
                                          decoration: InputDecoration(
                                        hintText: "اكتب اسم الدواء...",
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        icon: Icon(
                                          Icons.comment,
                                          color:
                                              Colors.lightBlue.withOpacity(0.8),
                                        ),
                                      )),
                                    ),
                                  ),
                                ),
                              ),//___________________________
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: EdgeInsets.all(20),
                                width: 190,
                                height: 50,
                                child: RaisedButton(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(32),
                                      side: BorderSide(color: Colors.white)),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Admin()));
                                  },
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 23,
                                          right: 20,
                                        ),
                                      ), //_______________________________________________________________

                                      Text(
                                        'ارســال',
                                        style: TextStyle(
                                          fontSize: 30,
                                        ),
                                      ),
//
                                    ],
                                  ), //____________________________________________________________

//
                                ),
                              ),
                            ],
                          ),
                        ), //______________SlideUpScreen___________
                        collapsed: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[300], borderRadius: radius),
                          child: Center(
                            child: Text(
                              'اسحب للبحث عن دواء',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ), //_____________________________
                        body: Center(
                          child: Container(),
                        ),
                        ),//___________End______________
                  ],
                ),
        ),
      ),
    ); //_____________Translate_to_Arabic___________
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
