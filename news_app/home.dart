import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:helloApp/news_app/article_view.dart';
import 'package:helloApp/news_app/category_news.dart';
import 'package:helloApp/news_app/helper/data.dart';
import 'package:helloApp/news_app/helper/news.dart';
import 'package:helloApp/news_app/models/article_model.dart';
import 'package:helloApp/news_app/models/category_model.dart';

class NewsApp extends StatefulWidget {
  @override
  _NewsAppState createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = List<ArticleModel>();
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
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
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal:12),
                child: Column(
                  children: <Widget>[
                    // categories.....
                    Container(
                        height:90,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                imageUrl: categories[index].imageUrl,
                                categoryName: categories[index].categoryName,
                              );
                            })),
                    // articles....
                    Container(
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
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,MaterialPageRoute(builder:(context)=>CategoryNews(
          category: categoryName.toLowerCase(),

        )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black26),
              child: Text(categoryName, style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
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
