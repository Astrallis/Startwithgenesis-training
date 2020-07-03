import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:week2/model/catagory_model.dart';
import 'package:week2/model/product_model.dart';
import 'package:week2/model/review_model.dart';
import 'package:week2/model/seller_model.dart';
import 'package:week2/shared/product_cell.dart';
import 'package:week2/shared/product_page.dart';
import 'package:week2/shared/product_tile.dart';

class SearchComponent extends StatefulWidget {
  final String search;
  SearchComponent({this.search});
  @override
  _SearchComponentState createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  static String search;
  String getProduct = """
  query(\$search:String!){
product(where: {name: {_ilike: \$search}}) {
    name
    currency
    price
    rating
    ratingCount
    description
    Images(limit: 3) {
      url
    }
    Seller {
      rating_count
      Name
      seller_rating
      seller_profile
    }
    product_tags(distinct_on: productID) {
      tag {
        tag
      }
    }
    reviews(distinct_on: ID, limit: 10) {
      name
      profile_url
      rating
      review
      timestamp
    }
    }
}""";
  List<Product> productList;
  @override
  void initState() {
    productList = new List<Product>(); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    SizedBox(
                      width: 2,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 4)
                            ]),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                    Expanded(child: Container()),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4)
                          ]),
                      child: Icon(Icons.select_all),
                    ),
                    SizedBox(
                      width: 2,
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Searched for \"" + widget.search + "\" :",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              Query(
                options: QueryOptions(
                    documentNode: gql(getProduct),
                    variables: {"search": "%${widget.search}%"}),
                builder: (QueryResult result,
                    {VoidCallback refetch, FetchMore fetchMore}) {
                  if (result.hasException) {
                    // error connecting to server
                    print(result.exception.toString());
                    return Text("Error Connecting to server!");
                  }

                  if (result.loading) {
                    // getting data from the server
                    return CircularProgressIndicator();
                  }

                  print(result.data['product']);
                  if (productList.isEmpty)
                    for (int i = 0; i < result.data['product'].length; i++) {
                      List<String> imgUrl = new List<String>();
                      for (int j = 0;
                          j < result.data['product'][i]['Images'].length;
                          j++)
                        imgUrl
                            .add(result.data['product'][i]['Images'][j]['url']);

                      List<String> tags = new List<String>();
                      for (int j = 0;
                          j < result.data['product'][i]['product_tags'].length;
                          j++)
                        tags.add(result.data['product'][i]['product_tags'][0]
                            ['tag']['tag']);

                      List<Review> reviews = new List<Review>();
                      for (int j = 0;
                          j < result.data['product'][i]['reviews'].length;
                          j++)
                        reviews.add(
                          Review(
                              name: result.data['product'][i]['reviews'][j]
                                  ['name'],
                              url: result.data['product'][i]['reviews'][j]
                                  ['profile_url'],
                              rating: result.data['product'][i]['reviews'][j]
                                  ['rating'],
                              review: result.data['product'][i]['reviews'][j]
                                  ['review'],
                              timestamp: result.data['product'][i]['reviews'][j]
                                  ['timestamp']),
                        );

                      Seller seller = new Seller(
                        name: result.data['product'][i]['Seller']['Name'],
                        ratingCount: result.data['product'][i]['Seller']
                            ['rating_count'],
                        sellerRating: result.data['product'][i]['Seller']
                            ['seller_rating'],
                        sellerImg: result.data['product'][i]['Seller']
                            ['seller_profile'],
                      );

                      if (imgUrl.isEmpty)
                        imgUrl.add(
                            "https://panty.com/templates/vldthemes_simple_2/images/nopicture_f.jpg");

                      Product product = Product(
                          imgUrl: imgUrl,
                          seller: seller,
                          tags: tags,
                          reviews: reviews,
                          name: result.data['product'][i]['name'],
                          price: result.data['product'][i]['price'],
                          rating: result.data['product'][i]['rating'],
                          ratingCount: result.data['product'][i]['ratingCount'],
                          description: result.data['product'][i]
                              ['description']);
                      productList.add(product);
                    }

                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Found ${productList.length} results",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        productList.isEmpty
                            ? Center(
                                child: Text("Sorry, we didn't found anything"),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ProductPage(
                                                  product: productList[index]),
                                            )),
                                        child: ProductTile(
                                          product: productList[index],
                                        )),
                                itemCount: productList.length,
                              )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
