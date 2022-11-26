part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class SearchFoodEvent extends SearchEvent {
  final String searchKey;
  List<Recipe> recipes ;
  SearchFoodEvent({required this.searchKey,required this.recipes});
  @override
  List<Object> get props => [searchKey,recipes];
}

class ClearSearchEvent extends SearchEvent{
}