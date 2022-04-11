import 'package:equatable/equatable.dart';
import 'package:shopping_app/model/product.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();
}

class ProductState extends ProductListState {
  List<Product> product = [];
  @override
  // TODO: implement props
  List<Object?> get props => [product];
}