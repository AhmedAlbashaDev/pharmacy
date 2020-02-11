import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy/Pages/PHome.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy/Pages/maps.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart';
import 'manmap.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void showInSnackBar(String msg) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Colors.red),
      ),
      backgroundColor: Colors.white,
      duration: Duration(seconds: 3),
    ));
  }

  var name = TextEditingController(),license = TextEditingController(), location = TextEditingController(), password = TextEditingController(), email = TextEditingController(), phone = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  // final
  File _image;
  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  bool _showPassword = false;

  register({String name , String email , String location , String license , String password , String phone}) async {
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
        'email' : email,
        'password' : password,
        'phone' : phone,
        'userType' : '2',
        'location' : location,
        'image' : await MultipartFile.fromFile(_image.path,filename: 'image_${_image.path}'),
        'lat' : lat,
        'long' : long,
        'license' : license,
      });

      print('Lat $lat Long $long');

      var response = await dioClient.post(baseURL + 'register',data: form);

      var data = response.data;

      if(data['success'] == true){

        SharedPreferences pref = await SharedPreferences.getInstance();

        pref.setString('userId', '${data['user']['id']}');
        pref.setString('userName', '${data['user']['name']}');
        pref.setString('userEmail', '${data['user']['email']}');
        pref.setString('userPhone', '${data['user']['phone']}');
        pref.setString('userImage', '${data['user']['image']}');
        pref.setString('userType', '${data['user']['userType']}');
        pref.setString('access_token', '${data['access_token']}');
        pref.setString('userLicence', '${data['user']['license']}');

        setState(() {
          userId = pref.getString('userId');
          userImage = pref.getString('userImage');
          userPhone = pref.getString('userPhone');
          userName = pref.getString('userName');
          userEmail = pref.getString('userEmail');
          userType = pref.getString('userType');
          userLicence = pref.getString('userLicence');

          locationSelected = false;
        });

        Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Orders()));

        Fluttertoast.showToast(
            msg: "تم إنشاء الحساب بنجاح .. سيتم تسجيل الدخول تلقائيا",
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

  login({String name , String password }) async {
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
        'password' : password,
      });

      var response = await dioClient.post(baseURL + 'login',data: form);

      print('reponse $response');


      var data = response.data;

      if(data['success'] == true){

        SharedPreferences pref = await SharedPreferences.getInstance();

        pref.setString('userId', '${data['user']['id']}');
        pref.setString('userName', '${data['user']['name']}');
        pref.setString('userEmail', '${data['user']['email']}');
        pref.setString('userPhone', '${data['user']['phone']}');
        pref.setString('userImage', '${data['user']['image']}');
        pref.setString('userType', '${data['user']['userType']}');
        pref.setString('access_token', '${data['access_token']}');
        pref.setString('userLicence', '${data['user']['license']}');

        setState(() {
          userId = pref.getString('userId');
          userImage = pref.getString('userImage');
          userPhone = pref.getString('userPhone');
          userName = pref.getString('userName');
          userEmail = pref.getString('userEmail');
          userType = pref.getString('userType');
          userLicence = pref.getString('userLicence');
        });


        Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Orders()));

        Fluttertoast.showToast(
            msg: "تم تسجيل الدخول بنجاح",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }
      else{
        print('22');
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: '${data['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 2,
            backgroundColor: Colors.red,
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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
//                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Text('تسجيــل دخول')),
                Tab(icon: Text('اشتــراك')),
              ],
            ),
            centerTitle: true,
            title: Text(
              'صيدليه',
            ),
          ),
          backgroundColor: Colors.white,
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding: new EdgeInsets.all(33.0),
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage:
                              AssetImage('lib/assets/logo.png'),
                        )), //____________________________________________________________________
                    SizedBox(
                      height: 40,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlue),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: TextFormField(
                              controller: nameController,
                                decoration: InputDecoration(
                              hintText: "اسم الصــيدليه",
                              labelStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              icon: Icon(
                                Icons.business_center,
                                color: Colors.lightBlue.withOpacity(0.8),
                              ),
                            )),
                          ),
                        ),
                      ),
                    ), //_________________________________________________________________
                    SizedBox(
                      height: 30,
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
                              controller: passwordController,
                              decoration: InputDecoration(
                                hintText: "كلمـــة الــمرور",
                                labelStyle: TextStyle(color: Colors.grey),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.lightBlue.withOpacity(0.8),
                                ),
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ), //_____________________________________________________________________
                    SizedBox(
                      height: 45,
                    ), //++++++++++++
                    Container(
                      margin: EdgeInsets.all(20),
                      width: 190,
                      height: 50,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(32),
                            side: BorderSide(color: Colors.white)),
                        onPressed: () {
                          if(nameController.text.trim().length == 0){
                            Fluttertoast.showToast(
                                msg: "يجب ادخال اسم المستخدم اولا",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }
                          else if(passwordController.text.trim().length == 0){
                            Fluttertoast.showToast(
                                msg: "يجب ادخال كلمة المرور اولا",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }

                          login(name: nameController.text , password: passwordController.text);
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Center(
                          child: Text(
                            'دخــول',
                            style: TextStyle(
                                fontSize: 29, fontStyle: FontStyle.italic),
                          ),
                        ),

//
                      ),
                    ), //++++++++++++++++++++++++++++++++++++++++++
                  ],
                ),
              ), //+++++++++++++++++++++++++++++++++++++++++++++ End Colum 1
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        child: Stack(
                          children: <Widget>[
                            new ClipRect(
                              child: Container(
                                child: _image == null
                                    ? InkWell(
                                        child: Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black12),
                                          child: Icon(
                                            Icons.add_photo_alternate,
                                            color: Colors.grey,
                                            size: 50,
                                          ),
                                        ),
                                        onTap: () {
                                          getImage(false);
                                        },
                                      ) //__________________________________________
                                    : Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: FileImage(_image)),
                                        ),
                                      ),
                              ),
                            ), //____________________________________________________________
                            InkWell(
                              child: Container(
                                height: 60,
                                width: 30,
                                child: new ClipRect(
                                  child: Container(
                                    child: Icon(Icons.add_a_photo,
                                        size: 30, color: Colors.blue),
                                  ),
                                ),
                              ), //____________
                              borderRadius: BorderRadius.circular(40),
                              onTap: () {
                                getImage(true);
                              },
                            ), //__________________________________________
                          ],
                        ),
                      ),
                    ), //_________________________________________________________
                   
                    SizedBox(
                      height: 40,
                    ), 
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
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
                              controller: name,
                                decoration: InputDecoration(
                              hintText: "اسم الصـــيدلية",
                              labelStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              icon: Icon(
                                Icons.business_center,
                                color: Colors.lightBlue.withOpacity(0.8),
                              ),
                            )),
                          ),
                        ),
                      ),
                    ), //_________________________________________________________++
                    SizedBox(
                      height: 10,
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
                              controller: password,
                                // obscureText: false,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.remove_red_eye,
                                          color: this._showPassword
                                              ? Colors.blue
                                              : Colors.grey),
                                      onPressed: () => this._showPassword =
                                          !this._showPassword),
                                  hintText: "كلمـــة الــمرور",
                                  labelStyle: TextStyle(color: Colors.grey),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.lightBlue.withOpacity(0.8),
                                  ),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                ]),
                          ),
                        ),
                      ),
                    ), //_________________________________________________
                    Padding(
                      padding: EdgeInsets.only(left: 160),
                      child: Text(
                        'يجب ان لا تقل عن 8 احرف *',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ), //+++++++++++++++
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
                              controller: phone,
                              decoration: InputDecoration(
                                hintText: "رقم الهـاتف",
                                labelStyle: TextStyle(color: Colors.grey),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                icon: Icon(
                                  Icons.call,
                                  color: Colors.lightBlue.withOpacity(0.8),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ), //________________________________________________________
                    SizedBox(
                      height: 5,
                    ), //++++++++++++++++++++++
                    Padding(
                      padding: EdgeInsets.only(left: 190),
                      child: Text(
                        'ادخال من غير المفتاح *',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    SizedBox(
                      height: 0,
                    ), //++++++++++++++++++++
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
                              controller: license,
                                decoration: InputDecoration(
                              hintText: "التــرخيص ",
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
                    ), //+_______________________________________________

                    SizedBox(
                      height: 10,
                    ), //+++++++++++++++++++++++++++++++++++++
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
                              controller: email,
                                decoration: InputDecoration(
                              hintText: "البريد الالكتروني  (اختياري) ",
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
                    ), //________________________________________________________________
                    Padding(
                      padding: EdgeInsets.only(left: 140),
                      child: Text(
                        'EXample www.panadl@gmail.com',
                        style: TextStyle(color: Colors.red),
                      ),
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
                              controller: location,
                                decoration: InputDecoration(
                              hintText: "اضف عنوان موقعك ",
                              labelStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              icon: Icon(
                                Icons.description,
                                color: Colors.lightBlue.withOpacity(0.8),
                              ),
                            )),
                          ),
                        ),
                      ),
                    ), //________________________________________________________________

                    Padding(
                      padding: EdgeInsets.only(left: 140),
                      child: Text(
                        'علي وجه المثل الخرطوم/امدرمان',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ), //+++++++++++++++++++++++++++++++++++++++++++
                    Container(
                      width: 250,
                      height: 50,
                      child: RaisedButton(
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Maps()));
                        },

                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(32),
                            side: BorderSide(color: Colors.white)),
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  right: 10,
                                ),
                                child: Icon(
                                  locationSelected ? Icons.check : Icons.location_on,
                                  color: Colors.white,
                                  size: 23,
                                ),
                              ), //_______________________________________________________________
                              Text(
                                locationSelected ? 'تم تحديد الموقع': 'اضف موقعك',
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
//
                            ],
                          ),
                        ), //____________________________________________________________

