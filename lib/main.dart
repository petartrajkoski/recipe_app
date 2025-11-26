import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'screens/categories_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'services/api_service.dart';
import 'models/meal_detail.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(600, 1000),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(MealApp());
}


class MealApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal Recipes',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomeWrapper(),
    );
  }
}


class HomeWrapper extends StatefulWidget {
  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}


class _HomeWrapperState extends State<HomeWrapper> {
  final ApiService api = ApiService();


  void openRandomRecipe() async {
    final MealDetail meal = await api.loadRandomMeal();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MealDetailScreen(id: meal.id),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CategoriesScreen(),
          ),
          GestureDetector(
            onTap: openRandomRecipe,
            child: Container(
              width: double.infinity,
              color: Colors.orange,
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  'Random Meal',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}