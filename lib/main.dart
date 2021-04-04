import 'package:flutter/material.dart';
import 'package:news_provider/src/pages/tabs_page.dart';
import 'package:news_provider/src/services/news_service.dart';
import 'package:news_provider/src/theme/tema.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Envolvemos con el widget MultiProviders que nos permite tener varias
    // instancias de provider en nuestra app
    return MultiProvider(
      providers: [
        // EL provider espera que algun widget lo necesite para crear la instancia
        ChangeNotifierProvider(create: (_) => NewsService()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: miTema,
          title: 'Material App',
          home: TabsPage()),
    );
  }
}
