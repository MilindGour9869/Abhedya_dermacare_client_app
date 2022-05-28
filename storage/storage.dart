import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class Storage{

  static final storage = FlutterSecureStorage();

  static const profile_uint8list = 'profile_uint8list';


  static Future set_profile_uint8list({@required Uint8List profile_data})async{

    String result = String.fromCharCodes(profile_data);

  await storage.write(key:'profile_uint8list', value: result);

  }

  static Future<Uint8List> get_profile_uint8list()async{

    String result = await storage.read(key:'profile_uint8list');

    List<int> data  = utf8.encode(result);

    Uint8List bytes = Uint8List.fromList(data);

    return bytes;


  }








}