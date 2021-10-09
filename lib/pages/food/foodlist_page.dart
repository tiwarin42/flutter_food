import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_item.dart';
import 'package:flutter_food/pages/food/food_detail.dart';

class FoodListPage extends StatefulWidget {
  static const routeName = '/foodlist';

  const FoodListPage({Key? key}) : super(key: key);

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  var items = [
    FoodItem(id: 1, name: 'ข้าวไข่เจียว', price: 20, image: 'kao_kai_jeaw.jpg'),
    FoodItem(id: 2, name: 'ข้าวหมูแดง', price: 25, image: 'kao_moo_dang.jpg'),
    FoodItem(id: 3, name: 'ข้าวมันไก่', price: 30, image: 'kao_mun_kai.jpg'),
    FoodItem(id: 4, name: 'ข้าวหน้าเป็ด', price: 30, image: 'kao_na_ped.jpg'),
    FoodItem(id: 5, name: 'ราดหน้า', price: 35, image: 'rad_na.jpg'),
    FoodItem(id: 6, name: 'ผัดไทย', price: 30, image: 'pad_thai.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  FoodDetail.routeName,
                  arguments: item,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/${item.image}',
                      width: 60.0,
                      height: 60.0,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      '${item.name} \n ${item.price} บาท',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
