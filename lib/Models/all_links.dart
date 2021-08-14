import 'dart:convert';

import 'package:innovent_test/Models/link.dart';

class AllLinks {
  var link;

  AllLinks({this.link});

  AllLinks copyWith({final link}) {
    return new AllLinks(link: link ?? this.link);
  }

  factory AllLinks.fromJson(Map<String, dynamic> jsonData) {
    return AllLinks(
      link: Link.fromJson(jsonData['link']),
    );
  }

  static Map<String, dynamic> toMap(AllLinks link) => {
        'link': Link.toMap(link.link),
      };

  static String encode(List<AllLinks> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>((link) => AllLinks.toMap(link))
            .toList(),
      );

  static List<AllLinks> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<AllLinks>((item) => AllLinks.fromJson(item))
          .toList();
}
