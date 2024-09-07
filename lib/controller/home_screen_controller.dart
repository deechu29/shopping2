import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping2/model/home_screen/product_model.dart';

class HomeScreenController with ChangeNotifier {
  bool iscategoriesLoading =
      false; // for  setting loading state while fetching categories list
  bool isproductLoading =
      false; // // for  setting loading state while fetching product list
  List categoriesList = ["ALL"];
  List allproductList = [];
  int selectedcategoryIndex = 0;
//function to fetch categories from server
  List<ProductModel> productsList = [];
  getcategories() async {
    iscategoriesLoading = true;
    notifyListeners();
    try {
      final url = Uri.parse("https://fakestoreapi.com/products/categories");
      final res = await http.get(url);
      if (res.statusCode == 200) {
        print(res.body);
        categoriesList.addAll(jsonDecode(res.body));
      }
    } catch (e) {
      print(e);
    }
    iscategoriesLoading = false;
    notifyListeners();
  }

  //to fetch all products from server
  getallproduct({String category = ""}) async {
    isproductLoading = true;
    notifyListeners();
    final allurl = Uri.parse("https://fakestoreapi.com/products");
    final Categoryurl =
        Uri.parse("https://fakestoreapi.com/products/$category");
    final url = category.isEmpty ? allurl : Categoryurl;

    final res = await http.get(url);

    if (res.statusCode == 200) {
      productsList = productModelFromJson(res.body);
    }
    iscategoriesLoading = false;
    notifyListeners();
  }

  oncategoryselection(int index) {
    selectedcategoryIndex = index;
    if (selectedcategoryIndex == index) {
      getallproduct();
    } else {
      getallproduct(category: categoriesList[selectedcategoryIndex]);
    }

    notifyListeners();
  }

  productlistbycategeries() {}
}
