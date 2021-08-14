import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innovent_test/Utils/theme.dart';

class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.grey : Colors.transparent,
        border: isActive
            ? Border.all(
                color: AppColors.grey,
                width: 1,
              )
            : Border.all(
                color: AppColors.grey,
                width: 1,
              ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
