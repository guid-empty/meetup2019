import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Products extends StatelessWidget {
  final List<String> products;
  Products(this.products);

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      margin: EdgeInsets.all(4.0),
      elevation: 10,
      child: Column(
        children: <Widget>[
          Image.asset('assets/macbook.jpg', width: 400),
          Text(
            products[index],
            style: TextStyle(color: Colors.deepPurple),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: products.length,
    );
  }
}
