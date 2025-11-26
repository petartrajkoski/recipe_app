import 'package:flutter/material.dart';
import '../models/category.dart';
import '../screens/meals_screen.dart';


class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({required this.category});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MealsScreen(category: category.name),
        ),
      ),
      child: Card(
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Image.network(category.thumbnail, width: 100, height: 100, fit: BoxFit.cover),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(category.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(category.desc, maxLines: 3, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}