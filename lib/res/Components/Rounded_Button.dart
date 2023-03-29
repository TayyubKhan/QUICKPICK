import 'package:flutter/material.dart';
import 'package:mvvm/res/colors.dart';

class Rounded_Button extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const Rounded_Button({Key? key,required this.title,this.loading=false,required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 100,
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primarycolor
        ),
        child: Center(child: loading? const CircularProgressIndicator(color: Colors.white,):Text(title,style: const TextStyle(color: textcolor)))
      ),
    );
  }
}
