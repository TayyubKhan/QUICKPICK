import 'dart:convert';
import 'dart:io';

import 'package:mvvm/data/app_exception.dart';
import 'package:mvvm/data/network/base_apiservices.dart';
import 'package:http/http.dart' as http;

class Netwrok_API_Services extends Base_API_Services{
  @override
  Future getGetAPI_services(String url) async {
    dynamic responseJSon;
   try{
     final response= await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
     responseJSon=return_response(response);
   }on SocketException{
     throw FetchDataException('No Internet Connectivity');
   }
   return responseJSon;
  }

  @override
  Future getPostAPI_services(String url,dynamic data) async {
    dynamic responseJSon;
    try{
      final response= await http.post(Uri.parse(url),
      body: data).timeout(const Duration(seconds: 10));
      responseJSon=return_response(response);
    }on SocketException{
      throw FetchDataException('No Internet Connectivity');
    }
    return responseJSon;
  }
  dynamic return_response(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson= jsonDecode(response.body);
        return responseJson;
      case 404:
        throw UnauthorizedException(response.body.toString());
      default:
        throw FetchDataException('Error occured while communicating with servers');

    }

  }
}
