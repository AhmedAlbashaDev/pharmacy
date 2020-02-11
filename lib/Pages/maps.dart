import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmacy/globals.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {

  GoogleMapController mapController;

  var currentLocation;

  var latitude, longitude;

  void _onCameraMove(CameraPosition position) {
    setState(() {
      lat =  position.target.latitude;
      print('lat: ' +  lat.toString() );
      long =  position.target.longitude;
      print('long: ' +  long.toString() );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        lat = currloc.latitude;
        long= currloc.longitude;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text('إضافة موقعك'),
          ), //_______________________________________________________________________
          body: currentLocation == null
              ? Container(
            alignment: Alignment.center,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ) //____________________________________
              : Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(currentLocation.latitude,
                        currentLocation.longitude),
                    zoom: 13.4746),
                onMapCreated: _onMapCreated,
                onCameraMove: _onCameraMove,
                myLocationEnabled: true,
                mapType: MapType.normal,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      locationSelected = true;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[500],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),

                      )
                    ),
                    height: 50,
                    child: Center(
                      child: Text('تحديد هذا الموقع',style: TextStyle(color: Colors.grey[100],fontSize: 20,fontWeight: FontWeight.w600),),
                    ),
                  ),
                ),
              ),// ________MapCode___________
              //__________________Start SlideupPanel____________//___________End______________
              Center(
                child: Container(
//                  margin: EdgeInsets.only(bottom: 15),
                  child: Icon(Icons.location_on,color: Colors.red,size: 25,),
                ),
              ),
            ],
          ),
        ),
      ),
    ); //_
  }
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
