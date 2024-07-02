import 'package:excel/excel.dart';

class Product {
  final String companyName;
  final String companyAddress;
  final String contactPhone;
  final String companyWebsite;
  final String productName;
  final String mainFunctions;
  final String howToUse;
  final String productSummary;

  Product({
    required this.companyName,
    required this.companyAddress,
    required this.contactPhone,
    required this.companyWebsite,
    required this.productName,
    required this.mainFunctions,
    required this.howToUse,
    required this.productSummary,
  });

  factory Product.fromExcel(List<Data?> row) {
    return Product(
      companyName: row[0]?.value.toString() ?? '',
      companyAddress: row[1]?.value.toString() ?? '',
      contactPhone: row[2]?.value.toString() ?? '',
      companyWebsite: row[3]?.value.toString() ?? '',
      productName: row[4]?.value.toString() ?? '',
      mainFunctions: row[5]?.value.toString() ?? '',
      howToUse: row[6]?.value.toString() ?? '',
      productSummary: row[7]?.value.toString() ?? '',
    );
  }
}
