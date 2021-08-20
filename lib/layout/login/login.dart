import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop/cubit/cubit.dart';
import 'package:shop/cubit/states.dart';
import 'package:shop/layout/components/components.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Welcome'),
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
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'login words',
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextForm(
                          onTap: () {},
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
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextForm(
                          onTap: () {},
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Email is required';
                            }
                          },
                          controller: passwordController,
                          fieldTitle: 'Password'.toUpperCase(),
                          type: TextInputType.number,
                          prefixIcon: Icons.lock,
                          suffixIcon: Icons.remove_red_eye_outlined,
                          obSecure: true,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Conditional.single(context: context,
                            conditionBuilder: (BuildContext context) => state is! LoginLoadingState,
                            widgetBuilder: (BuildContext context){return defaultButton(
                              lable: 'login',
                              onPressed: () async{
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                            );},
                            fallbackBuilder: (BuildContext context){return Center(child: CircularProgressIndicator(),);})
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
