import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_model.dart';
import 'package:http/http.dart' as http;


final _URL_NEWS = 'https://newsapi.org/v2';
final _API_KEY = 'e9eb24982e52439a89ebb5e25d5a0c3b';

class NewsService with ChangeNotifier{

  List<Article> headLines = [];
  String _selectedCategory = 'business';
   bool _isLoading = true;

  List<CategoryModel> categories = [
    CategoryModel(FontAwesomeIcons.building, 'business'),
    CategoryModel(FontAwesomeIcons.tv, 'entertainment'),
    CategoryModel(FontAwesomeIcons.addressCard, 'general'),
    CategoryModel(FontAwesomeIcons.headSideVirus, 'health'),
    CategoryModel(FontAwesomeIcons.vials, 'science'),
    CategoryModel(FontAwesomeIcons.volleyballBall, 'sports'),
    CategoryModel(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String,  List<Article>> categoryArticuls = {};


  NewsService(){
    this.getTopHeadLines();

    categories.forEach((item){
      this.categoryArticuls[item.name] = new List();
    });
  }

  bool get isLoading => this._isLoading;

  get selectedCategory => this._selectedCategory;
  set selectedCategory(String valor){
    this._selectedCategory = valor;

    this._isLoading = true;

    this.getArticulsByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSeleccionada => this.categoryArticuls[this.selectedCategory];


  getTopHeadLines() async{
    //print('Cargando headlines...');

    final url = '$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=ar';

    final respuesta = await http.get(url);

    final newsResponse = newsResponseFromJson( respuesta.body );

    this.headLines.addAll( newsResponse.articles );

    notifyListeners();
  }

   getArticulsByCategory(String cat) async{
    //print('Cargando headlines...');

    if (this.categoryArticuls[cat].length > 0 ){
      this._isLoading = false;
      notifyListeners();
      return this.categoryArticuls[cat];
    }

    final url = '$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=ar&category=$cat';

    final respuesta = await http.get(url);

    final newsResponse = newsResponseFromJson( respuesta.body );

    this.categoryArticuls[cat].addAll( newsResponse.articles );
    this._isLoading = false;
    notifyListeners();
  }
   
}