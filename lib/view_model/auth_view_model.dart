import 'package:flutter/cupertino.dart';
import 'package:mvvm/repository/auth_repo.dart';
import 'package:mvvm/utils/utilis.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../model/User_model.dart';
import '../utils/Routes/routes_name.dart';

class AuthViewModelProvider with ChangeNotifier {
  bool _loading=false;
  bool get loading=>_loading;
  setLoading(bool value)
  {
    _loading=value;
    notifyListeners();
  }

  final _myrepo = AuthRepository();
  Future<void> loginApi(BuildContext context, dynamic data) async {
    _myrepo.loginApi(data).then((value) {
     setLoading(false);
     final userPreference = Provider.of<UserViewModel>(context , listen: false);
     userPreference.saveUser(
         UserModel(
             token: value['token'].toString()
         )
     );
      Utilis.flushbar_message(context, "Login Successfully");
     Navigator.pushNamed(context, Routesname.home);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utilis.flushbar_message(context, error.toString());
    });
  }
  Future<void> registerApi(BuildContext context, dynamic data) async {
    _myrepo.registerApi(data).then((value) {
      setLoading(false);
      Utilis.flushbar_message(context, "Sign Up Successfully");
    }).onError((error, stackTrace) {
      setLoading(false);
      Utilis.flushbar_message(context, error.toString());
    });
  }
}
