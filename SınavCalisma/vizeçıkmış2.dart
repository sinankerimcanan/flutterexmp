import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginWidget(),
    );
  }
}

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';

  void _login() {
    if (_usernameController.text == 'Dash' &&
        _passwordController.text == '1234') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ItemListWidget(username: 'Dash'),
        ),
      );
    } else {
      setState(() {
        errorMessage = 'Login veya Password hatalı';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Screen")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Login'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text("Enter"),
            ),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}

class ItemListWidget extends StatefulWidget {
  final String username;

  ItemListWidget({required this.username});

  @override
  _ItemListWidgetState createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  final List<Map<String, dynamic>> items = [
    {'name': 'Laptop', 'price': 1000, 'selected': false},
    {'name': 'Phone', 'price': 500, 'selected': false},
    {'name': 'Headphones', 'price': 150, 'selected': false},
    {'name': 'Tablet', 'price': 300, 'selected': false},
    {'name': 'Watch', 'price': 200, 'selected': false},
  ];

  void _toggleItemSelection(int index) {
    setState(() {
      items[index]['selected'] = !items[index]['selected'];
    });
  }

  void _goToCart() {
    List<Map<String, dynamic>> selectedItems =
        items.where((item) => item['selected'] == true).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartWidget(selectedItems: selectedItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome, ${widget.username}")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    items[index]['name'],
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () => _toggleItemSelection(index),
                        child: Text("Add"),
                      ),
                      if (items[index]['selected'])
                        Icon(Icons.add, color: Colors.green),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _goToCart,
            child: Text("Cart"),
          ),
        ],
      ),
    );
  }
}

class CartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> selectedItems;

  CartWidget({required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    double total = selectedItems.fold(0, (sum, item) => sum + item['price']);

    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: selectedItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.amberAccent,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedItems[index]['name']),
                        Text("\$${selectedItems[index]['price']}"),
                      ],
                    ),
                  );
                },
              ),
            ),
            Text(
              "Total: \$${total.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text("Satın alınmıştır"),
                  ),
                );
              },
              child: Text("Buy"),
            ),
          ],
        ),
      ),
    );
  }
}
