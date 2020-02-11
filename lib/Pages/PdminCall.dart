import 'package:flutter/material.dart';

class Acall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('اتصل بنا'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: new EdgeInsets.all(33.0),
                  margin: EdgeInsets.only(
                    right: 120,

                  ),
                  child: Row(

                    children: <Widget>[
                      CircleAvatar(
                        radius: 60.0,
                        backgroundImage: AssetImage('lib/assets/logo.png'),
                      ),
                    ],
                  )
                  ),//__________LogoApp____________
                  SizedBox(
                    height: 130,
                  ),
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
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          icon: Icon(
                            Icons.comment,
                            color: Colors.blue,
                          )),
                    ),
                  ),
                ),
              ),//_________________________
              SizedBox(
                height: 20,
              ),
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
                          ))
//
                    ],
                  ),

//
                ),//________________________________
              ),
            ],
          ),//
        ),
      ),
    );//____________Translate_To_Arabic____________
  }
}
