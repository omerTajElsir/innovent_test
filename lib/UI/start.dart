import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:innovent_test/UI/landing_page.dart';
import 'package:innovent_test/Utils/theme.dart';

class StartPage extends StatefulWidget {
  Route route() {
    return MaterialPageRoute<void>(builder: (_) => StartPage());
  }
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          SvgPicture.asset("assets/svg/logo.svg"),
          SvgPicture.asset("assets/svg/illustration.svg"),
          Text(
            "More than just\nshorter links",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Build your brand's recognition and get detailed insights on how your links are performing.",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ),
          Expanded(child: Container()),
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LandingPage()),
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 60),
              width: MediaQuery.of(context).size.width - 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: AppColors.accentColor,
              ),
              height: 60,
              child: Center(
                child: Text(
                  "START",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
