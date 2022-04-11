import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/blocs/navigation_bar/bloc.dart';
import 'package:shopping_app/view_model/product_view_model.dart';
import 'package:shopping_app/view_screen/full_app/full_shopping_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PotsUserViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocProvider<NavigationAppBarBloc>(
          create: (context) => NavigationAppBarBloc()..add(LoadHomeScreen()),
          child: FullShoppingApp(),
        )
      ),
    );
  }
}


