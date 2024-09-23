class ProductModel {
  final String name;
  final String imageUrl;
  final String pirce;

  ProductModel(
      {required this.name, required this.imageUrl, required this.pirce});
  factory ProductModel.fromJson(name, imageUrl, price) {
    return ProductModel(
      name: name,
      imageUrl: imageUrl,
      pirce: price,
    );
  }
}
