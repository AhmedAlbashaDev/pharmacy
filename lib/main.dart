import 'package:flutter/material.dart';
import 'package:pharmacy/EntroView.dart';
import 'package:pharmacy/Pages/PHome.dart';
import 'package:pharmacy/Pages/manmap.dart';
// import 'package:myapp2/EntroView.dart';

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'globals.dart';

// import 'package:myapp2/Pages/Home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Home',
    home: Myapp(),
  ));
}

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> with SingleTickerProviderStateMixin{

  AnimationController controller;
  Animation<double> animation;
  var end = 0;

  Future<void> getFromSF() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userId = pref.getString('userId');
      userImage = pref.getString('userImage');
      userPhone = pref.getString('userPhone');
      userName = pref.getString('userName');
      userEmail = pref.getString('userEmail');
      userType = pref.getString('userType');
      userLicence = pref.getString('userLicence');
    });
  }

  @override
  void initState() {
    super.initState();
    getFromSF();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000), );
    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(controller);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print(end.toString());
        if(end > 0){
          if(userId != null){
            print('userType $userType');
            print('userName $userName');
            if(userType == '1'){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FirstScreen(),
                  ));
            }
            else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Orders(),
                  ));
            }
          }
          else{

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Intro(),
                ));

          }
        }
        end++;

        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.forward();
  }//_

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();

  }// ___________________________splash screen _________________

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 160,),
              Image.asset(
                'lib/assets/logo.png',
                width: MediaQuery.of(context).size.width / 100 * 100,
                height: MediaQuery.of(context).size.height / 100 * 50,
              ),//___________logo______________________
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text('ابحث عن دوائك بكل ســهــوله'),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 1),
                child:Text('جميع الحقوق محفوظة لدي بندول',style: TextStyle(fontSize: 15),) ,
              ),
            ],
          ),
        ),

      ),
    );
  }
}
