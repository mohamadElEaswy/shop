import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/constants/constFunctions.dart';
import 'package:shop/constants/consts.dart';
import 'package:shop/layout/home/home.dart';
import 'package:shop/layout/login/cubit/states.dart';
import 'package:shop/model/userModel.dart';
import 'package:shop/network/endPoints.dart';
import 'package:shop/network/local/cacheHelper.dart';
import 'package:shop/network/online/dioHelper.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isDarkMode = false;
  void changeTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDarkMode = fromShared;
    } else {
      isDarkMode = !isDarkMode;
      fromShared = isDarkMode;
      CacheHelper.saveData(key: 'isDark', value: isDarkMode).then((value) {
        emit(ChangeThemeState());
      });
    }
  }

  late UserModel userModel;
  void userLogin({required email, required password, required context}) {
    emit(LoginLoadingState());
    DioHelper.post(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
      CacheHelper.sharedPreferences!
          .setString('token', userModel.userData!.token.toString());
      token = userModel.userData!.token.toString();

      navigateAndRemove(context, HomeScreen());

      // print(userModel.userData!.token);

      emit(LoginSuccessState(userModel));
    }).catchError((e) {
      print(e);
      emit(LoginErrorState(e.toString()));
    });
  }

  bool isPassword = true;
  IconData passwordIcon = Icons.visibility;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    isPassword
        ? passwordIcon = Icons.visibility_off
        : passwordIcon = Icons.visibility;
    emit(ChangePasswordVisibilityState());
  }
  void userRegister(
      {required email,
        required password,
        required name,
        required phone,
        required context}) {
    emit(RegisterLoadingState());
    DioHelper.post(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
      CacheHelper.sharedPreferences!.clear();
      CacheHelper.sharedPreferences!
          .setString('token', userModel.userData!.token.toString());
      token = userModel.userData!.token.toString();
      navigateAndRemove(context, HomeScreen());

      emit(RegisterSuccessState(userModel));
    }).catchError((e) {
      print(e);
      emit(RegisterErrorState(e.toString()));
    });
  }



  void getSettingData() {
    emit(SettingLoadingState());

    DioHelper.get(
      url: PROFILE,
      // query: {},
      token: token.toString(),
    ).then((value) {
      userModel = UserModel.fromJson(value.data);

      emit(SettingSuccessState());
    }).catchError((error) {
      print(error);

      emit(SettingErrorState(error: error.toString()));
    });
  }

  void updateSettingData({
    required name,
    required email,
    required phone,
  }) {
    emit(UpdateUserLoadingState());

    DioHelper.put(
      url: UPDATE_PROFILE,
      data: {
        "name": name,
        "email": email,
        "phone": phone,
      },
      // query: {},
      token: token.toString(),
    ).then((value) {
      userModel = UserModel.fromJson(value.data);

      emit(UpdateSuccessState());
    }).catchError((error) {
      print(error);

      emit(UpdateErrorState(error: error.toString()));
    });
  }
}
