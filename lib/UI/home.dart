import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:innovent_test/Models/all_links.dart';
import 'package:innovent_test/Utils/globals.dart';
import 'package:innovent_test/Utils/theme.dart';
import 'package:innovent_test/bloc/login_bloc.dart';
import 'package:innovent_test/repositories/authentication_repository.dart';
import 'package:innovent_test/widgets/empty.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  Route route() {
    return MaterialPageRoute<void>(builder: (_) => MyHomePage());
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final TextEditingController _linkField = new TextEditingController();
  final _linkForm = GlobalKey<FormState>();

  SharedPreferences? prefs;
  getCart() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs?.getString("links")?.toString().contains("oldLink") == true) {
      setState(() {
        String? data = prefs?.getString("links");
        linksList = AllLinks.decode(data!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    linksStream.stream.listen((event) {
      setState(() {
        linksList = AllLinks.decode(event);
      });
    });
    getCart();
  }

  bool _validator = true;
  int copiedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: linksList.length > 0
          ? AppBar(
              title: Text(
                "Your Link History",
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          : null,
      backgroundColor: AppColors.screenBackground,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          // TODO: implement listener}
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            linksList.length > 0
                ? Expanded(
                    child: ListView.builder(
                    itemCount: linksList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 50,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      linksList[index].link.oldLink,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          linksList.removeAt(index);
                                          prefs?.setString("links",
                                              AllLinks.encode(linksList));
                                        });
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.black,
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              height: .5,
                              color: Colors.black54,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                linksList[index].link.shortLink,
                                style: TextStyle(color: AppColors.accentColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                    text: linksList[index].link.shortLink));
                                setState(() {
                                  copiedIndex = index;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: copiedIndex == index
                                      ? AppColors.primaryColor
                                      : AppColors.accentColor,
                                ),
                                height: 50,
                                child: Center(
                                  child: Text(
                                    copiedIndex == index ? "COPIED!" : "COPy",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    },
                  ))
                : Empty(),
            Form(
              key: _linkForm,
              child: Container(
                height: 200,
                color: AppColors.primaryColor,
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset("assets/svg/shape.svg")),
                    BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.status != current.status,
                      builder: (context, state) {
                        return state.status.isSubmissionInProgress
                            ? Center(
                                child: const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white)))
                            : Padding(
                                padding: EdgeInsets.only(left: 50, right: 50),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: Center(
                                        child: TextFormField(
                                          controller: _linkField,
                                          style: TextStyle(fontSize: 17),
                                          cursorColor: Colors.black,
                                          textAlign: TextAlign.center,
                                          decoration: new InputDecoration(
                                            errorStyle: TextStyle(height: 0),
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: new OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                            ),
                                            hintStyle: TextStyle(
                                                color: _validator
                                                    ? Colors.grey
                                                    : Colors.red),
                                            hintText: 'Shorten a link here...',
                                          ),
                                          validator: (value) {
                                            if (value?.isEmpty == true) {
                                              setState(() {
                                                _validator = false;
                                              });
                                              return "";
                                            } else {
                                              setState(() {
                                                _validator = true;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (_linkForm.currentState
                                                ?.validate() ==
                                            true) {
                                          setState(() {
                                            currentLink =
                                                _linkField.text.toString();
                                            context
                                                .read<LoginBloc>()
                                                .add(const LoginSubmitted());
                                          });
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: AppColors.accentColor,
                                        ),
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            "SHORTEN IT!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
