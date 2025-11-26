import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';


class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}


class _CategoriesScreenState extends State<CategoriesScreen> {
  final ApiService api = ApiService();
  List<Category> categories = [];
  List<Category> filtered = [];
  bool loading = true;


  @override
  void initState() {
    super.initState();
    load();
  }


  void load() async {
    categories = await api.loadCategories();
    filtered = categories;
    setState(() => loading = false);
  }


  void search(String query) {
    setState(() {
      filtered = categories
          .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search categories...",
                border: OutlineInputBorder(),
              ),
              onChanged: search,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                return CategoryCard(category: filtered[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}