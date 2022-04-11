
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/blocs/list_product_bloc/bloc_product.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(ProductState());

  @override
  Stream<ProductListState> mapEventToState(event) async* {
    // TODO: implement mapEventToState
    if (event is LoadProductListScreen) {
      // yield ProductState().product.add();
    }
  }
}