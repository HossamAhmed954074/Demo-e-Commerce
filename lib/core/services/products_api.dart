import 'dart:convert';

import 'package:demo_ecommerce/core/models/products/categorie_model.dart';
import 'package:demo_ecommerce/core/models/products/product.dart';
import 'package:demo_ecommerce/core/secrets/secrets.dart';
import 'package:http/http.dart' as http;

class ProductsApi {

  // get all Categories
  Future<List<Category>> getAllCategories() async {
    try {
      final response = await http.get(Uri.parse(Secrets.categoriesUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  // get products by category
  Future<List<Product>> getProductsByCategory(int categoryId) async {
    try {
      final response = await http.get(Uri.parse('${Secrets.productsUrl}$categoryId'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  // get shuffled product for home
  Future<List<Product>> getShuffledProducts() async {
    try {
      final response = await http.get(Uri.parse(Secrets.shuffledProductsUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<Product> products = data.map((json) => Product.fromJson(json)).toList();
        products.shuffle(); // Shuffle the list of products
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

}