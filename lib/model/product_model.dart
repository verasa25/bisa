import 'package:belajar/model/product_repository.dart';
import 'package:get/get.dart';

class ProductModel extends GetxController {
  ProductRepository productRepository = ProductRepository();
  List product = [].obs;
  var showGrid = false.obs;
  var loading = false.obs;

  loadProductFromRepo(String categoryName) async {
    loading(true);
    product = await productRepository.loadProductFromApi(categoryName);
    loading(false);
  }

  toggleGrid() {
    showGrid(!showGrid.value);
  }
}
