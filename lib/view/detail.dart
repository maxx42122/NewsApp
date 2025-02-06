import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/news_model.dart';

class NewsDetail extends StatelessWidget {
  final NewsModel newsModel;
  const NewsDetail({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool iswebview = constraints.maxWidth > 600;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: iswebview ? 50 : 8),
            child: ListView(
              children: [
                Text(
                  newsModel.title!,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: iswebview ? 24 : 18,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "- ${newsModel.author!}",
                    style: GoogleFonts.poppins(
                      fontSize: iswebview ? 18 : 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    newsModel.urlToImage!,
                    height: iswebview ? 400 : 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  newsModel.content!,
                  style: GoogleFonts.poppins(
                    fontSize: iswebview ? 20 : 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  newsModel.description!,
                  style: GoogleFonts.poppins(
                    fontSize: iswebview ? 18 : 14,
                    color: Colors.grey[700],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "- ${newsModel.publishedAt!}",
                    style: GoogleFonts.poppins(
                      fontSize: iswebview ? 18 : 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
