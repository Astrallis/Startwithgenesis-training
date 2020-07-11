import 'package:flutter/material.dart';
import 'package:week3/models/product_model.dart';

class BottomBar extends StatefulWidget {
  Product product;
  bool isCheckout;
  int price;
  VoidCallback function;
  BottomBar(this.product, {this.function, this.price, this.isCheckout = false});
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  VoidCallback function;
  Product product;
  @override
  void initState() {
    function = widget.function;
    product = widget.product; // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 1),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        color: Color(0xff1b1b1b),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.price == null
                        ? "Rs." " ${product.price}"
                        : "Rs. " + widget.price.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: product.rating > 4
                            ? Colors.green
                            : product.rating >= 3 ? Colors.yellow : Colors.red,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        product.rating.toString(),
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        " (${product.ratingCount})",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: function,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.isCheckout ? "PAY" : "BUY NOW",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
