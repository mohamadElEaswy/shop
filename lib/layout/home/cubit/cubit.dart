import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/constants/consts.dart';
import 'package:shop/layout/categories/categories.dart';
import 'package:shop/layout/favourit/favourit.dart';
import 'package:shop/layout/home/cubit/states.dart';
import 'package:shop/layout/home/homeScreen.dart';
import 'package:shop/layout/setting/setting.dart';
import 'package:shop/model/categoriesModel.dart';
import 'package:shop/model/favouritesModel.dart';
import 'package:shop/model/homeModel.dart';
import 'package:shop/network/endPoints.dart';
import 'package:shop/network/online/dioHelper.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitState());
  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> bodyScreens = [
    Home(),
    CategoriesScreen(),
    Favourite(),
    Setting()
  ];

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavigationItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.category_outlined), label: 'categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'favourite'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings'),
  ];

  void changeBottomNavigationIndex(int i) {
    currentIndex = i;
    emit(ChangeBottomNavigationState());
  }

  HomeModel? homeModel;
  late Map<int, bool?> favorites = {};
  void getHomeData() {
    emit(HomeLoadingState());

    DioHelper.get(
      url: HOME,
      // query: {},
      token: token.toString(),
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach(
        (element) {
          favorites.addAll(
            {
              element.id: element.inFavorites,
            },
          );
        },
      );

      emit(HomeSuccessState());
    }).catchError((error) {
      print(error);

      emit(HomeErrorState(error: error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(CategoriesLoadingState());

    DioHelper.get(
      url: CATEGORIES,
      // query: {},
      // token: token.toString(),
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(CategoriesSuccessState());
    }).catchError((error) {
      print(error);

      emit(CategoriesErrorState(error: error.toString()));
    });
  }

  ChangeFavouritesModel? changeFavouritesModel;



  void changeFavourites(int productId) async {
    emit(ChangeLoadingSuccessState());

    favorites[productId] = !favorites[productId]!;

    // print(favorites[productId].toString());

    emit(ChangeFavoriteSuccessState());
    DioHelper.post(
      url: FAVOURITES,
      data: {
        'product_id': productId,
      },
      token: token.toString(),
    )
        .then((value) => {
              changeFavouritesModel =
                  ChangeFavouritesModel.fromJson(value.data),
              if (changeFavouritesModel!.status = !true)
                {favorites[productId] = !favorites[productId]!}
              else
                {getFavouritesData()},
              emit(ChangeFavoritesSuccessState()),
            })
        .catchError((e) {
      print(e.toString());
      favorites[productId] = !favorites[productId]!;
      emit(ChangeFavoritesErrorState(error: e.toString()));
    });
  }

  FavouriteModel? favouriteModel;

  void getFavouritesData() {
    emit(GetFavoritesLoadingState());

    DioHelper.get(
      url: FAVOURITES,
      // query: {},
      token: token.toString(),
    ).then((value) {
      favouriteModel = FavouriteModel.fromJson(value.data);
      print(value.data);

      emit(FavoritesSuccessState());
    }).catchError((error) {
      print(error);

      emit(FavoritesErrorState(error: error.toString()));
    });
  }

  // UserModel? userData;

}
