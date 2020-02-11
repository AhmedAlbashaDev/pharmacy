import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/Pages/empty_widget.dart';
import 'package:pharmacy/modles/orders.dart';

import '../globals.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  var loading = false;
  var empty = false;
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
    getMyOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('طلباتي'),
          ),
          body: loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : empty
                ? EmptyWidget()
              :Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: new EdgeInsets.only(top:20.0),
                    // margin: EdgeInsets.only(left: 10),
                    // color: Theme.of(context).primaryColor,

                  ),
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        image: new DecorationImage(
                            image:
                            new ExactAssetImage('lib/assets/per.jpg'),
                            fit: BoxFit.cover),
                        border:
                        Border.all(color: Colors.blue[100], width: 5.0),
                        borderRadius: new BorderRadius.all(
                            const Radius.circular(80.0))),
                  ),

                  Expanded(
                    child: ListView.builder(
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
                                  image: baseImageURL + myOrdersList[index].image,
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
                                    Text(myOrdersList[index].name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey[800]),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: myOrdersList.length,
                    ),
                  )

                ],
              ),
        ),
      ),
    );
  }
}
