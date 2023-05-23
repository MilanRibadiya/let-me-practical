import 'package:flutter/material.dart';
import 'package:letmegrab_practical/providers/home_provider.dart';
import 'package:letmegrab_practical/screens/detail_screen.dart';
import 'package:letmegrab_practical/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final postModel = Provider.of<HomeProvider>(context, listen: false);
    postModel.getNewsData();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Home Build");
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            title: const Text('Home Screen'),
            actions: [
              IconButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  final success = await prefs.remove('user');
                  if (success) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const Login()));
                  } else {
                    const snackBar =
                        SnackBar(content: Text('Something went to wrong'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                icon: const Icon(Icons.logout_rounded),
              ),
            ],
          ),
          body: MediaQuery(
            data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0, size: const Size(392.72, 838.90)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                        child: Consumer<HomeProvider>(builder:
                            (BuildContext context, value, Widget? child) {
                          return DropdownButtonFormField(
                            value: value.selectedCategory,
                            onChanged: (newValue){
                              value.changeCategory(newValue!);
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            items: value.category
                                .map(
                                  (e) => DropdownMenuItem(
                                value: e.toString(),
                                child: Text(
                                  e.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: true,
                                ),
                              ),
                            ).toList(),
                          );
                        }),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.black, width: 1)),
                        child: Consumer<HomeProvider>(
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return TextField(
                              controller: value.searchController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: EdgeInsets.all(15),
                                hintText: 'Search Detail',
                                suffixIcon: Icon(
                                  Icons.search,
                                  size: 30,
                                ),
                              ),
                              onChanged: (val) {
                                value.searchNews();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Consumer<HomeProvider>(
                    builder: (BuildContext context, value, Widget? child) {
                      if (value.news.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (value.searchedList.isEmpty) {
                        return Center(child: const Text('No Data Found'));
                      } else {
                        return ListView.builder(
                          itemCount: value.searchedList.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: width*0.03),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                            value.searchedList
                                                .elementAt(index)),
                                      ));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Container(
                                    width: double.infinity,
                                    height: width*0.23,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8,vertical: 6),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Hero(
                                              tag: value.searchedList
                                                  .elementAt(index)
                                                  .id,
                                              child: Image.network(
                                                value.searchedList
                                                    .elementAt(index)
                                                    .imageUrl,
                                                width: width*0.3,
                                                height: width*0.2,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.55,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                value.searchedList
                                                    .elementAt(index)
                                                    .title,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    overflow: TextOverflow
                                                        .ellipsis),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                value.searchedList
                                                    .elementAt(index)
                                                    .content,
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                maxLines: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
    ));
  }
}
