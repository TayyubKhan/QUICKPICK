import 'package:mvvm/data/network/base_apiservices.dart';
import 'package:mvvm/data/network/network_api_services.dart';
import 'package:mvvm/res/app_url.dart';

class AuthRepository{
  Base_API_Services _apiservices=Netwrok_API_Services();
  Future<dynamic> loginApi(dynamic data)async{
    try{
      dynamic response=await _apiservices.getPostAPI_services(AppUrl.loginApiEndPoint, data);
      return response;
    }
    catch(e)
    {
      throw e;
    }
  }
  Future<dynamic> registerApi(dynamic data)async{
    try{
      dynamic response=await _apiservices.getPostAPI_services(AppUrl.registerApiEndpoint, data);
      return response;
    }
    catch(e)
    {
      throw e;
    }
  }
}