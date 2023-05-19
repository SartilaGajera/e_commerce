

import 'package:e_commerce/model/product/product_model.dart';

abstract class ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<ProductModel> products;
  ProductLoadedState(this.products);
}

class ProductErrorState extends ProductState {
  final String error;
  ProductErrorState(this.error);
}