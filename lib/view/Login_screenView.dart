import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/res/Components/Rounded_Button.dart';
import 'package:mvvm/res/colors.dart';
import 'package:mvvm/utils/Routes/routes_name.dart';
import 'package:mvvm/utils/utilis.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ValueNotifier<bool> obsecureText = ValueNotifier<bool>(true);
  FocusNode emailfoucs = FocusNode();
  FocusNode passwordfocus = FocusNode();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailfoucs.dispose();
    passwordfocus.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    obsecureText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authviewmodelprovider = Provider.of<AuthViewModelProvider>(context);
    double height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          backgroundColor: primarycolor,
          centerTitle: true,
        ),
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              TextFormField(
                onTapOutside: (value) {
                  passwordfocus.unfocus();
                },
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {
                  Utilis.fieldocusnode(context, emailfoucs, passwordfocus);
                },
                focusNode: emailfoucs,
                controller: _emailcontroller,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: const TextStyle(color: primarycolor),
                  focusColor: primarycolor,
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: primarycolor),
                      borderRadius: BorderRadius.circular(10)),
                  alignLabelWithHint: false,
                  hintText: "Email",
                  prefixIcon: const Icon(
                    Icons.alternate_email_outlined,
                    color: primarycolor,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              ValueListenableBuilder(
                  valueListenable: obsecureText,
                  builder: (context, value, child) {
                    return TextFormField(
                        onTapOutside: (value) {
                          passwordfocus.unfocus();
                        },
                        focusNode: passwordfocus,
                        controller: _passwordcontroller,
                        obscureText: obsecureText.value,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: const TextStyle(color: primarycolor),
                          focusColor: primarycolor,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: primarycolor),
                              borderRadius: BorderRadius.circular(10)),
                          alignLabelWithHint: false,
                          hintText: "Password",
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: primarycolor,
                          ),
                          suffixIconColor: primarycolor,
                          suffixIcon: InkWell(
                              onTap: () {
                                obsecureText.value = !obsecureText.value;
                              },
                              child: obsecureText.value
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                        ));
                  }),
              SizedBox(
                height: height * 0.01,
              ),
              Rounded_Button(
                  title: "Login",
                  loading: authviewmodelprovider.loading,
                  onPress: () {
                    if (_emailcontroller.text.isEmpty) {
                      Utilis.flushbar_message(context, "Please enter Email");
                    } else if (_passwordcontroller.text.isEmpty) {
                      Utilis.flushbar_message(
                          context, "Please Enter your password");
                    } else if (_passwordcontroller.text.length < 6) {
                      Utilis.flushbar_message(
                          context, "Please Enter a 6 digit Password");
                    } else {
                      // Map data = {
                      //   "email": _emailcontroller.text.toString(),
                      //   "password": _passwordcontroller.text.toString()
                      // };
                      Map data = {
                        "email": "eve.holt@reqres.in",
                        "password": "cityslicka"
                      };
                      authviewmodelprovider.loginApi(context, data);
                      if (kDebugMode) {
                        print("Api hit");
                      }
                    }
                  }),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?  "),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routesname.signup);
                        },
                        child: const Text('Signup Now',
                            style: TextStyle(fontStyle: FontStyle.italic)))
                  ])
            ])));
  }
}