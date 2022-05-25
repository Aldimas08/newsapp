import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/screen/detailpage.dart';
import 'package:newsapp/utils/utils.dart';

class CarouselWidget extends StatefulWidget {
  final List<Article> articleList;

  CarouselWidget(this.articleList);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late List<Widget> imageSlider;

  @override
  void initState() {
    //disini kita ingin memebuat widget sendiri bernama imageSlider
    //kemudian imageSlider tersebut akan berisikan list dari articleList
    //untuk mengkonversi daftar String di atas ke dalam daftar widget map ()
    //kita dapat menggunakan metode map() dan toList(). dengan metode map()
    //kita dapat mengunakan setiap string unutk menghasilkan widget ImageSlider baru
    //dan dengan metode toList ().
    //anda dapat mengonverensi objek Iterable yang dikemablikan oleh metode map ()
    //ke dalam objek List sebenarnya.
    imageSlider = widget.articleList.map((article) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                  article:
                      article), //article kiri berada di detail page dan di bagian required dan kanan berada di carousel widget
            ),
          );
        },
        child: Container(
            margin: EdgeInsets.all(10),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: NetworkImage(article.urlToImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [
                          0.1,
                          0.9,
                        ],
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.white.withOpacity(0.1),
                        ],
                      )),
                ),
                Positioned(
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          style: titleArticleHeadline.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          article.author,
                          style: authorDateArticleHeadline.copyWith(
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
      );
    }).toList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        items: imageSlider,
        options: CarouselOptions(
          autoPlay: true,
          viewportFraction: 0.8, // untuk gambar utama agar bisa melihat gambar lainnya
        )
      ),
    );
  }
}
