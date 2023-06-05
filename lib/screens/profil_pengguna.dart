import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  // const UsersPage(String imgPath, {super.key});
  // ignore: prefer_typing_uninitialized_variables
  final heroTag;
  const UsersPage(this.heroTag, {super.key});
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Hero(
              tag: widget.heroTag,
              child: Image(
                image: AssetImage(widget.heroTag),
              )),
        ),
      ),
    );
  }
}
