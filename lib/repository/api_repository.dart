
import 'package:dio/dio.dart';
import 'package:e_commerce/model/product/product_model.dart';
import 'package:e_commerce/model/slider/slider_model.dart';

import 'api.dart';

class ProductRepository {
  API api = API();

  Future<List<ProductModel>> fetchProducts() async {
    try {
      Response response = await api.sendRequest.get("/products");
      List<dynamic> productMaps = response.data;
      return productMaps.map((postMap) => ProductModel.fromJson(postMap)).toList();
    }
    catch (ex) {
      rethrow;
    }
  }
  Future<List<ProductModel>> fetchCategoryProducts({type}) async {
    try {
      Response response = await api.sendRequest.get("/products/category/$type");
      List<dynamic> productMaps = response.data;
      return productMaps.map((postMap) => ProductModel.fromJson(postMap)).toList();
    }
    catch (ex) {
      rethrow;
    }
  }
  Future<List<SliderModel>> fetchSliderImages() async {
    try {
      Response response = await Dio().get("https://picsum.photos/v2/list");
      List<dynamic> imgMaps = response.data;
      return imgMaps.map((e) => SliderModel.fromJson(e)).toList();
    }
    catch (ex) {
      rethrow;
    }
  }



}