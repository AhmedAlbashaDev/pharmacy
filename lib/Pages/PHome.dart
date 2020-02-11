import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:pharmacy/Pages/Home.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:pharmacy/Pages/PdminCall.dart';
import 'package:pharmacy/Pages/PProfile.dart';
import 'package:pharmacy/Pages/add.dart';
import 'package:pharmacy/modles/orders.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart';
import 'empty_widget.dart';
// import 'package:myapp2/Pages/EditProfile.dart';

// import 'package:lite_rolling_switch/lite_rolling_switch.dart';
// import 'package:toggle_switch/toggle_switch.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  var loading = false;
  var empty = false;
  List<Order> ordersList;

  getOrders() async {
    try {
      setState(() {
        loading = true;
      });

      var response = await dioClient.get(baseURL + 'getOrders');

      print('response $response');

      var data = response.data;

      if(data['success'] == true){

        ordersList = new List();

        var orders = data['orders'] as List;

        orders.forEach((product){
          ordersList.add(Order.fromJson(product));
        });

        if(orders.length == 0){
          setState(() {
            empty = true;
          });
        }

        print('LENGTH ${orders.length}');
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: new Text("الطلبات"),
            // elevation: debugDefaultTargetPlatform == TargetPlatform.android
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: new EdgeInsets.all(30.0),
                  // margin: EdgeInsets.only(left: 10),
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            image: new DecorationImage(
                                image:
                                new ExactAssetImage('lib/assets/per.jpg'),
                                fit: BoxFit.cover),
                            border: Border.all(color: Colors.blue, width: 5.0),
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(80.0))),
                      ), //____________LogoApp______________
                    ],
                  ),
                ), //_______________________________________________
                SizedBox(
                  height: 15,
                ), //____________

                ListTile(
                  leading: Icon(
                    Icons.business_center,
                    color: Colors.blue,
                  ),
                  title: Text('الــبروفــايــل'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminPro()),
                    );
                  },
                ), //___________________________________
                SizedBox(
                  // height: ,
                ), //++++++++++
                SizedBox(
                  // height: 15,
                ),
                ListTile(
                  leading: Icon(
                    Icons.call,
                    color: Colors.blue,
                  ),
                  title: Text('اتصل بنا '),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Acall()));
                  },
                ), //_________________________________
                ListTile(
                  leading: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.blue,
                  ),
                  title: Text('اضافة منتج'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Add()));
                  },
                ), //_______________________________

                SizedBox(
                  // height: 20,
                  width: 15,
                ), //_________
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.blue,
                  ),
                  title: Text('تسجيل خروج'),
                  onTap: () async {
                    SharedPreferences pref = await SharedPreferences.getInstance();

                    pref.clear();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage()));
                  },
                ), //_______________________________

                SizedBox(
                  height: 440,
                  width: 10,
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
            ),
          ), //___________________End_________________
          body:  loading
                ? Center(
                  child: CircularProgressIndicator(),
                )
                : empty
                ? EmptyWidget()
                :ListView.builder(
                itemBuilder:(context,index){
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)
                    ),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(3),
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'lib/assets/logo.png',
                            image: baseImageURL + ordersList[index].image,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.only(right: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(ordersList[index].name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey[800]),),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              itemCount: ordersList.length,
            )
        ),
      ),
    );
  }
}


