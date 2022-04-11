import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/blocs/navigation_bar/bloc.dart';

class NavigationAppBarBloc extends Bloc<NavigationAppBarEvent, NavigationAppBarState> {
  NavigationAppBarBloc() : super(HomeState());

  @override
  Stream<NavigationAppBarState> mapEventToState(
      NavigationAppBarEvent event) async* {
    // TODO: implement mapEventToState
    if (event is LoadHomeScreen) {
      yield HomeState();
    }
    if (event is LoadSearchScreen) {
      yield SearchState();
    }
    if (event is LoadSaleScreen) {
      yield SaleState();
    }
    if (event is LoadProfileScreen) {
      yield ProfileState();
    }
    if (event is LoadProfileScreen) {
      yield ProfileState();
    }
  }
}