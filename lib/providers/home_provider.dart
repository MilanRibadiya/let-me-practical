import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:letmegrab_practical/models/news_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeProvider extends ChangeNotifier{

    List<NewsModel> news=[];
    List<NewsModel> searchedList=[];
    TextEditingController searchController=TextEditingController();
    String selectedCategory="all";
    var category=[
        "all",
        "automobile",
        "business",
        "entertainment",
        "hatke",
        "miscellaneous",
        "national",
        "politics",
        "science",
        "sports",
        "startup",
        "technology",
        "world",
    ];


    getNewsData() async{
        debugPrint("getNews");
        news.clear();
        searchedList.clear();
        news = (await fetchNews());
        searchedList=news;

        notifyListeners();
    }

    void searchNews(){
        if(searchController.text.trim().isEmpty){
            searchedList=news;
            notifyListeners();
        }else{
            searchedList=news.where((element) => element.title.toLowerCase().contains(searchController.text.trim().toLowerCase())).toList();
            notifyListeners();
        }
    }

    void changeCategory(String cat){
        searchController.clear();
        selectedCategory=cat;
        notifyListeners();
        getNewsData();
    }


    Future<List<NewsModel>> fetchNews() async{
        http.Response response = await http.get(Uri.parse("https://inshorts.deta.dev/news?category=$selectedCategory"),headers: {"Content-Type": "application/json"});
        List result = jsonDecode(response.body)['data'];
        return result.map((e) => NewsModel.fromJson(e)).toList();
    }
}
