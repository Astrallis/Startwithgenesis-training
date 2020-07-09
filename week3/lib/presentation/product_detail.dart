import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool _isLoading;
  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("assets/product.json");
  }

  Future parseJson() async {
    String jsonString = await _loadFromAsset();
    final jsonResponse = jsonDecode(jsonString);
    print(jsonResponse);
  }

  @override
  void initState() {
    _isLoading = true;
    parseJson().then((value) =>
        setState(() => _isLoading = false)); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(
                child: CupertinoActivityIndicator(),
              )
            : Container());
  }
}
