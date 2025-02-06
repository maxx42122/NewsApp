import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/api_binding/api_binding.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/view/detail.dart';
import 'package:news_app/view/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/category_model.dart';
import 'category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<NewsModel> articles = [];
  List<CategoryModel> categories = [];
  bool isLoadin = true;

  getNews() async {
    NewsApi newsApi = NewsApi();
    await newsApi.getNews();
    articles = newsApi.dataStore;
    setState(() {
      isLoadin = false;
    });
  }

  @override
  void initState() {
    categories = getCategories();
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool iswebview = constraints.maxWidth > 600;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "News App",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  logout(context);
                },
                child: const Icon(Icons.logout_rounded),
              ),
              const SizedBox(width: 15),
            ],
          ),
          body: isLoadin
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: iswebview ? 50 : 15, vertical: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: iswebview
                              ? MediaQuery.of(context).size.height * 0.3
                              : MediaQuery.of(context).size.height * 0.2,
                          child: ListView.builder(
                            itemCount: categories.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SelectedCategoryNews(
                                              category: category.categoryName!),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.blue,
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            category.categoryImage.toString(),
                                            fit: BoxFit.contain,
                                            height: iswebview ? 80 : 60,
                                            width: iswebview ? 80 : 60,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            category.categoryName!,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: iswebview ? 20 : 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        iswebview
                            ? GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 1.5,
                                ),
                                itemCount: articles.length,
                                itemBuilder: (context, index) {
                                  return _Card(articles[index]);
                                },
                              )
                            : ListView.builder(
                                itemCount: articles.length,
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return _Card(articles[index]);
                                },
                              ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _Card(NewsModel article) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetail(newsModel: article),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                article.urlToImage!,
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              article.title!,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Divider(thickness: 1),
          ],
        ),
      ),
    );
  }
}

void logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => Loginscreen(),
    ),
  );
}
