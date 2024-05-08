import 'package:flutter/material.dart';
import 'package:movie_api/Detail/detailProvider.dart';
import 'package:movie_api/Genre/genreProvider.dart';
import 'package:movie_api/Search/searchProvider.dart';
import 'package:movie_api/bottomnavbar.dart';
import 'package:movie_api/Home/homeProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => GenreProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => DetailProvider()),
      ],
      child: const MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,),
        scaffoldBackgroundColor: Color(0xFF03002e), 
        useMaterial3: true,
      ),
      home: const BottomnavbarScreen(),
    );
  }
}

