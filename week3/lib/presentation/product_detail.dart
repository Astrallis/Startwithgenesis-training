import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:week3/models/product_model.dart';
import 'package:week3/models/review_model.dart';
import 'package:week3/models/seller_model.dart';
import 'package:week3/presentation/checkout_screen.dart';
import 'package:week3/shared/bottom_bar.dart';

class ProductDetail extends StatefulWidget {
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool _isLoading;
  Product product;
  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("assets/product.json");
  }

  Future parseJson() async {
    String jsonString = await _loadFromAsset();
    final result = jsonDecode(jsonString);
    print(result);
    setState(() {
      List<String> imgUrl = new List<String>();
      for (int j = 0; j < result['data']['product'][0]['Images'].length; j++)
        imgUrl.add(result['data']['product'][0]['Images'][j]['url']);

      List<String> tags = new List<String>();
      for (int j = 0;
          j < result['data']['product'][0]['product_tags'].length;
          j++)
        tags.add(result['data']['product'][0]['product_tags'][0]['tag']['tag']);

      List<Review> reviews = new List<Review>();
      for (int j = 0; j < result['data']['product'][0]['reviews'].length; j++)
        reviews.add(
          Review(
              name: result['data']['product'][0]['reviews'][j]['name'],
              url: result['data']['product'][0]['reviews'][j]['profile_url'],
              rating: result['data']['product'][0]['reviews'][j]['rating'],
              review: result['data']['product'][0]['reviews'][j]['review'],
              timestamp: result['data']['product'][0]['reviews'][j]
                  ['timestamp']),
        );

      Seller seller = new Seller(
        name: result['data']['product'][0]['Seller']['Name'],
        ratingCount: result['data']['product'][0]['Seller']['rating_count'],
        sellerRating: result['data']['product'][0]['Seller']['seller_rating'],
        sellerImg: result['data']['product'][0]['Seller']['seller_profile'],
      );

      if (imgUrl.isEmpty)
        imgUrl.add(
            "https://panty.com/templates/vldthemes_simple_2/images/nopicture_f.jpg");

      product = Product(
          imgUrl: imgUrl,
          seller: seller,
          tags: tags,
          reviews: reviews,
          currency: result['data']['product'][0]['currency'],
          name: result['data']['product'][0]['name'],
          price: result['data']['product'][0]['price'],
          rating: result['data']['product'][0]['rating'],
          ratingCount: result['data']['product'][0]['ratingCount'],
          description: result['data']['product'][0]['description']);
    });
  }

  @override
  void initState() {
    _isLoading = true;
    parseJson().then((value) => setState(() {
          _isLoading = false;
        })); // TODO: implement initState
    super.initState();
  }

  _circleElement(IconData icon) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]),
      child: Icon(icon),
    );
  }

  _reviewElement(Review review) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(review.url)),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                    )
                  ]),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 14,
                    ),
                    itemCount: review.rating.floor(),
                  ),
                ),
                Text(
                  "From ${review.name}",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  width: 200,
                  child: Text(
                    review.review,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            // Text(review.timestamp.substring(5, 10))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CupertinoActivityIndicator(
              radius: 20,
            ),
          )
        : SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  Align(
                    alignment: Alignment(0, -1),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 2 + 20,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Stack(
                                children: [
                                  PageView.builder(
                                      itemBuilder: (context, index) =>
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 4,
                                                    offset: Offset(0, 4))
                                              ],
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  product.imgUrl[index],
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(30),
                                                bottomRight:
                                                    Radius.circular(30),
                                              ),
                                            ),
                                          ),
                                      itemCount: product.imgUrl.length),
                                  Align(
                                    alignment: Alignment(0, -1),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            child: _circleElement(
                                                Icons.arrow_back_ios),
                                            onTap: () => Navigator.pop(context),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              _circleElement(Icons.menu),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              _circleElement(Icons.hearing),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              _circleElement(Icons.share),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  product.description,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Colors.black45,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Reviews",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                product.reviews.length == 0
                                    ? Text("No reviews available")
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            _reviewElement(
                                                product.reviews[index]),
                                        itemCount: product.reviews.length,
                                      ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Colors.black45,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Tags",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 30,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 2),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 2,
                                              offset: Offset(0, 2),
                                            )
                                          ]),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            product.tags[index],
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    itemCount: product.tags.length,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Colors.black45,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 20),
                                  child: Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(product
                                                      .seller.sellerImg)),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 3),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 5,
                                                )
                                              ]),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.seller.name,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Container(
                                              height: 20,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 14,
                                                ),
                                                itemCount: product
                                                    .seller.sellerRating
                                                    .floor(),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(5),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color:
                                                                Colors.black12,
                                                            offset:
                                                                Offset(2, 2))
                                                      ]),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      " View More ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(5),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color:
                                                                Colors.black12,
                                                            offset:
                                                                Offset(2, 2))
                                                      ]),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      " Message ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BottomBar(
                    product,
                    function: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Checkout(product),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
