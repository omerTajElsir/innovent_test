import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
      children: [
        SizedBox(
          height: 60,
        ),
        SvgPicture.asset("assets/svg/logo.svg"),
        SvgPicture.asset("assets/svg/illustration.svg"),
        Text(
          "Let's get started!",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Paste your links here into\nthe field to shorten it.",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
        ),
      ],
    ));
  }
}
