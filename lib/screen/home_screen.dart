import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referesh_api_bloc/bloc/search_bloc/search_bloc.dart';
import '../bloc/food_bloc.dart';
import '../bloc/food_event.dart';
import '../bloc/food_state.dart';
import '../widget/error.dart';
import '../widget/list.dart';
import '../widget/loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  final SearchBloc searchBloc = SearchBloc();
  @override
  void initState() {
     BlocProvider.of<FoodBloc>(context).add(FetchFoodEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocBuilder<FoodBloc, FoodState>(builder: (context, state) {
        if (state is FoodLoadingState) {
          return buildLoading();
        } else if (state is FoodLoadedState) {
          return buildHintsList(
              state.recipes, context, searchBloc, searchController);
        } else if (state is FoodErrorState) {
          return buildError(state.message);
        } else {
          return buildLoading();
        }
      }),
    );
  }
}

// class Vivek extends StatefulWidget{
//   Vivek({Key? key}):super(key: key);
//   @override
//   State<Vivek> createState() => _VivekState();
// }
// class _VivekState extends State<Vivek>{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
//
// }