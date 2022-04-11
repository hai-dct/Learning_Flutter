import 'package:equatable/equatable.dart';

abstract class NavigationAppBarEvent extends Equatable {
  const NavigationAppBarEvent();
}

class LoadHomeScreen extends NavigationAppBarEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadSearchScreen extends NavigationAppBarEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class LoadSaleScreen extends NavigationAppBarEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class LoadProfileScreen extends NavigationAppBarEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
