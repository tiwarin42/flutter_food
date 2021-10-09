import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_item.dart';

class FoodDetail extends StatelessWidget {
  static const routeName = '/fooddetail';

  const FoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = ModalRoute.of(context)!.settings.arguments as FoodItem;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              child: Image.asset('assets/images/${item.image}')),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("ชื่อเมนู : ${item.name} \nราคา : ${item.price} บาท" ,style: TextStyle(fontSize: 25,color: Colors.black,)),
          ),
        ],
      ),
    );
  }
}
