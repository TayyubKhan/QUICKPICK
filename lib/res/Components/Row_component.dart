import 'package:flutter/material.dart';
import 'package:mvvm/res/colors.dart';

class Row_Component extends StatelessWidget {
  String string1,string2;
   Row_Component({Key? key,required this.string1,required this.string2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(string1,style: const TextStyle(fontWeight: FontWeight.w500,color: textcolor)),
        Text(string2,style: const TextStyle(color: textcolor),)
      ],
    );
  }
}
