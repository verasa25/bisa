import 'package:belajar/model/categori_repository.dart';
import 'package:belajar/model/product_model.dart';
import 'package:get/get.dart';

ProductModel productModel = ProductModel();

class CategoriesController extends GetxController {
  CategoriesRepository categoriesRepository = CategoriesRepository();
  var categories = [].obs;
  var currentIndex = 0.obs;
  var loading = false.obs;

  CategoriesController() {
    loadCategories();
  }

  loadCategories() async {
    loading(true);
    var tcategories = await categoriesRepository.loadCategoriesFromApi();
    categories(tcategories);
    if (categories.isNotEmpty) {
      await productModel.loadProductFromRepo(categories[currentIndex.value]);
    }
    loading(false);
  }

  changeCategories(index) async {
    currentIndex(index);
    await productModel.loadProductFromRepo(categories[index]);
  }
}
