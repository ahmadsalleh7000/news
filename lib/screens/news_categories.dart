// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:news/widgets/app_bar.dart';
import 'package:news/widgets/app_drawer.dart';

class NewsCategories extends StatelessWidget {
  NewsCategories({super.key});
  List categoriesNames = ['General', 'Business', 'Entertainment', 'Health', 'Science', 'Sports', 'Technology'];
  List categoriesColors = [Colors.blue, Colors.red, Colors.green, Colors.pink, Colors.orange, Colors.yellow, Colors.cyan];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ApplicationBar(),
      drawer: const ApplicationDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0, bottom: 8.0, top: 16.0, right: 8.0),
                child: Text('Pick your category \nof interest',
                textAlign: TextAlign.left, 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                  itemCount: categoriesNames.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 7/ 8, 
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context, '/news',                          
                          arguments: {
                            'categoryIndex': categoriesNames[index]
                          },
                          );
                      },
                      child: Card(
                        color: categoriesColors[index],
                        margin: const EdgeInsets.all(8.0),
                        elevation: 4.0,
                        shape:  RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20.0), 
                            bottomRight: index % 2 == 0 ? const Radius.circular(20.0) : const Radius.circular(0.0), 
                            bottomLeft: index % 2 == 0 ? const Radius.circular(0.0) : const Radius.circular(20.0), 
                            topRight: const Radius.circular(20.0),),
                          side: const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Image.asset("assets/images/background_$index.png", 
                              height: MediaQuery.of(context).size.height * 0.15,
                              fit: BoxFit.contain),
                            ),
                            Text(categoriesNames[index], 
                            textAlign: TextAlign.center, 
                            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}