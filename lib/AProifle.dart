import 'package:flutter/material.dart';
class APro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
    child: Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Container(
                child: Row(
                  children: <Widget>[
                    ListTile(
                    leading: Icon(Icons.business_center),
                      title: Text('اسم الصيدلية'),
                      onTap: (){},
                      

                    )
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    ),
      
    );
  }
}