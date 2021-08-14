import 'package:equatable/equatable.dart';

class Link extends Equatable {
  final oldLink;
  final shortLink;

  const Link({this.oldLink, this.shortLink});

  @override
  List<Object> get props => [oldLink, shortLink];

  static Link fromJson(dynamic json) {
    return Link(
      oldLink: json['oldLink'],
      shortLink: json['shortLink'],
    );
  }

  static Map<String, dynamic> toMap(Link link) => {
        'oldLink': link.oldLink,
        'shortLink': link.shortLink,
      };
}
