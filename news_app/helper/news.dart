import 'dart:convert';

//import 'package:helloApp/news_app/article_view.dart';
//import 'package:flutter/cupertino.dart';
import 'package:helloApp/news_app/models/article_model.dart';
//import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=b58bf17ea7d34e73b32a2e3e4f79b8b1";

    var response = await http.get(url);

    var jasonData = jsonDecode(response.body);
    if (jasonData["status"] == "ok") {
      jasonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
              author: element["author"],
              title: element["title"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["context"]);
          news.add(articleModel);
        }
      });
    }
  }
}


class CategoryNewsClass{
  List<ArticleModel> news = [];
  Future<void> getNews(String category) async {
    String url =
        "http://newsapi.org/v2/top-headlines?category=$category&country=in&category=business&apiKey=b58bf17ea7d34e73b32a2e3e4f79b8b1";

    var response = await http.get(url);

    var jasonData = jsonDecode(response.body);
    if (jasonData["status"] == "ok") {
      jasonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
              author: element["author"],
              title: element["title"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["context"]);
          news.add(articleModel);
        }
      });
    }
  }
}

