import 'package:flutter/cupertino.dart';
import 'package:shopping_app/model/product.dart';

class PotsUserViewModel with ChangeNotifier {

  List<Product> fashionProducts = [];
  List<Product> poodProducts = [];

  getPotsUser() async {
    this.fashionProducts = await [
      Product(id: 1, star: 3, shopName: 'GuMac', image: 'assets/images/product/quanao1.jpeg', price: 495000, name: 'Đầm sát nách cổ dây',),
      Product(id: 2, star: 4.2, shopName: 'GuMac', image: 'assets/images/product/quanao2.jpeg', price: 295000, name: 'Áo danton phối nút',),
      Product(id: 3, star: 4.5, shopName: 'GuMac', image: 'assets/images/product/quanao3.jpeg', price: 1250000, name: 'Đầm Luxury vai hoa',),
      Product(id: 4, star: 3.2, shopName: 'GuMac', image: 'assets/images/product/quanao4.jpeg', price: 495000, name: 'Đầm cổ tròn cúp ngực',),
      Product(id: 5, star: 4.1, shopName: 'GuMac', image: 'assets/images/product/quanao5.jpeg', price: 520000, name: 'Đầm tay phồng nhún eo',),
      Product(id: 6, star: 2, shopName: 'GuMac', image: 'assets/images/product/quanao6.jpeg', price: 495000, name: 'Đầm sát nách cổ ves',),
      Product(id: 7, star: 3.9, shopName: 'GuMac', image: 'assets/images/product/quanao7.jpeg', price: 590000, name: 'Đầm ren tay đính nơ',),
      Product(id: 8, star: 4.8, shopName: 'GuMac', image: 'assets/images/product/quanao8.jpeg', price: 595000, name: 'Quần jeans skinny',),
      Product(id: 9, star: 2.7, shopName: 'GuMac', image: 'assets/images/product/quanao9.jpeg', price: 230000, name: 'Áo polo mẹ thêu',),
      Product(id: 10, star: 3.6, shopName: 'GuMac', image: 'assets/images/product/quanao10.jpeg', price: 275000, name: 'Áo cổ V đan dây',),
    ];
    notifyListeners();
  }

  getPostPood() async {
    this.poodProducts = await [
      Product(id: 1, star: 5, shopName: 'HanhPood', image: 'assets/images/product/product-3.jpg', price: 100000, name: 'Bánh kem',),
      Product(id: 2, star: 5, shopName: 'HanhPood', image: 'assets/images/product/product-2.jpg', price: 12000, name: 'Bánh kem',),
      Product(id: 3, star: 4, shopName: 'HanhPood', image: 'assets/images/product/product-1.jpg', price: 15000, name: 'Bánh kem',),
      Product(id: 4, star: 3, shopName: 'HanhPood', image: 'assets/images/product/product-4.jpg', price: 200000, name: 'Bánh kem',),
      Product(id: 5, star: 2.7, shopName: 'HanhPood', image: 'assets/images/product/product-5.jpg', price: 160000, name: 'Khô gà lá chanh',),
    ];
    notifyListeners();
  }
}