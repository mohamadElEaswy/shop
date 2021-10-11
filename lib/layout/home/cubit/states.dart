
abstract class HomeState{}




class HomeInitState extends HomeState{}
class ChangeBottomNavigationState extends HomeState{}

class HomeLoadingState extends HomeState{}
class HomeSuccessState extends HomeState{}
class HomeErrorState extends HomeState{
  final String error;

  HomeErrorState({required this.error});
}


class CategoriesLoadingState extends HomeState{}
class CategoriesSuccessState extends HomeState{}

class CategoriesErrorState extends HomeState{
  final String error;

  CategoriesErrorState({required this.error});
}


class ChangeFavoritesSuccessState extends HomeState{}
class ChangeFavoriteSuccessState extends HomeState{}
class ChangeLoadingSuccessState extends HomeState{}
class ChangeFavoritesErrorState extends HomeState{
  final String error;

  ChangeFavoritesErrorState({required this.error});
}

class GetFavoritesLoadingState extends HomeState{}
class FavoritesSuccessState extends HomeState{}
class FavoritesErrorState extends HomeState{
  final String error;

  FavoritesErrorState({required this.error});
}


