import 'package:flutter/material.dart';
import 'package:news_provider/src/models/news_models.dart';
import 'package:http/http.dart' as http;

const _URL_NEWS = 'https://newsapi.org/v2';
const _APIL_KEY = '8d52bdc0af2e4e5e9cc13d7879dabee3';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  NewsService() {
    this.getTopHeadlines();
  }

  getTopHeadlines() async {
    print('Cargando Headlines...');
    final url = '$_URL_NEWS/top-headlines?country=us&apiKey=$_APIL_KEY';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }
}
