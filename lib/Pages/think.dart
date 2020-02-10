import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/modles/products.dart';

import '../globals.dart';

class Think extends StatefulWidget {
  @override
  _ThinkState createState() => _ThinkState();
}

class _ThinkState extends State<Think> {

  var loading = false;
  List<Product> productsList;

  getProducts() async {
    try {
      setState(() {
        loading = true;
      });

      var response = await dioClient.get(baseURL + 'getProducts');

      var data = response.data;

      if(data['success'] == true){

        productsList = new List();

        var products = data['products'] as List;

        products.forEach((product){
          productsList.add(Product.fromJson(product));
        });

        print('LENGTH ${productsList.length}');
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
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('منتجاتي'),
          ),
          body: loading
              ? Center(
                child: CircularProgressIndicator(),
              )
              :Column(
                children: <Widget>[

                ],
              ),
        ),
      ),
    );//___________Translate_To_Ar______________
  }
}
