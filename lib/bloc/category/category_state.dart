

import 'package:e_commerce/model/product/product_model.dart';

abstract class CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final List<ProductModel> categoryProduct;
  CategoryLoadedState(this.categoryProduct);
}

class CategoryErrorState extends CategoryState {
  final String error;
  CategoryErrorState(this.error);
}