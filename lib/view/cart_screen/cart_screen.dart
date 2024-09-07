import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "cart",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.delete))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://images.pexels.com/photos/28173267/pexels-photo-28173267/free-photo-of-new-york-city-skyline-glowing-sunset.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load"))),
                              ),
                              Spacer(),
                              ElevatedButton(
                                  onPressed: () {}, child: Icon(Icons.add)),
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () {}, child: Icon(Icons.remove)),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)),
                              width: double.infinity,
                              height: 30,
                              child: Center(child: Text("Delete")),
                            ),
                          )
                        ],
                      ),
                      height: 200,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                itemCount: 3),
          ],
        ),
      ),
    );
  }
}
