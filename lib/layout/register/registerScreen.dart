import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/components/components.dart';
import 'package:shop/layout/login/cubit/cubit.dart';
import 'package:shop/layout/login/cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is RegisterErrorState) {
          print(state.error);
          defaultToast(
            msg: LoginCubit.get(context).userModel.message,
            state: toastStates.ERROR,
          );
        }
        if (state is RegisterSuccessState) {
          if (state.userRegisterModel.status) {
            defaultToast(
              msg: state.userRegisterModel.message,
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
                      SizedBox(height: 20.0),

                      defaultTextForm(
                        onSubmit: () {},
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'name is required';
                          }
                        },
                        controller: nameController,
                        fieldTitle: 'name'.toUpperCase(),
                        type: TextInputType.name,
                        prefixIcon: Icons.person,
                      ),
                      SizedBox(height: 20.0),

                      defaultTextForm(
                        onSubmit: () {},
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'phone is required';
                          }
                        },
                        controller: phoneController,
                        fieldTitle: 'phone'.toUpperCase(),
                        type: TextInputType.phone,
                        prefixIcon: Icons.phone,
                      ),SizedBox(height: 20.0),
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
                        // suffixIcon: cubit.passwordIcon,
                        suffixPressed: () {
                          // cubit.changePasswordVisibility();
                        },
                        // obSecure: cubit.isPassword,
                        onSubmit: () async {
                          if (formKey.currentState!.validate()) {
                            cubit.userRegister(
                              context: context,
                              email: emailController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 30.0),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        fallback: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        builder: (BuildContext context) {
                          return defaultButton(
                            lable: 'Register',
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context,
                                );
                              }
                            },
                          );
                        },
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
