import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/service/data_service.dart';
import 'package:newsapp/widget/news_item.dart';

class TabBarMenu extends StatefulWidget {
  final List<Article> article;

  TabBarMenu(this.article);

  @override
  State<TabBarMenu> createState() => _TabBarMenuState();
}

//kita akan menggunakan SingleTickerProviderStateMixin jika kita mempunyai satu animasi
class _TabBarMenuState extends State<TabBarMenu>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Technology'),
    Tab(text: 'Business'),
    Tab(text: 'Entertainment'),
    Tab(text: 'Health'),
    Tab(text: 'Science'),
    Tab(text: 'Sports'),
    Tab(text: 'General'),
  ];
  @override
  initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  Widget build(BuildContext context) {
    News news = News();
    return Container(
      height: MediaQuery.of(context)
          .size
          .height, //untuk mengatur tinggi container di hp yang digunakan
      child: Column(
        children: [
          TabBar(
            tabs: myTabs,
            controller: _tabController,
            labelColor: Colors.deepOrangeAccent,//untuk mengatur warna label tab
            unselectedLabelColor: Colors.black,//untuk mengatur warna label tab yang tidak terpilih
            indicatorSize: TabBarIndicatorSize.tab,//untuk mengatur ukuran indicator tab
            indicator: BubbleTabIndicator(
              indicatorColor: Colors.black,//untuk mengatur warna indicator tab
              indicatorHeight: 30.0,//untuk mengatur tinggi indicator tab
              tabBarIndicatorSize: TabBarIndicatorSize.tab,//untuk mengatur ukuran indicator tab
            ),
            isScrollable: true,//untuk mengatur apakah tab dapat di scroll
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController ,
              children: myTabs.map((Tab tab){
                // disni kita menggunakan future builder karena
                //kita bisa dengan mudah mendapatkan status dari proses
                //yang sedang kita jalankan, misalnya seperti
                //menampilkan loading saat memuat data
                //dari server menggunakan API, lalu menampilkan datanya
                //saat sudah siap dan di terima
                return FutureBuilder(
                  future: news.getNewsCategory(tab.text.toString()),
                  builder: (context, snapshot) => snapshot.data != null
                  ? _listNewsCategory(snapshot.data as List<Article>)//snapshot untuk meriksa ada data apa kga dan mksd dari as List<Article> adalah jika datanya ada akan menjadi List<Article>
                  : Center(child: CircularProgressIndicator(),)
                );
              }).toList(),
            )
          )
        ],
      ),
    );
  }

  Widget _listNewsCategory(List<Article> articles){
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListView.builder(
        itemBuilder: (context, index) => NewsItem(articles[index],),
        itemCount: articles.length,),
    );
  }
}
