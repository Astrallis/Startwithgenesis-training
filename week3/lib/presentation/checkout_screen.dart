import 'package:flutter/material.dart';
import 'package:week3/models/product_model.dart';
import 'package:week3/shared/bottom_bar.dart';

class Checkout extends StatefulWidget {
  Product product;
  Checkout(this.product);
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int count;
  int amount;
  @override
  void initState() {
    count = 1;
    amount = widget.product.price * count; // TODO: implement initState
    super.initState();
  }

  _counter() {
    return Container(
      height: 20,
      width: 60,
      child: Row(
        children: [
          // Expanded(child: Container(decoration: BoxDecoration(color: Colors.white,border: Border.all(width:1,color:Colors.grey)),child: Icon(Icons.minimize),),),
          GestureDetector(
            onTap: () => setState(() {
              if (count > 1) {
                count = count - 1;
              }
              amount = count * widget.product.price;
            }),
            child: Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.grey)),
                child: Icon(
                  Icons.remove,
                  size: 19,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.grey)),
                child: Text(
                  count.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 19),
                )),
          ),
          GestureDetector(
            onTap: () => setState(() {
              count = count + 1;
              amount = count * widget.product.price;
            }),
            child: Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.grey)),
                child: Icon(
                  Icons.add,
                  size: 19,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        title: Text(
          "CheckOut",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(widget.product.imgUrl[0])),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 170,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.product.seller.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Rs." + widget.product.price.toString() + "/Pcs",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 19),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          _counter()
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Divider(
                    color: Colors.black38,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Summary",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                height: 16,
                                child: Text(
                                  widget.product.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Rs.$amount.00",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text("Size: 4kg",
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                        SizedBox(
                          height: 4,
                        ),
                        Text("Quantity: $count",
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Divider(
                    color: Colors.black38,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total", style: TextStyle(fontSize: 16),),
                      Text(
                        "Rs.$amount.00",
                        style:
                            TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          BottomBar(
            widget.product,
            isCheckout: true,
            price: amount,
          )
        ],
      ),
    );
  }
}
