import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ShoppingCart extends StatefulWidget {
  final List<CartItem> cartItems;

  ShoppingCart({required this.cartItems});

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart"),
      ),
      body: ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          var cartItem = widget.cartItems[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(cartItem.productName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Quantity: ${cartItem.quantity}"),
                  Text("Price: ${cartItem.price * cartItem.quantity}"),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (cartItem.quantity > 0) {
                          cartItem.quantity--;
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        cartItem.quantity++;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total: ${calculateTotalPrice()}"),
              ElevatedButton(
                onPressed: () {
                  // สามารถทำการชำระเงินหรือกระบวนการอื่นๆตามต้องการได้ที่นี่
                },
                child: Text("Checkout"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double calculateTotalPrice() {
    double total = 0.0;
    for (var cartItem in widget.cartItems) {
      total += cartItem.price * cartItem.quantity;
    }
    return total;
  }
}

class CartItem {
  final String productId;
  final String productName;
  final String imageUrl;
  final double price;
  int quantity;

  CartItem({
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
}
