import 'package:shop/model/userModel.dart';

abstract class LoginState{}




class LoginInitState extends LoginState{}
class LoginLoadingState extends LoginState{}
class LoginSuccessState extends LoginState{
  final UserModel userModel;
  LoginSuccessState(this.userModel);

}
class LoginErrorState extends LoginState{
  final String error;

  LoginErrorState(this.error);
}
class ChangePasswordVisibilityState extends LoginState{}
class ChangeThemeState extends LoginState{}


// abstract class RegisterState{}




class RegisterInitState extends LoginState{}
class RegisterLoadingState extends LoginState{}
class RegisterSuccessState extends LoginState{
  final UserModel userRegisterModel;
  RegisterSuccessState(this.userRegisterModel);

}
class RegisterErrorState extends LoginState{
  final String error;

  RegisterErrorState(this.error);
}


class SettingLoadingState extends LoginState{}
class SettingSuccessState extends LoginState{}

class SettingErrorState extends LoginState{
  final String error;

  SettingErrorState({required this.error});
}


class UpdateUserLoadingState extends LoginState{}
class UpdateSuccessState extends LoginState{}
class UpdateErrorState extends LoginState{
  final String error;

  UpdateErrorState({required this.error});
}
