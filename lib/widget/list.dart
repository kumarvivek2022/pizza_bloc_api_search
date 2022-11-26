import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referesh_api_bloc/bloc/search_bloc/search_bloc.dart';

import '../data/model/food_model.dart';

Widget buildHintsList(List<Recipe> recipes, BuildContext context, SearchBloc searchBloc, TextEditingController controller) {
  return SizedBox(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            controller: controller,
            onFieldSubmitted: (v) {
              searchBloc.add(SearchFoodEvent(searchKey: v.toString(),recipes:recipes));
            },
            decoration: InputDecoration(
              prefixIcon: const IconButton(
                onPressed: null,
                icon:  Icon(Icons.search),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  controller.clear();
                  searchBloc.add(ClearSearchEvent());
                },
                icon: const Icon(Icons.clear),
              ),
              hintText: "Search Pizza",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        Expanded(child: BlocProvider(
          create: (context) => searchBloc,
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if(state is SearchLoadedState){
                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.7,
                      children: List.generate(state.recipes.length, (index){
                        return Card(
                          elevation: 10,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 100,
                                child: Image.network(
                                  state.recipes[index].imageUrl,
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                ),
                              ),
                              // SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
                                child: Text(
                                  state.recipes[index].title,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
                                child: Text(
                                  "Recipe Id :${state.recipes[index].recipeId}",
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
                                child: Text(state.recipes[index].publisher),
                              )
                            ],
                          ),
                        );
                      },
                      ),
                    ),
                  );
              }
              if(state is SearchErrorState && state.message=="No item with this name"){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Icon(Icons.no_drinks_outlined, size: 80, color: Colors.grey.withOpacity(0.3),),
                       const SizedBox(height: 20,),
                       Text(state.message, style: const TextStyle(
                         fontSize: 30,
                       ),)
                    ],
                  ),
                );
              }
              return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.7,
                  children: List.generate(recipes.length, (index){
                      return Card(
                        elevation: 10,
                        color: Colors.white,
                        child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 100,
                              child: Image.network(
                                recipes[index].imageUrl,
                                fit: BoxFit.cover,
                                height: 150,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                              ),
                            ),
                            // SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
                              child: Text(
                                recipes[index].title,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
                              child: Text(
                                "Recipe Id :${recipes[index].recipeId}",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
                              child: Text(recipes[index].publisher),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ))
      ],
    ),
  );
}
