import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping2/controller/home_screen_controller.dart';
import 'package:shopping2/view/productdetail/productdetails.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<HomeScreenController>().getcategories();
        await context.read<HomeScreenController>().getallproduct();
      },
    );
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Discover",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: [
          Stack(
            children: [
              Icon(
                Icons.notifications_none,
                size: 40,
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.black,
                  child: Text(
                    "1",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 10),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: Consumer<HomeScreenController>(
        builder: (context, homepro, child) => homepro.iscategoriesLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Search anything",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                      fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.filter_list,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List.generate(
                        homepro.categoriesList.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              context
                                  .read<HomeScreenController>()
                                  .oncategoryselection(index);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 40,
                              decoration: BoxDecoration(
                                  color: index == homepro.selectedcategoryIndex
                                      ? Colors.black
                                      : Colors.grey.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  homepro.categoriesList[index]
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color:
                                          index == homepro.selectedcategoryIndex
                                              ? Colors.white
                                              : Colors.black),
                                ),
                              )
                            ),
                          ),
                        ),
                      )),
                    ),
                  ),
                  homepro.isproductLoading
                      ? Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: GridView.builder(
                            itemCount: homepro.productsList.length,
                            padding: EdgeInsets.all(10),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 230,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetails(
                                            title: homepro.productsList[index]
                                                    .title ??
                                                "",
                                            img: homepro.productsList[index]
                                                    .image ??
                                                "",
                                            des: homepro.productsList[index]
                                                    .description ??
                                                "",
                                            price: homepro.productsList[index]
                                                    .price ??
                                                0)));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(children: [
                                    Container(
                                        height: 180,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                homepro
                                                    .productsList[index].image
                                                    .toString(),
                                              )),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.shade400,
                                        )),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Container(
                                        child: Icon(
                                          Icons.favorite_outline,
                                          color: Colors.black,
                                        ),
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ]),
                                  Text(
                                    maxLines: 1,
                                    homepro.productsList[index].title
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                      homepro.productsList[index].price
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black))
                                ],
                              ),
                            ),
                          ),
                        )
                ],
              ),
      ),
    );
  }
}
