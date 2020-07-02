import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:week2/model/catagory_model.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  bool isColapsed;

  String getCategory = """query{
                            Category{
                                  ID
                                  Category_name
                                  Category_url
                                  }
                            }""";
  
  List<Category> cl;
  _expandedCategoryElement(Category category) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 60,
        width: 20,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      category.imgURL,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                category.name,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }

  _colapsedCategoryElement(Category category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  category.imgURL,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            category.name.split(" ")[0],
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    cl = new List<Category>();
    isColapsed = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Query(
                options: QueryOptions(
                  documentNode: gql(getCategory),
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

                  print(result.data['Category']);
                  if (cl.isEmpty) {
                    for (int i = 0; i < result.data['Category'].length; i++) {
                      Category category = Category(
                          name: result.data['Category'][i]['Category_name'],
                          imgURL: result.data['Category'][i]['Category_url'],
                          id: result.data['Category'][i]['ID']);
                      print(category.name);
                      cl.add(category);
                    }
                  }
                  print(cl);

                  return Container(
                    width: MediaQuery.of(context).size.width / 1.25,
                    height: isColapsed ? 95 : 550,
                    child: ListView.builder(
                        scrollDirection:
                            isColapsed ? Axis.horizontal : Axis.vertical,
                        shrinkWrap: true,
                        itemCount: cl.length,
                        itemBuilder: (context, index) => isColapsed
                            ? _colapsedCategoryElement(cl[index])
                            : _expandedCategoryElement(cl[index])),
                  );
                },
              ),
              GestureDetector(
                  onTap: () => setState(() {
                        isColapsed = !isColapsed;
                      }),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Icon(isColapsed
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,),
                  ),)
            ],
          ),
        ),
      ),
    );
  }
}
