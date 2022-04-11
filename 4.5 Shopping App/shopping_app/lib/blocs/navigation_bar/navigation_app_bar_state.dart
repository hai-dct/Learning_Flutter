import 'package:equatable/equatable.dart';

abstract class NavigationAppBarState extends Equatable {
  const NavigationAppBarState();
}

class HomeState extends NavigationAppBarState {
  int index = 0;
  @override
  // TODO: implement props
  List<Object?> get props => [index];
}

class SearchState extends NavigationAppBarState {
  int index = 1;
  @override
  // TODO: implement props
  List<Object?> get props => [index];
}

class SaleState extends NavigationAppBarState {
  int index = 2;
  @override
  // TODO: implement props
  List<Object?> get props => [index];
}

class ProfileState extends NavigationAppBarState {
  int index = 3;
  @override
  // TODO: implement props
  List<Object?> get props => [index];
}
