import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shopping_app/view_screen/wigets/generator_widget.dart';

class ProductListWidget extends StatefulWidget {
  final String name, image, shopName;
  final double star;
  final int price;
  final BuildContext buildContext;

  const ProductListWidget(
      {Key? key,
        required this.name,
        required this.image,
        required this.shopName,
        required this.star,
        required this.price,
        required this.buildContext})
      : super(key: key);

  @override
  ProductListWidgetState createState() => ProductListWidgetState();
}

class ProductListWidgetState extends State<ProductListWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withAlpha(26),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: Image.asset(
                  widget.image,
                  height: 90,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 90,
                margin: EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(widget.name,
                            style: TextStyle(fontSize: 20)),
                        Icon(
                          MdiIcons.heart,
                          color: Colors.grey.withAlpha(80),
                          size: 22,
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Generator.buildRatingStar(
                            rating: widget.star,
                            size: 16,
                            inactiveColor: Colors.grey),
                        Container(
                          margin: EdgeInsets.only(left: 4),
                          child: Text(widget.star.toString(),
                              style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              MdiIcons.storeOutline,
                              color: Colors.grey[600],
                              size: 20,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 4),
                              child: Text(
                                widget.shopName,
                                  style: TextStyle(fontSize: 12)),
                              ),
                          ],
                        ),
                        Text(
                            widget.price.toString() + " đ",
                          style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}