import 'package:equatable/equatable.dart';
import '../data/model/food_model.dart';

abstract class FoodState extends Equatable {
  @override
  List<Object> get props => [];
}

class FoodInitialState extends FoodState {

}

class FoodLoadingState extends FoodState {

}

class FoodLoadedState extends FoodState {
  final List<Recipe> recipes;
  FoodLoadedState({required this.recipes});
}

class FoodErrorState extends FoodState {
  final String message;
  FoodErrorState({required this.message});

}