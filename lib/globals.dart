import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String baseURL = 'http://192.168.8.109:8000/api/';
String baseImageURL = 'http://192.168.8.109:8000/';

Dio dioClient = new Dio();

var userId;
var userPhone;
var userImage;
var userName;
var userType;
var userEmail;
var userLicence;

var lat;
var long;
var locationSelected = false;







