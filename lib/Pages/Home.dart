import 'package:flutter/material.dart';
import 'package:pharmacy/Pages/UserHome.dart';
import 'package:pharmacy/Pages/Admn.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: new Text('الرئيسية'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 80,),
          Container(
            child: CircleAvatar(
              radius: 60.0,
              backgroundImage: AssetImage('lib/assets/mylogo.jpg'),
            ),
          ), //+++++++
          SizedBox(height: 50,), // ++++++++++++++++++++++++++++++++++
          Container(
            margin: EdgeInsets.all(20),
            width: double.maxFinite,
            height: 60,
            child: RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25),
                  side: BorderSide(color: Colors.blue)),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => User()));
              },
              color: Colors.white,
              textColor: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    color: Colors.blue,
                    size: 30,
                  ),
                  Text(
                    'مستخــدم',
                    style: TextStyle(
                      fontSize: 35,
                    ),
                  )
                ],
              ),
            ), //__________________________
          ), //___________________________________________________________________________
          Container(
            margin: EdgeInsets.all(20),
            width: double.maxFinite,
            height: 60,
            child: RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25),
                  side: BorderSide(color: Colors.white)),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Admin()));
              },
              color: Colors.blue,
              textColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.business_center,
                    size: 30,
                  ),
                  Text(
                    'صيــدلـــية',
                    style: TextStyle(fontSize: 35),
                  ),
                ],
              ),
            ), //__________________________________
          ), //_________________________________________________________________________________
          SizedBox(
            width: 20,
            height: 25,
          ),
        ],
      ), //______________________________________________________________________________________________
    );
  }
}
