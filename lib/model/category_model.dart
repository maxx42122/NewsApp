import 'news_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = [];

  CategoryModel category = CategoryModel();
  category.categoryName = "Science";
  category.categoryImage = "assets/microscope.png";

  categories.add(category);

  category = CategoryModel();
  category.categoryName = "Sports";
  category.categoryImage = "assets/sports.png";

  categories.add(category);

  category = CategoryModel();
  category.categoryName = "Business";
  category.categoryImage = "assets/buisness-advice.png";

  categories.add(category);

  category = CategoryModel();
  category.categoryName = "General";
  category.categoryImage = "assets/book.png";
  categories.add(category);

  category = CategoryModel();
  category.categoryName = "Health";
  category.categoryImage = "assets/health-insurance (3).png";

  categories.add(category);

  category = CategoryModel();
  category.categoryName = "Entertainment";
  category.categoryImage = "assets/digital.png";

  categories.add(category);

  return categories;
}
