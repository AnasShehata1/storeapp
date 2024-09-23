import 'package:flutter/material.dart';
import 'package:storeapp/constant.dart';
import 'package:storeapp/models/cart_items_model.dart';
import 'package:storeapp/models/product_model.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 60,
              color: Colors.grey.withOpacity(0.1),
              offset: const Offset(1, 1),
              spreadRadius: 0,
            ),
          ]),
          child: Card(
            elevation: 10,
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.name,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${productModel.pirce}',
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () {
                          if (!CartItemsModel.cartItemsList
                              .contains(productModel)) {
                            CartItemsModel.addToCart(productModel);
                          }
                        },
                        icon: Icon(
                          Icons.add,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 20,
          top: -60,
          child: Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: NetworkImage(productModel.imageUrl),
                    fit: BoxFit.fill)),
          ),
        )
      ],
    );
  }
}
