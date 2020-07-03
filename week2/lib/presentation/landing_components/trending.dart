import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:week2/model/product_model.dart';
import 'package:week2/model/review_model.dart';
import 'package:week2/model/seller_model.dart';
import 'package:week2/shared/product_cell.dart';

class Trending extends StatefulWidget {
  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  String getTrending = """query{
  product(where: {isTrending: {_eq: true}}) {
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
    productList = new List<Product>();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        documentNode: gql(getTrending),
      ),
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
            for (int j = 0; j < result.data['product'][i]['Images'].length; j++)
              imgUrl.add(result.data['product'][i]['Images'][j]['url']);

            List<String> tags = new List<String>();
            for (int j = 0;
                j < result.data['product'][i]['product_tags'].length;
                j++)
              tags.add(
                  result.data['product'][i]['product_tags'][0]['tag']['tag']);

            List<Review> reviews = new List<Review>();
            for (int j = 0;
                j < result.data['product'][i]['reviews'].length;
                j++)
              reviews.add(
                Review(
                    name: result.data['product'][i]['reviews'][j]['name'],
                    url: result.data['product'][i]['reviews'][j]['profile_url'],
                    rating: result.data['product'][i]['reviews'][j]['rating'],
                    review: result.data['product'][i]['reviews'][j]['review'],
                    timestamp: result.data['product'][i]['reviews'][j]
                        ['timestamp']),
              );

            Seller seller = new Seller(
              name: result.data['product'][i]['Seller']['Name'],
              ratingCount: result.data['product'][i]['Seller']['rating_count'],
              sellerRating: result.data['product'][i]['Seller']
                  ['seller_rating'],
              sellerImg: result.data['product'][i]['Seller']['seller_profile'],
            );

            Product product = Product(
                imgUrl: imgUrl,
                seller: seller,
                tags: tags,
                reviews: reviews,
                name: result.data['product'][i]['name'],
                price: result.data['product'][i]['price'],
                rating: result.data['product'][i]['rating'],
                ratingCount: result.data['product'][i]['ratingCount'],
                description: result.data['product'][i]['description']);
            productList.add(product);
          }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width-40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: productList.length,
              itemBuilder: (context, index) => ProductCell(product: productList[index],),
            ),
          ),
        );
      },
    );
  }
}
