import 'package:flutter/material.dart';
import 'package:week2/model/product_model.dart';

class ProductCell extends StatefulWidget {
  Product product = new Product();
  ProductCell({this.product});
  @override
  _ProductCellState createState() => _ProductCellState();
}

class _ProductCellState extends State<ProductCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(2,2), blurRadius: 2)],
                color: Color(0xffaaaaaa),
                image: DecorationImage(image: NetworkImage(widget.product.imgUrl[0])),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                // image: DecorationImage()
              ),
              child: Align(
                alignment: Alignment(-1, 1),
                child: Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    // image: DecorationImage()
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text("Rs."+widget.product.price.toString(), style:TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: 
                    Colors.amber)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(
                width: 90,
                  child: Text(
                widget.product.name,
                style: TextStyle(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              )),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 14,
                    color: widget.product.rating>4?Colors.green:widget.product.rating>=3?Colors.yellow:Colors.red,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(widget.product.rating.toString(), style: TextStyle(fontSize: 12),),
                  Text("(${widget.product.ratingCount})", style: TextStyle(fontSize: 12),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
