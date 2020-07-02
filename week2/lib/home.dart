import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'model/catagory_model.dart';
import 'model/product_model.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String getCategories = """
  query {
  product(where: {isTrending: {_eq: true}}) {
    name
    Images(limit: 1) {
      url
    }
    price
  }
}
""";
  List<Product> p;
  @override
  void initState() {
     p = new List<Product>();// TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Running the Query in this widget
        child: Query(
          options: QueryOptions(
            documentNode: gql(getCategories),
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

            for (int i = 0; i < result.data['product'].length; i++)
             { 
               Product ps = Product(
                 name:result.data['product'][i]['name'],
                 imgURL:result.data['product'][i]['Images'][0]['url'],
                 price:result.data['product'][i]['price']);
               print(ps.name);

              p.add(ps);
                  }
            print(p);
            return ListView.builder(
                itemCount: p.length,
                itemBuilder: (context, index) {
                  return ProductItem(product: p[index]);
                });
          },
        ),
      ),
    );
  }
//    String getCategories = """
//   query {
//     Category{
//       Category_name
//       Category_url
//     }
//   }
// """;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Running the Query in this widget
//         child: Query(
//           options: QueryOptions(
//             documentNode: gql(getCategories),
//           ),
//           builder: (QueryResult result,
//               {VoidCallback refetch, FetchMore fetchMore}) {
//             if (result.hasException) {
//               // error connecting to server
//               print(result.exception.toString());
//               return Text("Error Connecting to server!");
//             }

//             if (result.loading) {
//               // getting data from the server
//               return CircularProgressIndicator();
//             }
//             // Casting the Categories into CategoryList Object present in Category.dart
//             CategoryList cl =
//                 CategoryList.fromResponse(result.data['Category']);
//             print(cl.categories[0].name);
//             // Displaying the ListView on successful response
//             return ListView.builder(
//                 itemCount: cl.categories.length,
//                 itemBuilder: (context, index) {
//                   // Category Object contains the name & url of category
//                   final category = cl.categories[index];

//                   // Showing custom item ui for a particular category
//                   return CategoryItem(category: category);
//                 });
//           },
//         ),
//       ),
//     );
//   }
}

class ProductItem extends StatelessWidget {
  Product product;
  ProductItem({this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image(
            image: NetworkImage(product.imgURL),
          ),
          Text(product.name),
          Text(product.price.toString())
        ],
      ),
    );
  }
}

// class CategoryItem extends StatefulWidget {
//   final Category category;

//   CategoryItem({@required this.category});

//   @override
//   _CategoryItemState createState() => _CategoryItemState();
// }

// class _CategoryItemState extends State<CategoryItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 2),
//       child: GestureDetector(
//         onTap: () {
//           print("You have tapped on ${widget.category.name}");
//         },
//         child: Container(
//           child: Row(
//             children: <Widget>[
//               Stack(
//                 children: <Widget>[
//                   Container(
//                     height: 50,
//                     width: 50,
//                     child: Center(
//                       child: CupertinoActivityIndicator(),
//                     ),
//                   ),
//                   Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                           image: NetworkImage(widget.category.imgURL ??
//                               'https://graphql.org/users/logos/github.png'),
//                           fit: BoxFit.fill),
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   widget.category.name,
//                   style: TextStyle(fontSize: 18),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
