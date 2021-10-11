import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextForm({
  required TextEditingController controller,
  required Function validator,
  required Function onSubmit,
  Function? suffixPressed,
  required String fieldTitle,
  IconData? prefixIcon,
  bool obSecure = false,
  bool readOnly = false,
  TextInputType? type,
  IconData? suffixIcon,
}) {
  return TextFormField(
    obscureText: obSecure,
    onFieldSubmitted: (String value) {
      onSubmit(value);
    },
    readOnly: readOnly,
    keyboardType: type,
    controller: controller,
    validator: (s) => validator(s),
    decoration: InputDecoration(
      labelText: fieldTitle,
      prefixIcon: Icon(prefixIcon),
      suffixIcon: IconButton(
        onPressed: () {
          suffixPressed!();
        },
        icon: Icon(suffixIcon),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black12),
      ),
    ),
  );
}

Widget defaultButton({required Function onPressed, required String lable}) =>
    SizedBox(
      height: 50.0,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          lable.toUpperCase(),
        ),
      ),
    );

defaultToast({required String msg, required toastStates state}) =>
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      // textColor: Colors.white,
      fontSize: 16.0,
    );

enum toastStates { SUCCESS, ERROR, WARNING }

Color? chooseToastColor(toastStates state) {
  Color? color;
  switch (state) {
    case (toastStates.SUCCESS):
      color = Colors.green;
      break;
    case (toastStates.ERROR):
      color = Colors.red;
      break;
    case (toastStates.WARNING):
      color = Colors.amber;
      break;
  }
  return color;
}
