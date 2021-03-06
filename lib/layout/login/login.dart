import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/constants/constFunctions.dart';
import 'package:shop/layout/components/components.dart';
import 'package:shop/layout/login/cubit/cubit.dart';
import 'package:shop/layout/login/cubit/states.dart';
import 'package:shop/layout/register/registerScreen.dart';
import 'package:shop/themes/styles/color.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          print(state.error);
          defaultToast(
            msg: LoginCubit.get(context).userModel.message,
            state: toastStates.ERROR,
          );
        }
        if (state is LoginSuccessState) {
          if (state.userModel.status) {
            defaultToast(
              msg: state.userModel.message,
              state: toastStates.SUCCESS,
            );
          }
        }
      },
      builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('title'),
            actions: [
              IconButton(
                onPressed: () {
                  cubit.changeTheme();
                },
                icon: Icon(
                  cubit.isDarkMode
                      ? Icons.brightness_4
                      : Icons.brightness_4_outlined,
                ),
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'login'.toUpperCase(),
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'We are trying to publish the knowledge for everyone . . . . ',
                      ),
                      SizedBox(height: 30.0),
                      defaultTextForm(
                        onSubmit: () {},
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Email is required';
                          }
                        },
                        controller: emailController,
                        fieldTitle: 'Email'.toUpperCase(),
                        type: TextInputType.emailAddress,
                        prefixIcon: Icons.email_outlined,
                      ),

                      SizedBox(height: 30.0),



                      defaultTextForm(
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Password is required';
                          }
                        },
                        controller: passwordController,
                        fieldTitle: 'Password'.toUpperCase(),
                        type: TextInputType.number,
                        prefixIcon: Icons.lock,
                        suffixIcon: cubit.passwordIcon,
                        suffixPressed: () {
                          cubit.changePasswordVisibility();
                        },
                        obSecure: cubit.isPassword,
                        onSubmit: () async {
                          if (formKey.currentState!.validate()) {
                            cubit.userLogin(
                              context: context,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 30.0),

                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        fallback: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        builder: (BuildContext context) {
                          return defaultButton(
                            lable: 'login',
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context,
                                );
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(height: 30.0),
                      Center(
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Do not have an account!'),SizedBox(width: 5.0),
                            GestureDetector(
                              onTap: () {
                                navigateTo(context, RegisterScreen());},
                              child: Text(
                                'Register',
                                style: TextStyle(color: defaultColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
