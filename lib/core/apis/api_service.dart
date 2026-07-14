import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newss_app/models/news_model.dart';

abstract class ApiService {
  static Future<NewsModel> getNews() async {
    Uri url = Uri.https('newsapi.org', '/v2/everything', {
      'q': 'bitcoin',
      'apiKey': 'eda4f9cddcb440cabf291590d4eed40f',
    });
    var response = await http.get(url);
    var responsebody = response.body;
    var json = jsonDecode(responsebody);
    return NewsModel.fromJson(json);
  }
}
