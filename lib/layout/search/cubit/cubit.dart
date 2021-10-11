import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/constants/consts.dart';
import 'package:shop/layout/search/cubit/state.dart';
import 'package:shop/model/searchModel.dart';
import 'package:shop/network/endPoints.dart';
import 'package:shop/network/online/dioHelper.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitState());
  static SearchCubit get(context) => BlocProvider.of(context);

  late SearchModel model;
  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.post(
            url: SEARCH,
            data: {
              'text': text,
            },
            token: token.toString(),)
        .then((value) {
          print(text);
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    })
        .catchError((e) {
          print(e.toString());
      SearchErrorState(e.toString());
    });
  }
}
