class NewsModel{
  final String author;
  final String content;
  final String date;
  final String id;
  final String imageUrl;
  final String readMoreUrl;
  final String time;
  final String title;
  final String url;

  NewsModel(
      {required this.author,
      required this.content,
      required this.date,
      required this.id,
      required this.imageUrl,
      required this.readMoreUrl,
      required this.time,
      required this.title,
      required this.url});

  factory NewsModel.fromJson(Map<String,dynamic> json){
    return NewsModel(author: json["author"].toString(), content: json["content"].toString(), date: json["date"].toString(), id: json["id"].toString(), imageUrl: json["imageUrl"].toString(), readMoreUrl: json["readMoreUrl"].toString(), time: json["time"].toString(), title: json["title"].toString(), url: json["url"].toString());
  }

}