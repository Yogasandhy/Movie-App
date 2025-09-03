import 'package:flutter/material.dart';
import 'package:movie_api/presentation/widgets/bottom_navigation_bar.dart';
import 'package:movie_api/core/di/injection_container.dart' as di;
import 'package:movie_api/presentation/providers/detail_provider.dart';
import 'package:movie_api/presentation/providers/genre_provider.dart';
import 'package:movie_api/presentation/providers/search_provider.dart';
import 'package:movie_api/presentation/providers/home_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<HomeProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<GenreProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<SearchProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<DetailProvider>()),
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
        scaffoldBackgroundColor: const Color(0xFF03002e), 
        useMaterial3: true,
      ),
      home: const BottomnavbarScreen(),
    );
  }
}

