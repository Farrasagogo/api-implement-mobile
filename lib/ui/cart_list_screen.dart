import 'package:flutter/material.dart';
import '../models/cart.dart';
import 'cart_detail_screen.dart';

class CartListScreen extends StatelessWidget {
  final List<Cart> carts;

  CartListScreen({required this.carts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Carts'),
      ),
      body: ListView.builder(
        itemCount: carts.length,
        itemBuilder: (context, index) {
          final cart = carts[index];
          return ListTile(
            title: Text('Cart #${cart.id}'),
            subtitle: Text('Total Products: ${cart.totalProducts}'),
            trailing: Text('\$${cart.discountedTotal.toStringAsFixed(2)}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartDetailScreen(cart: cart),
                ),
              );
            },
          );
        },
      ),
    );
  }
}