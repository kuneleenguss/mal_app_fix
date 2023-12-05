import 'dart:async';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:mal_app_fix/data/anime_repository.dart';
import 'package:mal_app_fix/data/model.dart';
import 'package:mal_app_fix/features/search/cubit/search_model.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.all(8.0),
                      border: OutlineInputBorder(),
                      hintText: 'Search Anime...',
                    ),
                    onSubmitted: (value) async {
                      await context.read<SearchModel>().getAnimeBySearch(value);
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Consumer<SearchModel>(
                builder: (context, search, child) {
                  if (search.animeList.isEmpty && search.isLoading != true) {
                    return const Center(
                      child: Text(
                        "Type anime title in search field ...",
                        style: TextStyle(
                          color: Color.fromARGB(255, 160, 160, 160),
                        ),
                      ),
                    );
                  } else {
                    if (search.isLoading == true) {
                      return const Center(
                        child: CircularProgressIndicator()
                      );
                    }
                    return ListView.builder(
                        // shrinkWrap: true,
                        itemCount: search.animeList.length,
                        itemBuilder: (context, index) {
                          Anime anime = search.animeList[index];
                          return ListTile(
                            style: ListTileStyle.drawer,
                            leading: Container(
                              width: 34,
                              child: Image(
                                // Full size image below
                                // fit: BoxFit.none,
                                image: NetworkImage(anime.imageUrl.toString()),
                              ),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  search.addAnimeToFavourites(anime);
                                },
                                icon: Icon(
                                  (search.isFavourite(anime)) ? Icons.star : Icons.star_border,
                                  color: (search.isFavourite(anime)) ? const Color.fromRGBO(46, 81, 162, 1) : null,
                                  )),
                            title:
                                Text(anime.title.toString()),
                            subtitle: Text(
                                "${anime.type} (${anime.episodes} episodes) - ${(anime.year == null) ? anime.ifYearNull : anime.year}"),
                            isThreeLine: false,
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
