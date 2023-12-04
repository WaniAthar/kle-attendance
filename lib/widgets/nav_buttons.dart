import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final String tooltip;
  final EdgeInsetsGeometry? margin;
  final Widget icon;
  final Function()? onPressed;
  const NavButton(
      {super.key,
      required this.tooltip,
      required this.icon,
      required this.onPressed,
      this.margin = const EdgeInsets.only(left: 5, right: 5)});
  @override
  Widget build(BuildContext context) {
    final width = AppBar().preferredSize.height;
    return Container(
      margin: margin,
      width: width * 0.9,
      height: width * 0.9,
      child: FloatingActionButton(
        elevation: 3,
        hoverColor: Colors.white,
        splashColor: Colors.white30,
        tooltip: tooltip,
        onPressed: onPressed,
        child: icon,
      ),
    );
  }
}
