// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:app_visit_pfe/widgets/main_page_widget.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Visit'),
      ),
      body: MainPageWidget(),
    );
  }
}
