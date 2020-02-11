import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/Pages/empty_widget.dart';
import 'package:pharmacy/modles/products.dart';

import '../globals.dart';

class Think extends StatefulWidget {
  @override
  _ThinkState createState() => _ThinkState();
}

class _ThinkState extends State<Think> {

  var loading = false;
  var empty = false;
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

        if(productsList.length == 0){
          setState(() {
            empty = true;
          });
        }

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
            title: Text('المنتجات'),
          ),
          body: loading
              ? Center(
                child: CircularProgressIndicator(),
              )
              : empty
              ? EmptyWidget()
              :Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context,index){
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
                                  image: baseImageURL + productsList[index].image,
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin:EdgeInsets.only(right: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text('اسم المنتج',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.grey[800]),),
                                        Text(productsList[index].name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.grey[700]),),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:EdgeInsets.only(right: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text('سعر المنتج',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.grey[800]),),
                                        Text(productsList[index].price,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.grey[700]),),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:EdgeInsets.only(right: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text('اسم الصيدليه',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.grey[800]),),
                                        Text(productsList[index].pharmacy.name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.grey[700]),),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: productsList.length,
                    ),
                  )
                ],
              ),
        ),
      ),
    );//___________Translate_To_Ar______________
  }
}
