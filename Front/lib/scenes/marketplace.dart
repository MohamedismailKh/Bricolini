import 'package:bricoloni_v2/scenes/VR.dart';
import 'package:flutter/material.dart';

class Product {
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class MarketPlace extends StatelessWidget {
  MarketPlace({super.key});
  final List<Product> products = [
    Product(
        title: 'Dining table with chairs',
        description: 'Made With Recycled Wood',
        price: 19.99,
        imageUrl: 'lib/images/product1.jpeg'),
    Product(
        title: 'Stool',
        description: 'Made With Recycled Wood',
        price: 29.99,
        imageUrl: 'lib/images/product2.jpeg'),
    Product(
        title: 'Dining table with chairs',
        description: 'Made With Recycled Wood',
        price: 39.99,
        imageUrl: 'lib/images/product3.jpeg'),
    Product(
        title: 'Stool',
        description: 'Made With Recycled Iron',
        price: 49.99,
        imageUrl: 'lib/images/product4.jpeg'),
    Product(
        title: 'Dining table with chairs',
        description: 'Made With Recycled Iron',
        price: 59.99,
        imageUrl: 'lib/images/product5.jpeg'),
    Product(
        title: 'Stool',
        description: 'Made With Recycled Bricks',
        price: 69.99,
        imageUrl: 'lib/images/product6.jpeg'),
    Product(
        title: 'Garden Bench',
        description: 'Made With Recycled Bricks',
        price: 79.99,
        imageUrl: 'lib/images/product7.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green,
              Colors.black,
            ],
          ),
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.transparent,
              margin: const EdgeInsets.all(10),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey,
                      Colors.black,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 100,
                      child: Image.asset(products[index].imageUrl),
                    ),
                    Text(
                      products[index].title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      products[index].description.length > 50
                          ? products[index].description.substring(0, 50) + '...'
                          : products[index].description,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 2,
                    ),
                    Text(
                      '\$${products[index].price.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.green),
                    ),
                    IconButton(
                      onPressed: () {
                        print('${products[index].title} added to cart');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('${products[index].title} added to cart'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.view_in_ar),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MarketplaceVRPage()),
          );
        },
      ),
    );
  }
}
