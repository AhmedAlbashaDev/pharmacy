import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy/Pages/Admn.dart';
import 'package:pharmacy/Pages/PHome.dart';

import '../globals.dart';
// import 'package:geolocator/geolocator.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {

  var name = TextEditingController();
  var price = TextEditingController();
  var description = TextEditingController();

  createProduct({String name , String price , String description}) async {
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
        'price' : price,
        'description' : description,
        'pharmacyId' : userId,
        'image' : await MultipartFile.fromFile(_image.path,filename: 'image_${_image.path}')
      });

      dioClient.options.headers['Accept'] = 'application/json';
      dioClient.options.headers['content-Type'] = 'application/json';

      var response = await dioClient.post(baseURL + 'createProduct',data: form);

      var data = response.data;

      if(data['success'] == true){

        Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AR()));

        Fluttertoast.showToast(
            msg: "تم إضافة المنتج بنجاح",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
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

  File _image;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            // centerTitle: true,
            title: Text('المنتجات'),
          ),
          body: SingleChildScrollView(
                      child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                ),
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
                            ), //____________________________
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'اضافة صـــورة',
                              style: TextStyle(fontSize: 20, color: Colors.blue),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      )
                    : ClipOval(
                        child: Image.file(
                          _image,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                // : Container(
                //     height: 200, width: 300, child: Image.file(_image)),
                SizedBox(
                  height: 30,
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
                          controller: name,
                          decoration: InputDecoration(
                            hintText: "اسم المنتج",
                            labelStyle: TextStyle(color: Colors.grey),
                            border:
                                UnderlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
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
                          controller: price,
                          decoration: InputDecoration(
                            hintText: "سعر المنتج",
                            labelStyle: TextStyle(color: Colors.grey),
                            border:
                                UnderlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
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
                    height: 90,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightBlue),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 40, top: 20),
                        child: TextFormField(
                          controller: description,
                            decoration: InputDecoration(
                          hintText: "اكتب اسم المنتج ووصفه...",
                          labelStyle: TextStyle(color: Colors.grey),
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          icon: Icon(
                            Icons.comment,
                            color: Colors.lightBlue.withOpacity(0.8),
                          ),
                        )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
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
                            msg: "يجب إضافة الصوره اولا",
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
                              msg: "يجب كتابة الاسم المنتج اولا ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                              );
                              return;
                          }
                      else if(price.text.trim().length == 0){
                        Fluttertoast.showToast(
                            msg: "يجب كتابة سعر المنتج اولا",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        return;
                      }
                      else if(description.text.trim().length == 0){
                        Fluttertoast.showToast(
                            msg: "يجب كتابة وصف المنتج اولا",
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
                        createProduct(
                          name: name.text,
                          price: price.text,
                          description: description.text
                        );
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
//                            child: Icon(
//                              Icons.directions_run,color: Colors.white,
//                              size: 15,
//                            ),
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
          ),
        ),
      ),
    );
  }
}
