import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helloApp/news_app/article_view.dart';
import 'package:helloApp/news_app/helper/data.dart';
import 'package:helloApp/news_app/helper/news.dart';
import 'package:helloApp/news_app/home.dart';
import 'package:helloApp/news_app/models/article_model.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = List<ArticleModel>();
  bool _loading = true;
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Flutter"),
              Text(
                "News",
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: _loading
            ? Center(
                child: Container(
                child: CircularProgressIndicator(),
              ))
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  padding: EdgeInsets.only(top: 10),
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      //scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: articles.length,
                      // ignore: missing_return
                      itemBuilder: (context, index) {
                        return BlogTile(
                            imageUrl: articles[index].urlToImage,
                            title: articles[index].title,
                            desc: articles[index].description,
                            url: articles[index].url);
                      }),
                ),
              ));
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc , url;

  BlogTile(
      {@required this.imageUrl, @required this.title, @required this.desc , @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleView(
            blogUrl: url,
        )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom:15),
        //padding: EdgeInsets.only(bottom:20),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(imageUrl)),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(title,
                  style: TextStyle(color: Colors.black87, fontSize: 18)),
            ),
            Text(desc)
          ],
        ),
      ),
    );
  }
}

