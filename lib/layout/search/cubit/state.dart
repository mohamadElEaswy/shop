import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SearchState{}

class SearchInitState extends SearchState{}

class SearchLoadingState extends SearchState{}

class SearchSuccessState extends SearchState{}

class SearchErrorState extends SearchState{
  final error;

  SearchErrorState(this.error);
}