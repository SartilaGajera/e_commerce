import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/bloc/slider_img/slider_cubit.dart';
import 'package:e_commerce/bloc/slider_img/slider_state.dart';
import 'package:e_commerce/model/slider/slider_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliderList extends StatefulWidget {
  const SliderList({super.key});

  @override
  State<SliderList> createState() => _SliderListState();
}

class _SliderListState extends State<SliderList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SliderCubit(),
      child: BlocConsumer<SliderCubit, SliderState>(
        listener: (context, state) {
          if (state is SliderErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is SliderLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xff800000),
              ),
            );
          }
          if (state is SliderLoadedState) {

            return buildPostListView(state.images);
          }
          return const Center(
            child: Text("An error occurred!"),
          );
        },
      ),
    );
  }

//  ProductModel post = products[index];

  Widget buildPostListView(List<SliderModel> imgs) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400.0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
      ),
      items: imgs.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                i.downloadUrl.toString(),
                fit: BoxFit.cover,
                loadingBuilder:
                    (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: const Color(0xff800000),
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            );
          },
        );
      }).toList(),
    );
    // ListView.builder(
    //   shrinkWrap: true,
    //   scrollDirection: Axis.horizontal,
    //   itemCount: imgs.length,
    //   itemBuilder: (BuildContext ctx, index) {
    //     SliderModel img = imgs[index];
    //     return Image.network(img.downloadUrl.toString(),fit: BoxFit.cover,);
    //   });
  }
}
