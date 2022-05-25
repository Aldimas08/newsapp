import 'package:flutter/material.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/screen/newpage.dart';
import 'package:newsapp/service/data_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    News news = News();
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
              image: NetworkImage(
                'https://baladena.id/wp-content/uploads/2020/01/profil-scaled.jpg',
              ),
            ),
          ),
          width: 10,
          margin: EdgeInsets.all(5),
        ),
        title: Text(
          'Good Morning',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.bookmark,
              color: Colors.blue,
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: news.getNews(),
        builder: (context, snapshot) => snapshot.data != null
        ? NewsPage(snapshot.data as List<Article>)
        : Center(
          child: CircularProgressIndicator(),
        )
      ),
    );
  }
}
