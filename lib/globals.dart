import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String baseURL = 'http://192.168.8.144:8000/api/';
String baseImageURL = 'http://192.168.8.144:8000/';
Dio dioClient = new Dio();

var latitude;
var longitude;
LatLng lastMapPosition;

var userId;
var userPhone;
var userImage;
var userName;
var userType;
var userEmail;
var userLicence;


var lat;
var long;







