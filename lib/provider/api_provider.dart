// ignore_for_file: unused_catch_clause

import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;


class ApiProvider {
  
var client = http.Client();
  Future<dynamic> getData(
  {
  required String baseUrl,
  required String url
  })async{
  try{
    EasyLoading.show( status: 'Loading...', maskType: EasyLoadingMaskType.clear);
    var response = await client.get(Uri.parse("$baseUrl/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    EasyLoading.dismiss();
    if(response.statusCode == 200){
      var jsonString = jsonDecode(response.body);
      return jsonString;
    }else{
      // ignore: unused_local_variable
      var errorBody = jsonDecode(response.body);
      return null;
    }
  } on SocketException catch (_) {
    EasyLoading.dismiss();
  } on HttpException catch (error) {
    EasyLoading.dismiss();
  } on FormatException catch (error) {
    EasyLoading.dismiss();
  } catch (e) {
    EasyLoading.dismiss();
  }
  return null;
}

}