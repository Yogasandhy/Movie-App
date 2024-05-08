import 'package:flutter/material.dart';
import 'package:movie_api/Home/HomeScreen.dart';
import 'package:movie_api/MeScreen.dart';
import 'package:movie_api/SaveScreen.dart';
import 'package:movie_api/Search/searchScreen.dart';
import 'package:movie_api/DownloadScreen.dart';

class BottomnavbarScreen extends StatefulWidget {
  const BottomnavbarScreen({Key? key}) : super(key: key);

  @override
  _BottomnavbarScreenState createState() => _BottomnavbarScreenState();
}

class _BottomnavbarScreenState extends State<BottomnavbarScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SearchScreen(),
    SaveScreen(),
    DownloadScreen(),
    MeScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar:   NavigationBarTheme(
    data: NavigationBarThemeData(
      labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
        (Set<MaterialState> states) => states.contains(MaterialState.selected)
            ? const TextStyle(color: Colors.red)
            : const TextStyle(color: Colors.grey),
      ),
    ), child: NavigationBar(
        backgroundColor: Color(0xFF31304D),
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        indicatorColor: Colors.red,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Colors.grey,size: 30.0,),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined, color: Colors.grey,size: 30.0,),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.save_outlined, color: Colors.grey,size: 30.0,),
            selectedIcon: Icon(Icons.save),
            label: 'Save',
          ),
          NavigationDestination(
            icon: Icon(Icons.download_outlined, color: Colors.grey,size: 30.0,),
            selectedIcon: Icon(Icons.download),
            label: 'Download',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined, color: Colors.grey,size: 30.0,),
            selectedIcon: Icon(Icons.account_circle),
            label: 'Me',
          ),
        ],
      ),) 
    );
  }
}
