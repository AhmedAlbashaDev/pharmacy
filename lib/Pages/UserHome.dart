import 'dart:ui';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy/Pages/manmap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  //++++++++++++++++++++++++++++++++++++++++++++++
  var nameController = TextEditingController();
  var passwordController = TextEditingController();

  var name = TextEditingController(), password = TextEditingController(), email = TextEditingController(), phone = TextEditingController();
  bool isLogin = false;
  var location='';

 register({String name , String email , String location, String password , String phone}) async {
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
//           'location' : location,
           'userType' : '1',
           'image' : await MultipartFile.fromFile(_image.path,filename: 'image_${_image.path}')
         });

         dioClient.options.headers['Accept'] = 'application/json';
         dioClient.options.headers['content-Type'] = 'application/json';

         var response = await dioClient.post(baseURL + 'register',data: form);

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

           setState(() {
             userId = pref.getString('userId');
             userImage = pref.getString('userImage');
             userPhone = pref.getString('userPhone');
             userName = pref.getString('userName');
             userEmail = pref.getString('userEmail');
             userType = pref.getString('userType');
           });

           Navigator.pop(context);
           Navigator.pushReplacement(
               context,
               MaterialPageRoute(
                   builder: (context) => FirstScreen()));

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
      print('in');
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

        setState(() {
          userId = pref.getString('userId');
          userImage = pref.getString('userImage');
          userPhone = pref.getString('userPhone');
          userName = pref.getString('userName');
          userEmail = pref.getString('userEmail');
          userType = pref.getString('userType');
        });

        Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => FirstScreen()));

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

  final userController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
//                automaticallyImplyLeading: true,
                bottom: TabBar(
                  tabs: [
//                Tab(icon: Icon(Icons.directions_car)),
                    Tab(
                      icon: Text(
                        'تسجيل دخول',
                      ),
                    ), //____________
                    Tab(
                      icon: Text(
                        'اشتــراك',
                      ),
                    ), //____________
                  ],
                ),
                centerTitle: true,
                title: Text(
                  'مستخدم',
                ),
              ), //_______________________
              backgroundColor: Colors.white,
              body: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        Center(
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage:
                                AssetImage('lib/assets/logo.png'),
                          ),
                        ), //_______________Logo_______________

                        SizedBox(
                          height: 40,
                        ), //========
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20, right: 20,
                            //  top: 120
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
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      hintText: "اسم المستخدم",
                                      labelStyle: TextStyle(color: Colors.grey),
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide.none),
                                      icon: Icon(
                                        Icons.person,
                                        color:
                                            Colors.lightBlue.withOpacity(0.8),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ), //__________________________________End_________________________
                        SizedBox(
                          height: 30,
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
                                ),
                              ),
                            ),
                          ),
                        ), //________________________End_____________________
                        SizedBox(
                          height: 45,
                        ), //========
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
                                    msg: "يجب ادخال اسم المستخدم",
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
                                    msg: "يجب ادخال كلمة المرور",
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
                                login(name: nameController.text , password: passwordController.text);
                              }
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
                                ), //___________________________End____________________________

                                Text(
                                  'دخــول',
                                  style: TextStyle(
                                    fontSize: 29,
                                  ),
                                )
//
                              ],
                            ),

//
                          ),
                        ),
                      ],
                    ),
                  ), //_________________________________Slide_Up_Page_____________________________
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
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
                                          ) //______________Add_Action_To_any_Think______
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
                                ), //__________________________Image_________________________________
//                                InkWell(
//                                  child: Container(
//                                    width: 40,
//                                    child: new ClipRect(
//                                      child: Container(
//                                        child: Icon(Icons.add_a_photo,
//                                            size: 30, color: Colors.blue),
//                                      ),
//                                    ),
//                                  ),
//                                  borderRadius: BorderRadius.circular(40),
//                                  onTap: () {
//                                    getImage(true);
//                                  },
//                                ), //_________________Add_Action________________
                              ],
                            ),
                          ),
                        ), //___________________________________________________________________

                        SizedBox(
                          height: 60,
                        ), //======
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
                                  hintText: "اسم المستخدم",
                                  labelStyle: TextStyle(color: Colors.grey),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                  icon: Icon(
                                    Icons.person_add,
                                    color: Colors.lightBlue.withOpacity(0.8),
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ), //___________________________End____________________________________
                        SizedBox(
                          height: 20,
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
                                  controller: password,
                                    decoration: InputDecoration(
                                  hintText: "كلمـــة الــمرور",
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
                        ), //__________________________________End______________________________________
                        SizedBox(
                          height: 5,
                        ), //+++++++++++++++
//                        Padding(
//                          padding: EdgeInsets.only(left: 180),
//                          child: Text(
//                            'يجب ان لا تقل عن 8 احرف *',
//                            style: TextStyle(color: Colors.red),
//                          ),
//                        ), //_____________________
//
//                        SizedBox(
//                          height: 0,
//                        ), //==========
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
                                ),
                              ),
                            ),
                          ),
                        ), //________________________________End_________________________________
                        SizedBox(
                          height: 5,
                        ), //==============
//                        Padding(
//                          padding: EdgeInsets.only(left: 180),
//                          child: Text(
//                            'ادخال من غير المفتاح *',
//                            style: TextStyle(color: Colors.red),
//                          ),
//                        ), //_______________________
//============
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
                        ), //_____________________________End________________________________
                        SizedBox(
                          height: 5,
                        ), //++++++++++++
                        Padding(
                          padding: EdgeInsets.only(left: 180),
                          child: Text(
                            ' wwww.panadol@gmail.com',
                            style: TextStyle(color: Colors.red),
                          ),
                        ), //________________

                        SizedBox(
                          height: 45,
                        ), //========
                        Container(
                          margin: EdgeInsets.all(20),
                          width: 190,
                          height: 50,
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(32),
                                side: BorderSide(color: Colors.white)),
                            onPressed: () {
                              if(name.text.trim().length == 0){
                                Fluttertoast.showToast(
                                    msg: "يجب ادخال اسم المستخدم اولا",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
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
                                    gravity: ToastGravity.CENTER,
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
                                    gravity: ToastGravity.CENTER,
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
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIos: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                                return;
                              }
                              else if(_image == null){
                                Fluttertoast.showToast(
                                    msg: "قم باختيار صورتك الشخصيه اولا",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
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
                                    gravity: ToastGravity.CENTER,
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
                                    gravity: ToastGravity.CENTER,
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
                                email: email.text,
                                phone: phone.text,
                              );
//                              Navigator.pushReplacement(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => FirstScreen()));
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
                                ), //________________________End_________________________

                                Text(
                                  'تسجيـــل',
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                )
                              ],
                            ), //_______________________________
                          ),
                        ),
                      ],
                    ),
                  ), //____________________To_Slide_Up_Page___________
                ],
              ), //__________________Logn_Singin_____________
            ),
          ),
        ),
      ),
    ); //__________________________Translate_To_Ar_______________________________
  }
}
