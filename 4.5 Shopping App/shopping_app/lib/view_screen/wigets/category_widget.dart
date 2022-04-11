import 'package:flutter/material.dart';
class CategoryWidget extends StatelessWidget {
  final IconData iconData;
  final String actionText;
  final bool isSelected;

  const CategoryWidget(
      {Key? key,
        required this.iconData,
        required this.actionText,
        this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12, bottom: 12),
      child: Column(
        children: [
          ClipOval(
            child: Material(
              color: isSelected
                  ? Colors.blue
                  : Colors.blue.withAlpha(20),
              child: SizedBox(
                  width: 52,
                  height: 52,
                  child: Icon(
                    iconData,
                    color: isSelected
                        ? Colors.white
                        : Colors.blue,
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              actionText,
              style: TextStyle(

              ),
            )
          ),
        ],
      ),
    );
  }
}