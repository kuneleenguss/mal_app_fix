import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:mal_app_fix/data/anime_repository.dart';
import 'package:mal_app_fix/data/model.dart';
import 'package:mal_app_fix/features/favourites/cubit/favourites_model.dart';
import 'package:provider/provider.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer<FavouritesModel>(
                builder: (context, favourites, child) {
                  if (favourites.animeList.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 51),
                      child: Center(
                        child: Text(
                          "You have no favourites anime :(",
                          style: TextStyle(
                            color: Color.fromARGB(255, 160, 160, 160),
                          ),
                        ),
                      ),
                    );
                  } 
                  else {
                    return ListView.builder(
                        // shrinkWrap: true,
                        itemCount: favourites.animeList.length,
                        itemBuilder: (context, index) {
                            return ListTile(
                              style: ListTileStyle.drawer,
                              leading: Container(
                                width: 34,
                                child: Image(
                                  // Full size image below
                                  // fit: BoxFit.none,
                                  image: NetworkImage(favourites
                                      .animeList[index]!.imageUrl
                                      .toString()),
                                ),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    favourites.removeAnimeFromFavourites(index);
                                  },
                                  icon: const Icon(Icons.delete_outline)),
                              title: Text(favourites.animeList[index]!.title
                                  .toString()),
                              subtitle: Text(
                                  "${favourites.animeList[index]?.type} (${favourites.animeList[index]?.episodes} episodes) - ${(favourites.animeList[index]?.year == null) ? favourites.animeList[index]?.ifYearNull : favourites.animeList[index]?.year}"),
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
