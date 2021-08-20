import 'package:flutter/material.dart';

Widget defaultTextForm({
  required TextEditingController controller,
  required Function validator,
  required Function onTap,
  required String fieldTitle,
  IconData? prefixIcon,
  bool obSecure = false,
  bool readOnly = false,
  TextInputType? type,
  IconData? suffixIcon,
}) {
  return TextFormField(
    readOnly: readOnly,
    controller: controller,
    validator: (s) => validator(s),
    onTap: () {
      onTap();
    },
    decoration: InputDecoration(
      labelText: fieldTitle,
      prefixIcon: Icon(prefixIcon),
      suffixIcon: Icon(suffixIcon),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black12),
      ),
    ),
  );
}


Widget defaultButton({required Function onPressed, required String lable}) => SizedBox(
  height: 50.0,
  width: double.infinity,
  child: ElevatedButton(
    onPressed: (){onPressed();},
    child: Text(
      lable.toUpperCase(),
    ),
  ),
);
