import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/food_model.dart';
import '../data/repository/food_repository.dart';
import 'food_event.dart';
import 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodRepository foodRepository;
  FoodBloc({ required this.foodRepository}) : super(FoodInitialState()){

    on<FetchFoodEvent>((event, emit) async{
      try{
        emit(FoodLoadingState());
        List<Recipe> recipes = await foodRepository.getFoods();
        print(recipes.toString());
        emit(FoodLoadedState(recipes: recipes));
      } catch(e){
        print(e.toString());
        emit(FoodErrorState(message: e.toString()));
      }
    });
  }
}