class Article {
  String author;
  String title;
  String content;
  String urlToImage;
  String publishedAt;

  Article(
      {required this.author,
      required this.title,
      required this.content,
      required this.urlToImage,
      required this.publishedAt});

  //!memetakan json object ke model
  factory Article.fromJson(Map<String, dynamic> json) => Article( //factory 
        author: json["author"] ?? "Null",
        title: json["title"] ?? "Null",//*jika keynya null dan kita harus mengisinya gunakan kode ini
        content: json["content"] ?? "Null",
        publishedAt: json["publishedAt"] ?? "Null",
        urlToImage: json["urlToImage"] ?? "https://www.btklsby.go.id/images/placeholder/basic.png",
      );
}
