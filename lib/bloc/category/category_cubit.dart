

import 'package:dio/dio.dart';
import 'package:e_commerce/bloc/product/product_state.dart';
import 'package:e_commerce/bloc/slider_img/slider_state.dart';
import 'package:e_commerce/model/product/product_model.dart';
import 'package:e_commerce/model/slider/slider_model.dart';
import 'package:e_commerce/repository/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({type}) : super( CategoryLoadingState() ) {
    fetchCategoryProducts(type: type) ; }

  ProductRepository productRepository = ProductRepository();

  void fetchCategoryProducts({type}) async {
    try {
      List<ProductModel> images = await productRepository.fetchCategoryProducts(type: type);
      emit(CategoryLoadedState(images));
    }
    on DioError catch(ex) {
      if(ex.type == DioErrorType.unknown) {
        emit( CategoryErrorState("Can't fetch posts, please check your internet connection!") );
      }
      else {
        emit( CategoryErrorState(ex.type.toString()) );
      }
    }
  }
}