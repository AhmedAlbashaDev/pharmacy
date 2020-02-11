import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy/Pages/Admn.dart';
import 'package:pharmacy/Pages/Home.dart';
import 'package:pharmacy/Pages/UserRe.dart';
import 'package:pharmacy/Pages/think.dart';
import 'package:pharmacy/globals.dart';
import 'package:pharmacy/modles/orders.dart';
import 'package:pharmacy/modles/pharmacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pharmacy/Pages/UserCall.dart';
import 'package:pharmacy/Pages/UserPro.dart';
import 'dart:ui' as ui;


class FirstScreen extends StatefulWidget {
  const FirstScreen({Key key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreen();
}

class _FirstScreen extends State<FirstScreen> {
  GoogleMapController mapController;

  var currentLocation;

  File _image;
  var name = TextEditingController();
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  var loading = false;
  List<Pharmacy> pharmacyList;
  final Map<String, Marker> _markers = {};

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  getPharmacies() async {
    try {
      setState(() {
        loading = true;
      });

      var response = await dioClient.get(baseURL + 'getPharmacies');

      print('response $response');

      var data = response.data;

      if(data['success'] == true){

        pharmacyList = new List();

        var pharmacies = data['pharmacies'] as List;

        pharmacies.forEach((pharmacy){
          pharmacyList.add(Pharmacy.fromJson(pharmacy));
        });

        /*if(myOrdersList.isNotEmpty){
          pharmacyList.forEach((pharmacy){
            myOrdersList.forEach((order) {

              if(order.pharmacyId == '${pharmacy.id}'){
                var marker = Marker(
                  markerId: MarkerId(pharmacy.name),
                  position: LatLng(double.parse(pharmacy.lat), double.parse(pharmacy.long)),
                  infoWindow: InfoWindow(
                    title: pharmacy.name,
                    snippet: '${pharmacy.phone}',
                  ),
                  icon: BitmapDescriptor.fromAsset('lib/assets/marker.png',),
                );
                _markers['${pharmacy.name} ${order.id}'] = marker;
                return;
              }else{
                var marker = Marker(
                  markerId: MarkerId(pharmacy.name),
                  position: LatLng(double.parse(pharmacy.lat), double.parse(pharmacy.long)),
                  infoWindow: InfoWindow(
                    title: pharmacy.name,
                    snippet: '${pharmacy.phone}',
                  ),
                  icon: BitmapDescriptor.fromAsset('lib/assets/marker_red.png',),
                );
                _markers['${pharmacy.name} ${order.id}'] = marker;
              }

//            if(order.pharmacyId != null){
//              if(order.pharmacyId == '${pharmacy.id}'){
//                print('Find ${pharmacy.name}');
//                marker = Marker(
//                  markerId: MarkerId(pharmacy.name),
//                  position: LatLng(double.parse(pharmacy.lat), double.parse(pharmacy.long)),
//                  infoWindow: InfoWindow(
//                    title: pharmacy.name,
//                    snippet: '${pharmacy.phone}',
//                  ),
//                  icon: BitmapDescriptor.fromAsset('lib/assets/marker.png',),
//                );
//                _markers[pharmacy.name] = marker;
//              }
//            }
//            else{
//              print('Not Find ${pharmacy.name}');
//              marker = Marker(
//                markerId: MarkerId(pharmacy.name),
//                position: LatLng(double.parse(pharmacy.lat), double.parse(pharmacy.long)),
//                infoWindow: InfoWindow(
//                  title: pharmacy.name,
//                  snippet: '${pharmacy.phone}',
//                ),
//                icon: BitmapDescriptor.fromAsset('lib/assets/marker_red.png',),
//              );
//              _markers[pharmacy.name] = marker;
//            }

            });
          });
        }
        else{
          var marker = Marker(
            markerId: MarkerId(pharmacy.name),
            position: LatLng(double.parse(pharmacy.lat), double.parse(pharmacy.long)),
            infoWindow: InfoWindow(
              title: pharmacy.name,
              snippet: '${pharmacy.phone}',
            ),
            icon: BitmapDescriptor.fromAsset('lib/assets/marker_red.png',),
          );
          _markers['${pharmacy.name} ${order.id}'] = marker;
        }*/

        print('LENGTH ${pharmacies.length}');
        setState(() {
          loading = false;
        });
      }
    } on DioError catch (error) {
      setState(() {
        loading = false;
      });
      print('ERROR Code ${error.response.statusCode}');
      print('ERROR Message ${error.response.data}');
      switch (error.type) {
        case DioErrorType.CONNECT_TIMEOUT:
        case DioErrorType.SEND_TIMEOUT:
        case DioErrorType.CANCEL:
          throw error;
          break;
        default:
          throw error;
      }
    } catch (error) {
      throw error;
    }
  }

  List<Order> myOrdersList;

  getMyOrders() async {
    try {
      setState(() {
        loading = true;
      });

      FormData form = FormData.fromMap({
        'userId' : userId,
      });

      var response = await dioClient.post(baseURL + 'getMyOrders',data: form);

      print('response $response');

      var data = response.data;

      if(data['success'] == true){

        myOrdersList = new List();

        var orders = data['orders'] as List;

        orders.forEach((product){
          myOrdersList.add(Order.fromJson(product));
        });

        print('LENGTH ${orders.length}');
        setState(() {
          loading = false;
        });

        Geolocator().getCurrentPosition().then((currloc) {
          setState(() {
            currentLocation = currloc;
          });
        });
      }
    } on DioError catch (error) {
      setState(() {
        loading = false;
      });
      print('ERROR Code ${error.response.statusCode}');
      print('ERROR Message ${error.response.data}');
      switch (error.type) {
        case DioErrorType.CONNECT_TIMEOUT:
        case DioErrorType.SEND_TIMEOUT:
        case DioErrorType.CANCEL:
          throw error;
          break;
        default:
          throw error;
      }
    } catch (error) {
      throw error;
    }
  }


  createOrder({String name}) async {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
      );

      FormData form = FormData.fromMap({
        'name' : name,
        'userId' : userId,
        'image' : await MultipartFile.fromFile(_image.path,filename: 'image_${_image.path}')
      });

      dioClient.options.headers['Accept'] = 'application/json';
      dioClient.options.headers['content-Type'] = 'application/json';

      var response = await dioClient.post(baseURL + 'createOrder',data: form);

      print('reponse $response');


      var data = response.data;

      if(data['success'] == true){


        Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => FirstScreen()));
        Fluttertoast.showToast(
            msg: "تم ارسال طلبك بنجاح ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }

    } on DioError catch (error) {
      Navigator.pop(context);
      print('ERROR Code ${error.response.statusCode}');
      print('ERROR Message ${error.response.data}');
      switch (error.type) {
        case DioErrorType.CONNECT_TIMEOUT:
        case DioErrorType.SEND_TIMEOUT:
        case DioErrorType.CANCEL:
          throw error;
          break;
        default:
          throw error;
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  void initState() {
    super.initState();
    getMyOrders();
    getPharmacies();
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
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'lib/assets/logo.png',
                          image: userImage != null ? baseImageURL + userImage : baseImageURL + '',
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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
                      MaterialPageRoute(builder: (context) => MyOrders()),
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
                      markers: _markers.values.toSet(),
                    ), // _____________MapCode___________
                     //__________________Start SlideupPanel____________
                    SlidingUpPanel(
                        backdropColor: Colors.blue[100],
                        borderRadius: radius,
                        panel: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(top: 40)),
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
                                      height: 150,
                                      width: 150,
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
                                        controller: name,
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
                                    if(_image == null){
                                      Fluttertoast.showToast(
                                          msg: "يجب اختيار الصوره اولا",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIos: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                      return;
                                    }
                                    else if(name.text.trim().length == 0){
                                      Fluttertoast.showToast(
                                          msg: "يجب ادخال الاسم اولا",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIos: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                      return;
                                    }
                                    else{
                                      createOrder(name: name.text);
                                    }
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

      _markers.clear();
      for (final pharmacy in pharmacyList) {
       if(myOrdersList.isNotEmpty){
         myOrdersList.forEach((order){
           if(order.pharmacyId == '${pharmacy.id}'){
             final marker = Marker(
               markerId: MarkerId(pharmacy.name),
               position: LatLng(double.parse(pharmacy.lat), double.parse(pharmacy.long)),
               infoWindow: InfoWindow(
                 title: pharmacy.name,
                 snippet: '${pharmacy.phone}',
               ),
               icon: BitmapDescriptor.fromAsset('lib/assets/marker.png',),
             );
             _markers['${pharmacy.name} ${order.id}'] = marker;
           }
           else{
             final marker = Marker(
               markerId: MarkerId(pharmacy.name),
               position: LatLng(double.parse(pharmacy.lat), double.parse(pharmacy.long)),
               infoWindow: InfoWindow(
                 title: pharmacy.name,
                 snippet: '${pharmacy.phone}',
               ),
               icon: BitmapDescriptor.fromAsset('lib/assets/marker_red.png',),
             );
             _markers['${pharmacy.name} ${order.id}'] = marker;
           }
         });
       }
       else{
         final marker = Marker(
           markerId: MarkerId(pharmacy.name),
           position: LatLng(double.parse(pharmacy.lat), double.parse(pharmacy.long)),
           infoWindow: InfoWindow(
             title: pharmacy.name,
             snippet: '${pharmacy.phone}',
           ),
           icon: BitmapDescriptor.fromAsset('lib/assets/marker_red.png',),
         );
         _markers['${pharmacy.name}'] = marker;
       }

      }
    });

  }
}
