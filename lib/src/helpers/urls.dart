import 'package:http/http.dart' as http;

class Urls {
  final String url;
  final dynamic body;
  final dynamic header;

  Urls({required this.url, this.body, this.header});

  saveUrlShort() {
    return http
        .post(Uri.parse(url), headers: header, body: body)
        .timeout(const Duration(minutes: 1));
  }
}