//
                      ),
                    ),
                    // +++++++++++++++++++++++++++++++++++++++++++
                    SizedBox(
                      height: 45,
                    ), //++++++++++++++++++++++++
                    Container(
                      margin: EdgeInsets.all(20),
                      width: 190,
                      height: 50,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(32),
                            side: BorderSide(color: Colors.white)),
                        onPressed: () {
                          if(_image == null){
                            Fluttertoast.showToast(
                                msg: "قم باختيار صورتك الشخصيه اولا",
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
                                msg: "يجب ادخال اسم المستخدم اولا",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }
                          else if(password.text.trim().length == 0){
                            Fluttertoast.showToast(
                                msg: "يجب ادخال كلمة المرور اولا",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }
                          else if(phone.text.trim().length == 0){
                            Fluttertoast.showToast(
                                msg: "يجب ادخال رقم الهاتف اولا",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }
                          else if(license.text.trim().length == 0){
                            Fluttertoast.showToast(
                                msg: "يجب ادخال رقم الترخيص اولا",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }
                          else if(email.text.trim().length == 0){
                            Fluttertoast.showToast(
                                msg: "يجب ادخال البريد الالكتروني اولا",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }


                          else if(location.text.trim().length == 0){
                            Fluttertoast.showToast(
                                msg: "يجب ادخال وصف الموقع اولا",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }
                          else if(location == null){
                            Fluttertoast.showToast(
                                msg: "قم بكتابة موقعك اولا",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }
                          else if(location == null){
                            Fluttertoast.showToast(
                                msg: "قم بكتابة موقعك اولا",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }
                          register(
                              name: name.text,
                              password: password.text,
                              phone: phone.text,
                              email: email.text,
                              location: location.text,
                              license: license.text
                          );
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 23,
                                right: 20,
                              ),
//                            child: Icon(
//                              Icons.directions_run,color: Colors.white,
//                              size: 15,
//                            ),
                            ), //_______________________________________________________________

                            Text(
                              'تسجيـــل',
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
              ), //_____________________________________________________

//              I
            ],
          ), //__________________________________________
        ),
      ),
    );
  }
}
