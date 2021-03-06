import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_provider/src/models/category_model.dart';
import 'package:news_provider/src/models/news_models.dart';
import 'package:http/http.dart' as http;

const _URL_NEWS = 'https://newsapi.org/v2';
// Coluca tu Api key, obtenla abriendo una cuenta en: https://newsapi.org
const _APIL_KEY = '';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  bool _isLoading = true;
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();
    categories.forEach((element) {
      this.categoryArticles[element.name] = [];
    });
  }

  get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor) {
    this._selectedCategory = valor;
    this._isLoading = true;

    this.getArticlesByCategory(valor);

    notifyListeners();
  }

  bool get isLoading => _isLoading;

  List<Article> get getArticulosCategoriaSeleccionada =>
      this.categoryArticles[this.selectedCategory];

  getTopHeadlines() async {
    print('Cargando Headlines...');
    final url = '$_URL_NEWS/top-headlines?country=us&apiKey=$_APIL_KEY';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category].length > 0) {
      this._isLoading = false;
      notifyListeners();
      return this.categoryArticles[category];
    }

    final url =
        '$_URL_NEWS/top-headlines?country=us&apiKey=$_APIL_KEY&category=$category';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);

    this.categoryArticles[category].addAll(newsResponse.articles);

    this._isLoading = false;
    notifyListeners();
  }
}
