import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:innovent_test/Models/all_links.dart';
import 'package:innovent_test/Models/link.dart';
import 'package:innovent_test/Utils/globals.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

final linksStream = new BehaviorSubject<String>();

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Future<Link> shortenLink() async {
    try {
      final url = '$baseUrl/shorten';
      final response = await http.post(
        Uri.parse(url),
        body: {'url': currentLink},
      );
      if (response.statusCode != 201) {
        Fluttertoast.showToast(
            msg: "Invalid link!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        throw new Exception('error getting quotes');
      }

      Map<String, dynamic> map = {
        "oldLink": currentLink,
        "shortLink": jsonDecode(response.body)["result"]["full_short_link"]
      };

      SharedPreferences prefs = await SharedPreferences.getInstance();

      Link link = Link.fromJson(map);

      AllLinks links = new AllLinks();
      links.link = link;
      linksList.add(links);

      prefs.setString("links", AllLinks.encode(linksList));
      linksStream.add(AllLinks.encode(linksList));

      return Link.fromJson(map);
    } on TimeoutException catch (_) {
      Fluttertoast.showToast(
          msg: "Request timeout!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      throw new Exception('error getting quotes');
    } on SocketException catch (_) {
      Fluttertoast.showToast(
          msg: "Something went wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      throw new Exception('error getting quotes');
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() {
    _controller.close();
  }
}
