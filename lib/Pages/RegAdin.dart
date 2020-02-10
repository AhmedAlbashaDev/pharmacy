import 'package:flutter/material.dart';

class RegAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('الطلبات'),
          ),
          body: Column(
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
