import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/cart.dart';
import 'ui/cart_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<List<Cart>>(
        future: fetchCarts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CartListScreen(carts: snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

 Future<List<Cart>> fetchCarts() async {
  try {
    final response = await http.get(Uri.parse('https://dummyjson.com/carts'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final carts = jsonData['carts'] as List;
      return carts.map((cart) => Cart.fromJson(cart)).toList();
    } else {
      throw Exception('Failed to load carts (${response.statusCode})');
    }
  } catch (e) {
     if (e is FormatException) {
      throw Exception('Invalid response format');
    } else {
      throw Exception('Unknown error occurred: $e');
    }
  }
}
}