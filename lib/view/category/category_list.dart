import 'package:dio/dio.dart';
import 'package:e_commerce/repository/api.dart';
import 'package:e_commerce/repository/api_repository.dart';
import 'package:flutter/material.dart';

import 'category_product_list.dart';
List categories = [];
class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  ProductRepository productRepository = ProductRepository();
  API api = API();


  @override
  void initState() {
    super.initState();
  }

  fetchCategories() async {
    try {
      Response response = await api.sendRequest.get("/products/categories");
      categories = response.data;
      setState(() {});
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    if(categories.isEmpty) {
      fetchCategories();
    }
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categories == null ? 0 : categories.length,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(onTap: (){
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => CategoryProduct(type: categories[index],)));
          },
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  decoration: BoxDecoration(border: Border.all(color:  const Color(0xff800000)),borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    '${categories[index]}'.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
