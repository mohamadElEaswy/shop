import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/boarding/boarding.dart';
import 'package:shop/layout/home/cubit/cubit.dart';
import 'package:shop/layout/home/home.dart';
import 'package:shop/layout/login/cubit/cubit.dart';
import 'package:shop/layout/login/cubit/states.dart';
import 'package:shop/layout/login/login.dart';
import 'package:shop/layout/search/cubit/cubit.dart';
import 'package:shop/network/local/cacheHelper.dart';
import 'package:shop/themes/theme.dart';
import 'constants/consts.dart';
import 'network/online/dioHelper.dart';
import 'observiation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool dark = CacheHelper.sharedPreferences!.getBool('isDark') ?? false;
  bool isFirst = CacheHelper.sharedPreferences!.getBool('isFirst') ?? false;
  token = CacheHelper.sharedPreferences!.getString('token').toString();
  Widget? widget;
  if (isFirst != false) {
    if (token != false) {
      widget = HomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = BoardingScreen();
  }

  runApp(
    MyApp(
      dark: dark,
      widget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({required this.dark, required this.widget});
  final bool dark;
  final widget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (BuildContext context) =>
          LoginCubit()..changeTheme(fromShared: dark)..getSettingData(),
        ),
        BlocProvider<HomeCubit>(
          create: (BuildContext context) =>
          HomeCubit()..getHomeData()..getCategoriesData()..getFavouritesData(),
        ),
        BlocProvider<SearchCubit>(
          create: (BuildContext context) =>SearchCubit(),
        ),
      ],
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: cubit.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: widget,
          );
        },
      ),
    );
  }
}
