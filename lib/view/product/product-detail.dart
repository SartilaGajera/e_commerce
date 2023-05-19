import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final productImg;
  final productName;
  final productDesc;
  final productPrice;
  final productCategory;
  const ProductDetail({Key? key, this.productImg, this.productName, this.productDesc, this.productPrice, this.productCategory,}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xff800000),

      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        children: [
         Image.network(widget.productImg.toString(), loadingBuilder:
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
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Text(widget.productName.toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xff800000)))),
            Text('\$${widget.productPrice.toString()}',style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black)),
          ],
        ), const SizedBox(height: 5),
          Text(widget.productCategory.toString().capitalize(),style: const TextStyle(fontSize: 14,color: Color(0xff800000))),
          const SizedBox(height: 5),
          Text(widget.productDesc.toString(),style: const TextStyle(fontSize: 15,color: Colors.black)),
       
      ],),
    );
  }
}
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}