import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview/controller/search_controller.dart';
import 'package:interview/main.dart';
import 'package:interview/model/api_helper.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:interview/view/loginpage.dart';

import '../db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SearchProductController controller = Get.put(SearchProductController());

  @override
  void initState() {
    ApiHelper().getApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () async{
                prefs.setBool('isLogin', false);
                await DbHelper().logOutUser();
                Get.offAll(LoginPage());
              },
              icon: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) => controller.sProduct(value),
              decoration: InputDecoration(
                  hintText: "Search Product",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  suffixIcon: Icon(Icons.search)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.searchList.length,
                itemBuilder: (context, index) {
                  var data = controller.searchList[index];
                  return Stack(
                    children: [
                      Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${data.id}  ",
                                ),
                                Text(
                                  data.title.toString(),
                                ),
                              ],
                            ),
                            Text(
                                "discountPercentage: ${data.discountPercentage}"),
                            Text("Price: ${data.price}"),
                            Text("Stock: ${data.stock}"),
                            Text("Brand: ${data.brand}"),
                            Text("Category: ${data.category}"),
                            Text("Thumbnail: "),
                            Container(
                              margin: EdgeInsets.only(left: 50),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.15,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    data.thumbnail.toString(),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text("Rating: "),
                                RatingBar.builder(
                                  // Add this widget
                                  initialRating: data.rating!.toDouble(),
                                  // Assuming you have a rating value in your data model
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ],
                            ),
                            Text(
                              "description: ${data.description}",
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Row(
                          children: [
                            ValueBuilder<bool?>(
                              initialValue: data.isLike ?? false,
                              builder: (snapshot, updater) {
                                return IconButton(
                                  onPressed: () {
                                    data.isLike = !(data.isLike ?? false);
                                    updater(true);
                                  },
                                  icon: data.isLike == true
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : Icon(Icons.favorite_border),
                                );
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                deleteProduct(
                                    index); // Call deleteProduct method from controller
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void deleteProduct(int index) {
    controller.searchList.removeAt(index);
  }
}
