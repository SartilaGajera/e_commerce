import 'package:e_commerce/bloc/product/product_cubit.dart';
import 'package:e_commerce/view/product/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(

        create: (context) => ProductCubit(),
        child: const ProductList(),

    );
  }
}
