import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:pharmacy/Pages/Home.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:pharmacy/Pages/PdminCall.dart';
import 'package:pharmacy/Pages/PProfile.dart';
import 'package:pharmacy/Pages/add.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:myapp2/Pages/EditProfile.dart';

// import 'package:lite_rolling_switch/lite_rolling_switch.dart';
// import 'package:toggle_switch/toggle_switch.dart';

class AR extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: new Text("الطلبات"),
            // elevation: debugDefaultTargetPlatform == TargetPlatform.android
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: new EdgeInsets.all(30.0),
                  // margin: EdgeInsets.only(left: 10),
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            image: new DecorationImage(
                                image:
                                    new ExactAssetImage('lib/assets/per.jpg'),
                                fit: BoxFit.cover),
                            border: Border.all(color: Colors.blue, width: 5.0),
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(80.0))),
                      ), //____________LogoApp______________
                    ],
                  ),
                ), //_______________________________________________
                SizedBox(
                  height: 15,
                ), //____________

                ListTile(
                  leading: Icon(
                    Icons.business_center,
                    color: Colors.blue,
                  ),
                  title: Text('الــبروفــايــل'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminPro()),
                    );
                  },
                ), //___________________________________
                SizedBox(
                    // height: ,
                    ), //++++++++++
                SizedBox(
                    // height: 15,
                    ),
                ListTile(
                  leading: Icon(
                    Icons.call,
                    color: Colors.blue,
                  ),
                  title: Text('اتصل بنا '),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Acall()));
                  },
                ), //_________________________________
                ListTile(
                  leading: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.blue,
                  ),
                  title: Text('اضافة منتج'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Add()));
                  },
                ), //_______________________________

                SizedBox(
                  // height: 20,
                  width: 15,
                ), //_________
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.blue,
                  ),
                  title: Text('تسجيل خروج'),
                  onTap: () async {
                    SharedPreferences pref = await SharedPreferences.getInstance();

                    pref.clear();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage()));
                  },
                ), //_______________________________

                SizedBox(
                  height: 440,
                  width: 10,
                ), //++++++++++++++
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                    ),
                    Text(
                      ' جميع الحــقوق محفوظة لدي بندول ',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          ), //___________________End_________________
          body: ListView(
            children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  // width: 250,
                  child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                        ),
                        child: LiteRollingSwitch(
                          value: true,
                          textOn: 'تشغيل',
                          textOff: 'ايقاف',
                          colorOn: Colors.blue,
                          colorOff: Colors.blueGrey,
                          iconOn: Icons.lock_open,
                          iconOff: Icons.power_settings_new,
                          onChanged: (bool state) {
                            print('turned ${(state) ? 'يقاف' : 'تشغيل'}');
                          },
                        ), //__________Totch_To_On_ff_______________
                      )),
                ), //_________________End____________

                //[

                // Padding(
                //   padding: const EdgeInsets.only( bottom: 1.0,),

                // ),
                // ToggleSwitch(
                //     minWidth: 200.0,
                //     cornerRadius: 20,
                //     activeBgColor: Colors.blue,
                //     activeTextColor: Colors.white,
                //     inactiveBgColor: Colors.grey,
                //     inactiveTextColor: Colors.white,
                //     labels: ['Yes', 'No'],
                //     icons: [FontAwesome.check, FontAwesome.times],
                //     onToggle: (index) {
                //       print('switched to: $index');
                //     }),

                //      Code Yes or No     ]
              ]), //________________________________________________

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: FittedBox(
                    child: Material(
                      color: Colors.blue,
                      elevation: 1.0,
                      borderRadius: BorderRadius.circular(3),
                      shadowColor: Colors.red,
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: ClipRRect(
                                borderRadius: new BorderRadius.horizontal(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Image(
                                      image: AssetImage(
                                        'lib/assets/mylogo.jpg',
                                      ),
                                    )
                                  ],
                                )), //_________________
                          ), //__________________________________
                        ],
                      ),
                    ),
                  ), //________________________________FittedBox_____________________________
                ),
              ),
            ],
          ),
        ),
      ),
    ); //___________________________Translate_To_Ar_______________________
  }
}
