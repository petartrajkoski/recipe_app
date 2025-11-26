import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';
import '../models/meal_detail.dart';


class MealDetailScreen extends StatefulWidget {
  final String id;
  const MealDetailScreen({required this.id, Key? key}) : super(key: key);


  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}


class _MealDetailScreenState extends State<MealDetailScreen> {
  final ApiService api = ApiService();
  MealDetail? meal;
  bool loading = true;


  @override
  void initState() {
    super.initState();
    load();
  }


  void load() async {
    meal = await api.fetchMealDetail(widget.id);
    setState(() => loading = false);
  }


  Future<void> openYoutube(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch \$url");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipe Detail")),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(meal!.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Ingredients", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...meal!.ingredients.map((i) => Text("• \$i")),
            SizedBox(height: 20),
            Text("Instructions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(meal!.instructions),
            if (meal!.ytLink.isNotEmpty) ...[
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => openYoutube(meal!.ytLink),
                child: Text("Watch on YouTube"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}