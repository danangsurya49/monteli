import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class UserCart extends StatefulWidget {
  const UserCart({super.key});

  @override
  State<UserCart> createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  final box = GetStorage();
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  void loadCart() {
    final stored = box.read('cart') ?? [];
    setState(() {
      cartItems = List<Map<String, dynamic>>.from(stored);
    });
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
    box.write('cart', cartItems);
    setState(() {});
  }

  void increaseQty(int index) {
    setState(() {
      cartItems[index]['qty'] = (cartItems[index]['qty'] ?? 1) + 1;
      box.write('cart', cartItems);
    });
  }
  void decreaseQty(int index) {
    setState(() {
      if ((cartItems[index]['qty'] ?? 1) > 1) {
        cartItems[index]['qty'] = cartItems[index]['qty'] - 1;
        box.write('cart', cartItems);
      }
    });
  }
  num get totalPrice {
    num total = 0;
    for (var item in cartItems) {
      final price = num.tryParse(item['price'].toString().replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
      final qty = item['qty'] ?? 1;
      total += price * qty;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: cartItems.isEmpty
          ? const Center(child: Text('Cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, idx) {
                      final item = cartItems[idx];
                      return ListTile(
                        leading: item['image'] != null && item['image'].toString().isNotEmpty
                            ? Image.network(item['image'], width: 48, height: 48)
                            : const Icon(Icons.image, size: 48),
                        title: Text(item['name'] ?? ''),
                        subtitle: Text(item['price'] ?? ''),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => decreaseQty(idx),
                            ),
                            Text('${item['qty'] ?? 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => increaseQty(idx),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => removeItem(idx),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('Rp ${totalPrice}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}