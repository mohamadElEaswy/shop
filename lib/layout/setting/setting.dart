import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/constants/constFunctions.dart';
import 'package:shop/layout/components/components.dart';
import 'package:shop/layout/login/cubit/cubit.dart';
import 'package:shop/layout/login/cubit/states.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        // LoginCubit cubit = LoginCubit.get(context);
        // HomeCubit homeCubit = HomeCubit.get(context);

        nameController.text = LoginCubit.get(context).userModel.userData!.name;
        emailController.text = LoginCubit.get(context).userModel.userData!.email;
        phoneController.text = LoginCubit.get(context).userModel.userData!.phone;
        return SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          physics: BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                defaultTextForm(
                  fieldTitle: 'User Name',
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'user name is required';
                    }
                  },
                  controller: nameController,
                  onSubmit: () {},
                  prefixIcon: Icons.person,
                ),
                SizedBox(height: 20.0),
                defaultTextForm(
                  fieldTitle: 'Email',
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'email is required';
                    }
                  },
                  controller: emailController,
                  onSubmit: () {},
                  prefixIcon: Icons.email,
                ),
                SizedBox(height: 20.0),
                defaultTextForm(
                  fieldTitle: 'Phone Number',
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'phone number is required';
                    }
                  },
                  controller: phoneController,
                  onSubmit: () {},
                  prefixIcon: Icons.phone,
                ),
                SizedBox(height: 20.0),
                Container(
                    height: 60.0,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).updateSettingData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        child: Text('Update'.toUpperCase()))),
                SizedBox(height: 20.0),
                Container(
                    height: 60.0,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          // nameController.clear();
                          // emailController.clear();
                          // phoneController.clear();
                          logOut(context);
                        },
                        child: Text('LogOut'))),
                SizedBox(height: 20.0),
                IconButton(
                  onPressed: () {
                    LoginCubit.get(context).changeTheme();
                  },
                  icon: Icon(
                    LoginCubit.get(context).isDarkMode
                        ? Icons.brightness_4
                        : Icons.brightness_4_outlined,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
