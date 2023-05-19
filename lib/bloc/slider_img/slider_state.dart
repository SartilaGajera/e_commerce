

import 'package:e_commerce/model/product/product_model.dart';
import 'package:e_commerce/model/slider/slider_model.dart';

abstract class SliderState {}

class SliderLoadingState extends SliderState {}

class SliderLoadedState extends SliderState {
  final List<SliderModel> images;
  SliderLoadedState(this.images);
}

class SliderErrorState extends SliderState {
  final String error;
  SliderErrorState(this.error);
}