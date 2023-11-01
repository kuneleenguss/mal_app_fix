import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mal_app_fix/features/favourites/favourites_page.dart';
import 'dart:io';
import 'data/anime_repository.dart';
import 'data/open_mal_api.dart';
import 'data/model.dart';
import 'features/search/search_page.dart';
import 'package:provider/provider.dart';
import 'features/search/cubit/search_model.dart';
import 'features/favourites/cubit/favourites_model.dart';

void main() async {
  
  // final AnimeRepository animeRepository = AnimeRepository();

  // final List<Anime> animeList = await animeRepository.getAnime("trigun");

  // print(animeList[0].title);

    // final box = await Hive.openBox<int>("anime_list");
  // await box.put("id", 123);

  // print(box.get("id"));
  if (!kIsWeb) await Hive.initFlutter();
  Hive.registerAdapter(AnimeAdapter());
  await Hive.openBox<Anime>("anime_list");
  
  runApp(
    Directionality(
          textDirection: TextDirection.rtl,
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => SearchModel()),
              ChangeNotifierProvider(create: (context) => FavouritesModel()),
            ],
            child: const MyApp(),
            ),
          ),
        );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //ChangeNotifierProvider здесь

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/search":(context) => SearchPage(),
        "/favourites":(context) => const FavouritesPage(),
        // "/info":(context) => const FavouritesPage(),
      },
      title: 'Flutter Demo',
      home: const MyAppView(),
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
    );
  }
}

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  int _selectedIndex = 0;
  
  final List<Widget> _widgets = <Widget>[
    SearchPage(),
    const FavouritesPage()
  ];

  void _onItemTapped (int index) {
    setState(() {
      _selectedIndex = index;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search"
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: "Favourites"
            )
        ],
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: const Color.fromARGB(255, 160, 160, 160),
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        ),
        
      body: _widgets[_selectedIndex],
    );
  }
}



