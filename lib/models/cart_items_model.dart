import 'package:storeapp/models/product_model.dart';

abstract class CartItemsModel {
  static List<ProductModel> cartItemsList = []; 
  static void addToCart(ProductModel product) {
    cartItemsList.add(product);
  }
}
