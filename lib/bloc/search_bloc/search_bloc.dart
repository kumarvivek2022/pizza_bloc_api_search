import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referesh_api_bloc/data/model/food_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  SearchBloc() : super(SearchInitial()) {
    on<SearchFoodEvent>((event, emit) {
      try{
        emit(SearchLoadingState());
        List<Recipe> recipes = [];
        if(event.recipes.isNotEmpty && event.searchKey.isNotEmpty) {
          for (var i = 0; i < event.recipes.length; i++) {
            if (event.recipes[i].title.toLowerCase().trim().contains(
                event.searchKey.toLowerCase().trim())) {
              recipes.add(event.recipes[i]);
            }
          }
          if(recipes.isNotEmpty) {
            emit(SearchLoadedState(recipes: recipes));
          }
          else{
            emit(SearchErrorState(message: "No item with this name"));
          }
        }
        else{
          emit(SearchInitial());
        }
        if (kDebugMode) {
          print(recipes.toString());
        }
      } catch(e){
        if (kDebugMode) {
          print(e.toString());
        }
        emit(SearchErrorState(message: e.toString()));
      }
    });
    on<ClearSearchEvent>((event, emit) {
      try{
        emit(SearchInitial());
      } catch(e){
        if (kDebugMode) {
          print(e.toString());
        }
        emit(SearchErrorState(message: e.toString()));
      }
    });
  }
}
