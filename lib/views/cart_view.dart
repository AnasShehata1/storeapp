import 'package:flutter/material.dart';
import 'package:storeapp/constant.dart';
import 'package:storeapp/models/cart_items_model.dart';
import 'package:storeapp/models/product_model.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});
  static const id = 'cart view';

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<int> quantities = [1, 1, 1, 1, 1, 1];
  double shipping = 10.0;
  List<ProductModel> productModelList = CartItemsModel.cartItemsList;
  double get subtotal {
    double sum = 0.0;
    for (int i = 0; i < productModelList.length; i++) {
      double? parsedValue = double.tryParse(productModelList[i].pirce);
      sum += quantities[i] * parsedValue!;
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
              itemCount: productModelList.length,
              itemBuilder: (context, index) {
                double? parsedValue =
                    double.tryParse(productModelList[index].pirce);
                return orderItem(
                    productModelList[index].name,
                    quantities[index],
                    parsedValue!,
                    index,
                    productModelList[index].imageUrl);
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

  Widget orderItem(
      String itemName, int quantity, double price, int index, String url) {
    return Card(
      color: kCartColor,
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
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
                      image: DecorationImage(
                          image: NetworkImage(
                            url,
                          ),
                          fit: BoxFit.fill)),
                ),
                const SizedBox(width: 10.0),
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
                  icon: const Icon(
                    Icons.remove,
                    size: 16,
                  ),
                ),
                Text('$quantity', style: const TextStyle(fontSize: 14.0)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      quantities[index]++;
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 16,
                  ),
                ),
                Text('\$${(price * quantity).toStringAsFixed(1)}',
                    style: const TextStyle(fontSize: 14.0)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      quantities.removeAt(index);
                      productModelList.removeAt(index);
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
          Text('\$${amount.toStringAsFixed(1)}',
              style: TextStyle(
                  fontSize: isTotal ? 18.0 : 16.0,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
