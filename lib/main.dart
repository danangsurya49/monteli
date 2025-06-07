import 'package:flutter/material.dart';
import 'package:montelimart/user.dart';
import 'admin_home.dart';
import 'package:montelimart/user_detail_produk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: userscreen(),
    );
  }
}
