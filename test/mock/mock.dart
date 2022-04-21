import 'package:get/get.dart';
import 'package:test_urls/src/controller/url_home_controller.dart';

class Mocked {
  static Mocked get to => Get.find<Mocked>();

  String getUrl() {
    return UrlController.to.validateUrl('url');
  }
}
