
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';

class CartList extends StatefulWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  double total=0;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child:cartData.isNotEmpty? ListView.builder(
                itemCount: cartData.length,
                itemBuilder: (context, index) {

                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    decoration:
                        BoxDecoration(color: Colors.white,border: Border.all(color:  const Color(0xff800000)), borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 100,
                            decoration: const BoxDecoration(


                            ),
                            child:   Image.network(cartData[index].image.toString(),fit: BoxFit.cover, loadingBuilder:
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
                            },),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cartData[index].title.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 14)),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "\$${cartData[index].price}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }):const Center(child: Text("No item in cart",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xff800000)),),)),
        cartData.isNotEmpty? Container(
          color: const Color(0xff800000).withOpacity(0.8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Cart Item",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      "${cartData.length}",
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Cart Price",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      "\$${cartData.fold<double>(0, (a, b) => a+b.price)}",
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ):const SizedBox()
      ],
    );
  }
}
