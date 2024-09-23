import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeapp/views/add_product_view.dart';
import 'package:storeapp/views/cart_view.dart';

import '../constant.dart';
import '../widgets/custom_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const id = 'home view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        centerTitle: true,
        title: const Text('New Trends'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                CartView.id,
              );
            },
            icon: const Icon(FontAwesomeIcons.cartPlus),
            color: Colors.black,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.pushNamed(context, AddProductView.id);
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
      body: GridView.builder(
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 70,
          crossAxisSpacing: 10,
        ),
        padding: const EdgeInsets.only(top: 65, left: 12, right: 12),
        itemBuilder: (context, index) {
          return const CustomCard();
        },
      ),
    );
  }
}
