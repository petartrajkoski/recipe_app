import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_screen.dart';


class MealsScreen extends StatefulWidget {
  final String category;
  const MealsScreen({required this.category, Key? key}) : super(key: key);


  @override
  _MealsScreenState createState() => _MealsScreenState();
}


class _MealsScreenState extends State<MealsScreen> {
  final ApiService api = ApiService();
  List<Meal> meals = [];
  List<Meal> filtered = [];
  bool loading = true;


  @override
  void initState() {
    super.initState();
    load();
  }


  void load() async {
    meals = await api.loadMealByCategory(widget.category);
    filtered = meals;
    setState(() => loading = false);
  }


  void search(String query) {
    setState(() {
      filtered = meals
          .where((m) => m.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search meals...",
                border: OutlineInputBorder(),
              ),
              onChanged: search,
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MealDetailScreen(id: filtered[index].id),
                    ),
                  ),
                  child: MealCard(meal: filtered[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}