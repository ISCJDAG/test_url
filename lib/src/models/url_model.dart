import 'dart:convert';

class UrlModel {
  late final String alias;
  late final String originalurl;
  late final String shortUrl;

  UrlModel(
      {required this.alias, required this.originalurl, required this.shortUrl});

  factory UrlModel.fromJson(Map<String, dynamic> json) => UrlModel(
        alias: json['alias'],
        originalurl: json['originalurl'],
        shortUrl: json['shortUrl'],
      );

  /*Map<String, dynamic> toJson() => {
        "alias": alias,
        "originalurl": originalurl,
        "shortUrl": shortUrl,
      };*/

  static Map<String, dynamic> toMap(UrlModel url) => {
        "alias": url.alias,
        "originalurl": url.originalurl,
        "shortUrl": url.shortUrl,
      };

  static String encode(List<UrlModel> urls) => json.encode(
        urls.map<Map<String, dynamic>>((url) => UrlModel.toMap(url)).toList(),
      );

  static List<UrlModel> decode(String urls) =>
      (json.decode(urls) as List<dynamic>)
          .map<UrlModel>((item) => UrlModel.fromJson(item))
          .toList();
}
