import 'package:flutter/material.dart';
import 'package:storeapp/constant.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});
  static const id = 'cart view';

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<int> quantities = [4, 2, 1, 5];
  List<double> prices = [20.0, 6.0, 49.0, 15.0];
  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  double shipping = 10.0;

  double get subtotal {
    double sum = 0.0;
    for (int i = 0; i < quantities.length; i++) {
      sum += quantities[i] * prices[i];
    }
    return sum;
  }

  double get total => subtotal + shipping;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Order'),
        centerTitle: true,
        backgroundColor: kBackgroundColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return orderItem(
                    items[index], quantities[index], prices[index], index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                summaryRow('Subtotal', subtotal),
                summaryRow('Shipping', shipping),
                summaryRow('Total', total, isTotal: true),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'PROCEED TO CHECKOUT',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget orderItem(String itemName, int quantity, double price, int index) {
    return Card(
      color: kCartColor,
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/logo.png',
                          ),
                          fit: BoxFit.fill)),
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(itemName, style: const TextStyle(fontSize: 16.0)),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (quantities[index] > 1) {
                        quantities[index]--;
                      }
                    });
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text('$quantity', style: const TextStyle(fontSize: 16.0)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      quantities[index]++;
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
                const SizedBox(width: 8.0),
                Text('\$${(price * quantity).toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16.0)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      items.removeAt(index);
                      quantities.removeAt(index);
                      prices.removeAt(index);
                    });
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: isTotal ? 18.0 : 16.0,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text('\$${amount.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: isTotal ? 18.0 : 16.0,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
