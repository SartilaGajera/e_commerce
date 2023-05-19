

import 'package:dio/dio.dart';
import 'package:e_commerce/bloc/product/product_state.dart';
import 'package:e_commerce/model/product/product_model.dart';
import 'package:e_commerce/repository/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super( ProductLoadingState() ) {
    fetchProducts();
  }

  ProductRepository productRepository = ProductRepository();

  void fetchProducts() async {
    try {
      List<ProductModel> posts = await productRepository.fetchProducts();
      emit(ProductLoadedState(posts));
    }
    on DioError catch(ex) {
      if(ex.type == DioErrorType.unknown) {
        emit( ProductErrorState("Can't fetch posts, please check your internet connection!") );
      }
      else {
        emit( ProductErrorState(ex.type.toString()) );
      }
    }
  }
}