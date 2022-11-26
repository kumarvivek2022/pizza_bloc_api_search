import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referesh_api_bloc/bloc/search_bloc/search_bloc.dart';
import 'package:referesh_api_bloc/screen/home_screen.dart';

import 'bloc/food_bloc.dart';
import 'data/repository/food_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FoodBloc>(
          create: (context) => FoodBloc(foodRepository: FoodRepositoryImpl()),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}



