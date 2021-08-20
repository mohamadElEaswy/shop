import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/states.dart';
import 'package:shop/network/endPoints.dart';
import 'package:shop/network/online/dioHelper.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required email, required password}) {
    emit(LoginLoadingState());
    DioHelper.post(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      emit(LoginSuccessState());
    }).catchError((e) {
      print(e);
      emit(LoginErrorState(e.toString()));
    });
  }
}
