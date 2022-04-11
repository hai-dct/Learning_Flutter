import 'package:equatable/equatable.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();
}

class LoadProductListScreen extends ProductListEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}