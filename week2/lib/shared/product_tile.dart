import 'package:flutter/material.dart';
import 'package:week2/model/product_model.dart';

class ProductTile extends StatefulWidget {
  Product product;
  ProductTile({this.product});
  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(2, 2),
                          blurRadius: 2)
                    ],
                    color: Color(0xffdddddd),
                    image: DecorationImage(
                        image: NetworkImage(widget.product.imgUrl[0]),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    // image: DecorationImage()
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          widget.product.seller.name,
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              "Rs.${widget.product.price}  ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 6),
                                child: Text("FREE SHIPPING",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              size: 14,
                              color: widget.product.rating > 4
                                  ? Colors.green
                                  : widget.product.rating >= 3
                                      ? Colors.yellow
                                      : Colors.red,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.product.rating.toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "(${widget.product.ratingCount})",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black38,
          )
        ],
      ),
    );
  }
}
