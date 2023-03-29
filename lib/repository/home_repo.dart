import 'package:mvvm/model/Movies_List_Model.dart';

import '../data/network/base_apiservices.dart';
import '../data/network/network_api_services.dart';
import '../res/app_url.dart';

class HomeRepository{
  Base_API_Services _apiservices=Netwrok_API_Services();
  Future<MovieListModel> fetchMovies()async{
    try{
      dynamic response=await _apiservices.getGetAPI_services(AppUrl.moviesListEndPoint);
      return response= MovieListModel.fromJson(response);
    }
    catch(e)
    {
      throw e;
    }
  }
}