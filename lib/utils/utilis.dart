import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:mvvm/res/colors.dart';

class Utilis {
  static double averageRating(List<int> rating){
    var avgRating=0;
    for(int i=0;i<rating.length;i++){
      avgRating=avgRating+rating[i];
    }
    return double.parse((avgRating/rating.length).toStringAsFixed(1));
  }

  static fieldocusnode(BuildContext context,FocusNode currentfocus,FocusNode nextfocus)
  {
    currentfocus.unfocus();
    FocusScope.of(context).requestFocus(nextfocus);
  }
  static toast_message(String message) {
    Fluttertoast.showToast(
        msg: message, backgroundColor: Colors.teal, textColor: Colors.white);
  }

  static flushbar_message(BuildContext context,String message) {
    Flushbar(
      message: message,
      title: 'FLushBar',
      titleColor: textcolor,
      backgroundColor: primarycolor,
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.BOTTOM,
      margin:const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(20),
      duration: const Duration(seconds: 3),
      borderRadius: BorderRadius.circular(8),
      animationDuration: const Duration(seconds: 1),
      icon: const Icon(Icons.error, color: Colors.white),
      forwardAnimationCurve: Curves.decelerate,
      reverseAnimationCurve: Curves.fastOutSlowIn,
    ).show(context);
  }
  static void Snackbar_Message(BuildContext context,String message)
  {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
