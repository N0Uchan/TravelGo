import 'package:flutter/material.dart';
import 'package:travel_go/screens/search.dart';
import 'package:travel_go/screens/welcome.dart';

class TravelScreen extends StatefulWidget {
  const TravelScreen({super.key});

  @override
  State<TravelScreen> createState() {
    return _TravelScreenState();
  }
}

class _TravelScreenState extends State<TravelScreen> {
  void enterApp() {
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> const SearchScreen() ));
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeScreen(enterApp: enterApp),
    );
  }
}
