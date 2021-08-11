import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:innovent_test/Models/slider.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white,
            ),
          ),
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.deepPurple,
            child: Container(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                sliderArrayList[index].sliderImageUrl,
                width: 40,
                height: 40,
              ),
            ),
          )
        ],
      ),
    );
  }
}
