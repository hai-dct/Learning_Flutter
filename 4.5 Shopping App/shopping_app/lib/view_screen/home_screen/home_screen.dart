import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/ext/strings/strings.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/view_model/product_view_model.dart';
import 'package:shopping_app/view_screen/wigets/category_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shopping_app/view_screen/wigets/product_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late var viewModelProduct = PotsUserViewModel();
  bool _grocery = false, _cloth = true, _liquor = false, _food = false;

  @override
  Widget build(BuildContext context) {
    viewModelProduct = Provider.of<PotsUserViewModel>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            topButtonWidget(),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: viewModelProduct.fashionProducts.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.only(top: 24),
                      child: ProductListWidget(
                        name: viewModelProduct.fashionProducts[index].name,
                        image: viewModelProduct.fashionProducts[index].image,
                        shopName: viewModelProduct.fashionProducts[index].shopName,
                        star: viewModelProduct.fashionProducts[index].star,
                        price: viewModelProduct.fashionProducts[index].price.round(),
                        buildContext: context,
                      )
                  );
                }
            )
          ],
        ),
      ),
    );
  }
  Widget topButtonWidget() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        border: Border.all(
            width: 0.5, color: Colors.white),
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 4,
            offset:
            Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          categoryWidget(
              onTap: () {
                setState(() {
                  _grocery = !_grocery;
                });
              },
              icon: MdiIcons.cartOutline,
              isSelected: _grocery,
              text: GROCERY),
          categoryWidget(
              onTap: () {
                setState(() {_cloth = !_cloth;});
              },
              icon: MdiIcons.hanger,
              isSelected: _cloth,
              text: CLOTH),
          categoryWidget(
              onTap: () {
                setState(() {_liquor = !_liquor;});
              },
              icon: MdiIcons.glassWine,
              isSelected: _liquor,
              text: LIQUOR),
          categoryWidget(
              onTap: () {
                setState(() {
                  _food = !_food;
                  List<Product> poodProduct = viewModelProduct.poodProducts;
                  _food ? viewModelProduct.fashionProducts.insertAll(0, poodProduct)
                        : viewModelProduct.fashionProducts.removeRange(0, poodProduct.length);
                });
              },
              icon: MdiIcons.food,
              isSelected: _food,
              text: FOOD),
        ],
      ),
    );
  }
}

Widget categoryWidget({
  required onTap,
  required IconData icon,
  required bool isSelected,
  required String text,
}) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
      child: CategoryWidget(
          iconData: icon,
          isSelected: isSelected,
          actionText: text),
    ),
  );
}
