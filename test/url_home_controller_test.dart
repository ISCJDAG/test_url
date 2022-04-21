// ignore_for_file: unnecessary_cast

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import 'package:test_urls/src/controller/url_home_controller.dart';

import 'mock/mock.dart';

class MockUrlController extends Mock implements UrlController {}

void main() {
  //create a group for testing items in the homepage.

  group('ShortUrls', () {
    test('validate url format', () async {
      //
      final urlController = MockUrlController();
      Get.put(urlController);
      urlController.validateUrl('url');
      final mocked = Mocked();

      when(urlController.validateUrl('url'))
          .thenReturn(urlController.urlIncorrect);

      expect(mocked.getUrl(), true);
    });
    test('validate url isEMpty', () {
      //
    });
    test('validate we have data in the list', () {
      ///
    });
  });
}
