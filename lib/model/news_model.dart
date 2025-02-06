class CategoryModel {
  String? categoryName;
  String? categoryImage;

  CategoryModel({
    this.categoryName,
    this.categoryImage,
  });
}

class NewsModel {
  String? title;
  String? description;

  String? urlToImage;
  String? author;
  String? publishedAt;
  String? content;

  NewsModel({
    this.title,
    this.description,
    this.urlToImage,
    this.author,
    this.publishedAt,
    this.content,
  });
}
