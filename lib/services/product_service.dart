import 'package:flutter/services.dart' show rootBundle;
import 'package:excel/excel.dart';
import '../models/product.dart';

class ProductService {
  List<Product> _products = [];

  Future<void> loadProducts() async {
    final data = await rootBundle.load('assets/products.xlsx');
    final bytes = data.buffer.asUint8List();
    final excel = Excel.decodeBytes(bytes);

    final sheet = excel.tables.keys.first;
    final rows = excel.tables[sheet]?.rows ?? [];

    _products = rows.skip(1).map((row) => Product.fromExcel(row)).toList();
  }

  List<Product> recommendProducts(String keyword) {
    return _products
        .where((product) =>
            product.productName.contains(keyword) ||
            product.mainFunctions.contains(keyword) ||
            product.productSummary.contains(keyword))
        .toList();
  }
}
