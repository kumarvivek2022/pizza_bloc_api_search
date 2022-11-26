part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<Recipe> recipes;
  SearchLoadedState({required this.recipes});
}

class SearchErrorState extends SearchState {
  final String message;
  SearchErrorState({required this.message});
}