import 'package:flutter/material.dart';

class SimpleCard extends StatelessWidget {
  final Widget? child;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const SimpleCard({super.key, this.child, this.onLongPress, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.black12,
      shadowColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(0),
      child: InkWell(
        highlightColor: Colors.black12,
        splashColor: Colors.black26,
        onTap: onTap,
        onLongPress: onLongPress,
        child: child,
      ),
    );
  }
}
