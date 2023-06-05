import 'package:belajar/screens/profil_pengguna.dart';
import 'package:flutter/material.dart';

String imgPath = 'assets/images/gambar.png';

class HalamanSetting extends StatelessWidget {
  const HalamanSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: const Text(
          "DATA PROFIL",
        ),
        centerTitle: true,
      ),
      // ignore: sized_box_for_whitespace
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UsersPage(imgPath)));
                },
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Hero(
                    tag: imgPath,
                    child: Image.asset(imgPath),
                  ),
                  // ignore: sized_box_for_whitespace
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
