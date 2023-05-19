import 'dart:convert';

import 'package:e_commerce/bloc/product/product_cubit.dart';
import 'package:e_commerce/bloc/product/product_state.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/model/product/product_model.dart';
import 'package:e_commerce/view/product/product-detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductErrorState) {
          SnackBar snackBar = SnackBar(
            content: Text(state.error),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff800000),
            ),
          );
        }
        if (state is ProductLoadedState) {
          return buildPostListView(state.products);
        }
        return const Center(
          child: Text("An error occurred!"),
        );
      },
    );
  }

//  ProductModel post = products[index];

  Widget buildPostListView(List<ProductModel> products) {
    return GridView.builder(
        cacheExtent: 100000,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemCount: products.length,
        itemBuilder: (BuildContext ctx, index) {
          ProductModel post = products[index];
          return GestureDetector(onTap: (){
            Navigator.push(
                context, MaterialPageRoute(builder: (_) =>  ProductDetail(productImg: post.image,productName: post.title,productCategory: post.category,productDesc: post.description,productPrice: post.price,)));
          },
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(post.image.toString()),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.low,)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {

                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                List<ProductModel>  cartItems=[];
                                cartItems=cartData;


                                if (cartData!=null&& cartData.isNotEmpty) {

                                    if (cartItems.map((item) => item.id).contains(post.id)){
                                    } else {

                                      String user = jsonEncode(post);
                                      await sharedPreferences.setString('persons', user);

                                      Map<String, dynamic> jsondatais =
                                          jsonDecode(sharedPreferences.getString('persons')!);


                                      cartData.add(ProductModel.fromJson(jsondatais));
                                    }
                                 //}
                                } else {
                                  String user = jsonEncode(post);
                                  await sharedPreferences.setString('persons', user);
                                  Map<String, dynamic> jsondatais =
                                      jsonDecode(sharedPreferences.getString('persons')!);

                                  //convert it into User object
                                  cartData.add(ProductModel.fromJson(jsondatais));
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 15, top: 10),
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                    color: Color(0xff800000), shape: BoxShape.circle),
                                child: const Icon(Icons.shopping_cart_checkout,
                                    size: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.title.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14)),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "\$${post.price.toString()}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.green[700],
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${post.rating?.rate.toString()}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                        const Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 15,
                                        )
                                      ],
                                    )),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text("(${post.rating!.count})")
                              ],
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }
}
