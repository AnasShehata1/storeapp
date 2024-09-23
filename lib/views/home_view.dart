import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeapp/models/product_model.dart';
import 'package:storeapp/views/add_product_view.dart';
import 'package:storeapp/views/cart_view.dart';
import '../constant.dart';
import '../widgets/custom_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const id = 'home view';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        centerTitle: true,
        title: const Text('Store App'),
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
          ),
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
      body: FutureBuilder<QuerySnapshot>(
        future: products.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductModel> productModelList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              productModelList.add(ProductModel.fromJson(
                  snapshot.data!.docs[i]['name'],
                  snapshot.data!.docs[i]['imageUrl'],
                  snapshot.data!.docs[i]['price']));
            }
            return RefreshIndicator(
              key: _refreshKey,
              onRefresh: _refreshData,
              child: GridView.builder(
                itemCount: productModelList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 70,
                  crossAxisSpacing: 10,
                ),
                padding: const EdgeInsets.only(top: 65, left: 12, right: 12),
                itemBuilder: (context, index) {
                  return CustomCard(productModel: productModelList[index]);
                },
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('There Was an ERROR!'),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            ));
          }
        },
      ),
    );
  }

  Future<void> _refreshData() async {
    setState(() {});
  }
}