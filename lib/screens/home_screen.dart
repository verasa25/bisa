import 'package:belajar/model/categori_model.dart';
import 'package:belajar/screens/halaman_setting.dart';
import 'package:belajar/screens/keranjang_screen.dart';
import 'package:belajar/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoriesController categoriesController = CategoriesController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: Obx(
        () {
          if (categoriesController.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (categoriesController.categories.isEmpty) {
            return const Center(child: Text("Kategori tidak dapat ditemukan"));
          }
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                _buildTop(),
                _buildCategoriesRow(),
                Expanded(
                  child: Obx(
                    () {
                      if (productModel.loading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (productModel.product.isEmpty) {
                        return const Center(
                            child: Text("Produk tidak dapat ditemukan."));
                      }

                      if (productModel.showGrid.value) {
                        return GridView.builder(
                          padding: const EdgeInsets.only(top: 16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: productModel.product.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Container(
                                height: 120,
                                margin: const EdgeInsets.only(bottom: 9),
                                padding: const EdgeInsets.all(13),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            productModel.product[index]
                                                ["image"],
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              productModel.product[index]
                                                  ["title"],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Expanded(
                                              child: Text(
                                                productModel.product[index]
                                                    ["description"],
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              "\$${productModel.product[index]["price"]}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return _buildProductList();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 100),
          ListTile(
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KeyboardVisibilityProvider(
                      child: HalamanSetting(),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.person),
            ),
            title: const Text(
              'Profil',
              style: TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KeyboardVisibilityProvider(
                      child: LoginScreen(),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.logout),
            ),
            title: const Text(
              'Keluar',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'TOKOKU',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 30,
          fontFamily: 'NexaBold',
        ),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CartPage(),
            ));
          },
          icon: const Icon(Icons.shopping_cart_outlined),
        ),
      ],
    );
  }

  Row _buildTop() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Pencarian',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            productModel.toggleGrid();
          },
          icon: const Icon(Icons.filter_list),
        ),
      ],
    );
  }

  Container _buildCategoriesRow() {
    return Container(
      margin: const EdgeInsets.only(top: 18),
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesController.categories.length,
        itemBuilder: (context, index) => Obx(
          () => InkWell(
            onTap: () {
              categoriesController.changeCategories(index);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                color: index == categoriesController.currentIndex.value
                    ? Colors.black
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Text(
                categoriesController.categories[index],
                style: TextStyle(
                  color: index == categoriesController.currentIndex.value
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ListView _buildProductList() {
    return ListView.builder(
      itemCount: (productModel.product.length),
      padding: const EdgeInsets.only(top: 16),
      itemBuilder: (context, index) => Card(
        child: Container(
          height: 120,
          margin: const EdgeInsets.only(bottom: 9),
          padding: const EdgeInsets.all(13),
          child: Row(
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      productModel.product[index]["image"],
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModel.product[index]["title"],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                        child: Text(
                          productModel.product[index]["description"],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "\$${productModel.product[index]["price"]}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
