import 'package:flutter/material.dart';
import 'package:news_provider/src/models/news_models.dart';

class ListNoticias extends StatelessWidget {
  final List<Article> noticias;

  const ListNoticias(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(this.noticias[index].title);
      },
    );
  }
}
