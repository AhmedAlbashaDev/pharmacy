import 'package:flutter/material.dart';

class UserCall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('اتــصــل بـنا'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    image: new DecorationImage(
                        image: new ExactAssetImage('lib/assets/logo.png'),
                        fit: BoxFit.cover),
                    border: Border.all(color: Colors.blue, width: 5.0),
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(80.0))),
              ), //______________Logo______________
              SizedBox(
                height: 100,
              ), //=====
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('هواتفنا',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                      Column(
                        children: <Widget>[
                          Text('00249909040353'),
                          SizedBox(height: 10,),
                          Text('00249960605023'),
                          SizedBox(height: 10,),
                          Text('00249116966864'),
                        ],
                      )
                    ],
                  ),

                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('الايميل',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                      Column(
                        children: <Widget>[
                          Text('mohammed98@gmail.com'),

                        ],
                      )
                    ],
                  )
                ],
              ), //_________________________________
            ],
          ),
        ),
      ),
    ); //__________________________________Translate_To_Ar___________________________
  }
}
