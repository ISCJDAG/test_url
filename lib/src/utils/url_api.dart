class UrlApi {
  final String _urlApi = 'https://url-shortener-nu.herokuapp.com';

  final String _post = '/api/alias';
  final String _getOne = '/api/alias/';

  //getters
  String get urlApi => _urlApi;
  String get post => _post;
  String get getOne => _getOne;
}
