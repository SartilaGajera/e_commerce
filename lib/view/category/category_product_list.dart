
import 'package:e_commerce/bloc/category/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/category/category_cubit.dart';
import '../../model/product/product_model.dart';

class CategoryProduct extends StatefulWidget {
  final type;
  const CategoryProduct({super.key, this.type});

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(      appBar: AppBar(backgroundColor: const Color(0xff800000),),

    body: BlocProvider(

      create: (context) => CategoryCubit(type:widget.type ),
      child:  BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          if (state is CategoryErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is CategoryLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xff800000),
              ),
            );
          }
          if (state is CategoryLoadedState) {
            return buildPostListView(state.categoryProduct);
          }
          return const Center(
            child: Text("An error occurred!"),
          );
        },
      ),

    ),);

  }

  Widget buildPostListView(List<ProductModel> products) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20),
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
