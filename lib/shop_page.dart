import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShopPage extends StatelessWidget {
  final int productId;

  const ShopPage({Key? key, required this.productId}) : super(key: key);

  Future<ProductDetails> fetchProductDetails() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products/$productId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ProductDetails.fromJson(data);
    } else {
      throw Exception('Failed to load product details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        backgroundColor: const Color.fromARGB(255, 246, 72, 72),
      ),
      body: FutureBuilder<ProductDetails>(
        future: fetchProductDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No product details available'));
          } else {
            final product = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            product.image,
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      product.description,
                      style: const TextStyle(
                          fontSize: 16.0, color: Colors.black87),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Category: ${product.category}',
                      style: const TextStyle(
                          fontSize: 16.0, color: Colors.black54),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Price: \$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Discount: ${product.discountPercentage.toStringAsFixed(2)}%',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Text(
                          'Rating:',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        const SizedBox(width: 8.0),
                        Icon(Icons.star, color: Colors.yellow[700]),
                        Text(
                          '${product.rating.toStringAsFixed(1)}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Stock: ${product.stock}',
                      style: const TextStyle(
                          fontSize: 16.0, color: Colors.black54),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Brand: ${product.brand}',
                      style: const TextStyle(
                          fontSize: 16.0, color: Colors.black54),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'SKU: ${product.sku}',
                      style: const TextStyle(
                          fontSize: 16.0, color: Colors.black54),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Weight: ${product.weight}g',
                      style: const TextStyle(
                          fontSize: 16.0, color: Colors.black54),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Dimensions: ${product.dimensions['width']?.toStringAsFixed(1)} x ${product.dimensions['height']?.toStringAsFixed(1)} x ${product.dimensions['depth']?.toStringAsFixed(1)} cm',
                      style: const TextStyle(
                          fontSize: 16.0, color: Colors.black54),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Warranty: ${product.warrantyInformation}',
                      style: const TextStyle(
                          fontSize: 16.0, color: Colors.black54),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Shipping: ${product.shippingInformation}',
                      style: const TextStyle(
                          fontSize: 16.0, color: Colors.black54),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Availability: ${product.availabilityStatus}',
                      style: const TextStyle(
                          fontSize: 16.0, color: Colors.black54),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Reviews:',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    for (var review in product.reviews)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rating: ${review['rating']}',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              Text(
                                'Comment: ${review['comment']}',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              Text(
                                'Reviewer: ${review['reviewerName']}',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              Text(
                                'Date: ${review['date']}',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // Handle add to cart functionality here
                      },
                      child: const Text('Add to Cart'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 5, 0, 12)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 50)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(38.0),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class ProductDetails {
  final String name;
  final String image;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final int weight;
  final Map<String, double> dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<Map<String, dynamic>> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final Map<String, dynamic> meta;

  ProductDetails({
    required this.name,
    required this.image,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      name: json['title'] as String? ?? 'Unknown',
      image: json['images'][0] as String? ??
          'https://via.placeholder.com/150', // Fallback image
      description: json['description'] as String? ?? 'No description available',
      category: json['category'] as String? ?? 'Unknown',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] as int? ?? 0,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      brand: json['brand'] as String? ?? 'Unknown',
      sku: json['sku'] as String? ?? 'Unknown',
      weight: json['weight'] as int? ?? 0,
      dimensions: (json['dimensions'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, (value as num).toDouble()),
      ),
      warrantyInformation:
          json['warrantyInformation'] as String? ?? 'No warranty information',
      shippingInformation:
          json['shippingInformation'] as String? ?? 'No shipping information',
      availabilityStatus: json['availabilityStatus'] as String? ?? 'Unknown',
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      returnPolicy: json['returnPolicy'] as String? ?? 'No return policy',
      minimumOrderQuantity: json['minimumOrderQuantity'] as int? ?? 1,
      meta: json['meta'] as Map<String, dynamic>? ?? {},
    );
  }
}
