import 'package:flutter/material.dart';
class UserRe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('الطلبـــات'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: new EdgeInsets.all(30.0),
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

            ],
          ),
        ),
      ),
    );
  }
}