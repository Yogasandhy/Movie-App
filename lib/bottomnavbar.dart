import 'package:flutter/material.dart';
import 'package:movie_api/Home/HomeScreen.dart';
import 'package:movie_api/MeScreen.dart';
import 'package:movie_api/SaveScreen.dart';

class BottomnavbarScreen extends StatefulWidget {
  const BottomnavbarScreen({super.key});

  @override
  _BottomnavbarScreenState createState() => _BottomnavbarScreenState();
}

class _BottomnavbarScreenState extends State<BottomnavbarScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const SaveScreen(),
    const MeScreen(),
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
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: const Color(0xFF31304D),
            elevation: 8, // Built-in elevation instead of custom shadow
            indicatorColor: Colors.transparent, // Remove built-in indicator shadow
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
              (Set<WidgetState> states) => states.contains(WidgetState.selected)
                  ? const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    )
                  : const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
            ),
          ),
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            height: 70,
            destinations: [
              NavigationDestination(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 0 
                        ? Colors.red.withValues(alpha: 0.15) 
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                    color: _selectedIndex == 0 ? Colors.red : Colors.grey,
                    size: 28,
                  ),
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 1 
                        ? Colors.red.withValues(alpha: 0.15) 
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _selectedIndex == 1 ? Icons.bookmark : Icons.bookmark_outline,
                    color: _selectedIndex == 1 ? Colors.red : Colors.grey,
                    size: 28,
                  ),
                ),
                label: 'Saved',
              ),
              NavigationDestination(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 2 
                        ? Colors.red.withValues(alpha: 0.15) 
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _selectedIndex == 2 ? Icons.person : Icons.person_outline,
                    color: _selectedIndex == 2 ? Colors.red : Colors.grey,
                    size: 28,
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
