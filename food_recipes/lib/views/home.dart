import 'package:calculator_app/models/recipe.api.dart';
import 'package:calculator_app/models/recipe.dart';
import 'package:calculator_app/views/widgets/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../shared_preferences/shared_preferences_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe>? _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<SharedPreferencesHelper>(context, listen: false).getTheme();
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder:
          (context, SharedPreferencesHelper sharedPreferencesHelper, child) {
        return MaterialApp(
          title: 'Food recipe',
          debugShowCheckedModeBanner: false,
          theme: sharedPreferencesHelper.selectedTheme == "dark"
              ? darkTheme
              : lightTheme,
          home: Scaffold(
              appBar: AppBar(
                  elevation: 0.0,
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.restaurant_menu,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Food Recipe"),
                        SizedBox(
                          width: 90,
                        ),
                        Container(
                          width: 55,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.grey[200]),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45.0),
                                ))),
                            onPressed: () async {
                              Provider.of<SharedPreferencesHelper>(context,
                                      listen: false)
                                  .setTheme("light");
                              setState(() {});
                            },
                            child: Icon(
                              Icons.light_mode,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 55,
                          height: 50,
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black87),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45.0),
                                ))),
                            onPressed: () async {
                              Provider.of<SharedPreferencesHelper>(context,
                                      listen: false)
                                  .setTheme("dark");
                              setState(() {});
                            },
                            child: Icon(
                              Icons.dark_mode,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ])),
              body: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _recipes!.length,
                      itemBuilder: (context, index) {
                        return RecipeCard(
                            title: _recipes![index].name,
                            cookTime: _recipes![index].totalTime,
                            rating: _recipes![index].rating.toString(),
                            thumbnailUrl: _recipes![index].images);
                      })),
        );
      },
    );
  }
}
