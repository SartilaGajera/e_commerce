

import 'package:dio/dio.dart';
import 'package:e_commerce/bloc/product/product_state.dart';
import 'package:e_commerce/bloc/slider_img/slider_state.dart';
import 'package:e_commerce/model/product/product_model.dart';
import 'package:e_commerce/model/slider/slider_model.dart';
import 'package:e_commerce/repository/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super( SliderLoadingState() ) {
fetchImages() ; }

  ProductRepository productRepository = ProductRepository();

  void fetchImages() async {
    try {
      List<SliderModel> images = await productRepository.fetchSliderImages();
      emit(SliderLoadedState(images));
    }
    on DioError catch(ex) {
      if(ex.type == DioErrorType.unknown) {
        emit( SliderErrorState("Can't fetch posts, please check your internet connection!") );
      }
      else {
        emit( SliderErrorState(ex.type.toString()) );
      }
    }
  }
}