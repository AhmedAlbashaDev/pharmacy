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
                height: 40,
              ),
              Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    image: new DecorationImage(
                        image: new ExactAssetImage('lib/assets/per.jpg'),
                        fit: BoxFit.cover),
                    border: Border.all(color: Colors.blue, width: 5.0),
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(80.0))),
              ), //______________Logo______________
              SizedBox(
                height: 150,
              ), //=====
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: 40,
                      right: 40,
                    ),
                    child: Container(
                      width: double.maxFinite,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightBlue),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(right: 30, left: 40, top: 50),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'اكتـب تعليــق...',
                              labelStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              icon: Icon(
                                Icons.comment,
                                color: Colors.blue,
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ), //_________________________________
              SizedBox(
                height: 2,
              ), //=========
              Container(
                margin: EdgeInsets.all(30),
                width: 130,
                height: 40,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20),
                      side: BorderSide(color: Colors.blue)),
                  onPressed: () {},
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 15),
                        child: Icon(Icons.send),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            'ارســال',
                            style: TextStyle(fontSize: 18),
                          )), //_________________End____________________
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ); //__________________________________Translate_To_Ar___________________________
  }
}
