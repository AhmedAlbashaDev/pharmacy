import 'package:flutter/cupertino.dart';

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(CupertinoIcons.delete,color: Color(0xff34C961),size: 25,),
            SizedBox(height: 10,),
            Text('لا توجد بيانات للعرض',style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
    );
  }
}
