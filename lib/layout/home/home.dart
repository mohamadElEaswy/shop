import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/constants/constFunctions.dart';
import 'package:shop/layout/home/cubit/cubit.dart';

import 'package:shop/layout/search/search.dart';

import 'cubit/states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)),

            ],
          ),
          body: cubit.bodyScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavigationItems,
            onTap: (int index) {
              cubit.changeBottomNavigationIndex(index);
            },
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}

