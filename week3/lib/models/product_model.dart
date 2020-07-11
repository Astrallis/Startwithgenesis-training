import 'package:week3/models/review_model.dart';
import 'seller_model.dart';

class Product {
  String name;
  var price;
  var rating;
  String currency;
  var ratingCount;
  String description;
  List<String> imgUrl;
  Seller seller;
  List<String> tags;
  List<Review> reviews;

  Product(
      {String name,
      var price,
      var rating,
      String currency,
      var ratingCount,
      String description,
      List<String> imgUrl,
      Seller seller,
      List<String> tags,
      List<Review> reviews}) {
    this.name = name;
    this.price = price;
    this.rating = rating;
    this.ratingCount = ratingCount;
    this.description = description;
    this.imgUrl = imgUrl;
    this.seller = seller;
    this.tags = tags;
    this.reviews = reviews;
  }
}