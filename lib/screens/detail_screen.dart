import 'package:flutter/material.dart';
import 'package:letmegrab_practical/models/news_model.dart';

class DetailScreen extends StatefulWidget {


  NewsModel newsModel;
  DetailScreen(this.newsModel,{Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.newsModel.title),
        ),
        body: MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaleFactor: 1.0, size: const Size(392.72, 838.90)),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Hero(
                    tag: widget.newsModel.id,

                    child: Image.network(
                      widget.newsModel.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.newsModel.title,
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.newsModel.content,
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "- ${widget.newsModel.author}",
                          style: TextStyle(
                              fontSize: 20,
                            color: Colors.blue
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
