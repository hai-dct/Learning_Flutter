import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/blocs/navigation_bar/bloc.dart';
import 'package:shopping_app/ext/strings/strings.dart';
import 'package:shopping_app/view_model/product_view_model.dart';
import 'package:shopping_app/view_screen/home_screen/home_screen.dart';
import 'package:shopping_app/view_screen/profile_screen/profile_screen.dart';
import 'package:shopping_app/view_screen/sale_screen/sale_screen.dart';
import 'package:shopping_app/view_screen/search_screen/search_screen.dart';

class FullShoppingApp extends StatefulWidget {
  const FullShoppingApp({Key? key}) : super(key: key);

  @override
  _FullShoppingAppState createState() => _FullShoppingAppState();
}

class _FullShoppingAppState extends State<FullShoppingApp> {
  final List<Widget> screen = [
    HomeScreen(),
    SearchScreen(),
    SaleScreen(),
    ProfileScreen(),
  ];

  final PageStorageBucket pageStorageBucket = PageStorageBucket();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PotsUserViewModel>(context, listen: false).getPotsUser();
    Provider.of<PotsUserViewModel>(context, listen: false).getPostPood();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationAppBarBloc, NavigationAppBarState>(
        builder: (context, state) {
          if (state is HomeState) {
            return _buildActivePage(currentIndex: state.index);
          }
          if (state is SearchState) {
            return _buildActivePage(currentIndex: state.index);
          }
          if (state is SaleState) {
            return _buildActivePage(currentIndex: state.index);
          }
          if (state is ProfileState) {
            return _buildActivePage(currentIndex: state.index);
          }
          return Container();
        },
    );
  }
  Scaffold _buildActivePage({required int currentIndex}) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: PageStorage(bucket: pageStorageBucket, child: screen[currentIndex],),
          )
        ],
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          unselectedItemColor: Colors.grey[600],
          selectedItemColor: Color(0xff3d63ff),
          onTap: (index) => _onTapTapBarItem(index: index),
          items: [
            _buildTapBarItem(icon: Icon(Icons.store, size: 24,), title: HOME),
            _buildTapBarItem(icon: Icon(Icons.search, size: 24), title: SEARCH),
            _buildTapBarItem(icon: Icon(Icons.shopping_cart, size: 24), title: CART),
            _buildTapBarItem(icon: Icon(Icons.manage_accounts_sharp, size: 24), title: PROFILE),
          ],
        ),
      ),
    );
  }

  _onTapTapBarItem({required int index}) {
    if (index == 0) {
      return BlocProvider.of<NavigationAppBarBloc>(context).add(LoadHomeScreen());
    }
    if (index == 1) {
      return BlocProvider.of<NavigationAppBarBloc>(context).add(LoadSearchScreen());
    }
    if (index == 2) {
      return BlocProvider.of<NavigationAppBarBloc>(context).add(LoadSaleScreen());
    }
    if (index == 3) {
      return BlocProvider.of<NavigationAppBarBloc>(context).add(LoadProfileScreen());
    }
  }

  _buildTapBarItem({required Widget icon, required String title}){
    return BottomNavigationBarItem(
      icon: icon,
      title: Text(title,
          textAlign: TextAlign.left
      ),

    );
  }
}
