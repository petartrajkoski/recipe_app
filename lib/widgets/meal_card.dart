import 'package:flutter/material.dart';
import '../models/meal.dart';


class MealCard extends StatelessWidget {
  final Meal meal;
  const MealCard({required this.meal});


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: Image.network(meal.thumbnail, fit: BoxFit.cover, width: double.infinity),
          ),
          Padding(
            padding: EdgeInsets.all(6),
            child: Text(meal.name, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }
}