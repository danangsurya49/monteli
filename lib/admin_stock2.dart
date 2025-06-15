import 'package:flutter/material.dart';

class AdminStock2 extends StatefulWidget {
  const AdminStock2({super.key});

  @override
  State<AdminStock2> createState() => _AdminStock2State();
}

class _AdminStock2State extends State<AdminStock2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/Montelli_Family_Logo.png'),
          ),
        ),
        centerTitle: true,
        title: Text(
          'MontelliMart',
          style: TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              child: Icon(Icons.person, color: Colors.blueGrey),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              'Beverages',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  // Item 1
                  _buildBeverageItem(
                    image: 'assets/ultra_milk.png',
                    name: 'Ultra Milk Susu UHT Full Cream',
                    stock: 24,
                    price: 'Rp 7.900',
                    onRemove: () {},
                  ),
                  _buildBeverageItem(
                    image: 'assets/pucuk_harum.png',
                    name: 'Teh Pucuk Harum',
                    stock: 24,
                    price: 'Rp 7.900',
                  ),
                  _buildBeverageItem(
                    image: 'assets/yakult.png',
                    name: 'Yakult',
                    stock: 24,
                    price: 'Rp 7.900',
                  ),
                  _buildBeverageItem(
                    image: 'assets/goodday.png',
                    name: 'Goodday original Cappuchino',
                    stock: 24,
                    price: 'Rp 7.900',
                  ),
                  _buildBeverageItem(
                    image: 'assets/marjan.png',
                    name: 'Sirup Marjan rasa Melon',
                    stock: 24,
                    price: 'Rp 7.900',
                  ),
                  _buildBeverageItem(
                    image: 'assets/aqua.png',
                    name: 'Aqua Air Mineral',
                    stock: 24,
                    price: 'Rp 7.900',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBeverageItem({
    required String image,
    required String name,
    required int stock,
    required String price,
    VoidCallback? onRemove,
  }) {
    final TextEditingController stockController =
        TextEditingController(text: stock.toString());
    final TextEditingController priceController =
        TextEditingController(text: price);

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey.shade100),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image, width: 48, height: 48, fit: BoxFit.contain),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.blueGrey[900],
                        ),
                      ),
                    ),
                    if (onRemove != null)
                      IconButton(
                        icon: Icon(Icons.close, size: 18),
                        onPressed: onRemove,
                      ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Stock',
                            style:
                                TextStyle(fontSize: 12, color: Colors.blueGrey)),
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          width: 60,
                          height: 32,
                          child: TextField(
                            controller: stockController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Harga',
                            style:
                                TextStyle(fontSize: 12, color: Colors.blueGrey)),
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          width: 90,
                          height: 32,
                          child: TextField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}