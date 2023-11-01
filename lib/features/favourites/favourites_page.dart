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
                  } else {
                    return ListView.builder(
                        addAutomaticKeepAlives: true,
                        // shrinkWrap: true,
                        itemCount: favourites.animeList.length,
                        itemBuilder: (context, index) {
                          return FavouritesListTile(
                              favourites: favourites, index: index);
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

class FavouritesListTile extends StatefulWidget {
  final FavouritesModel favourites;
  final int index;
  const FavouritesListTile(
      {super.key, required this.favourites, required this.index});

  @override
  State<FavouritesListTile> createState() => _FavouritesListTileState();
}

class _FavouritesListTileState extends State<FavouritesListTile>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 150),
    vsync: this,
  );

  late final _animation = Tween(
    begin: 1.0,
    end: 0.0
  ).animate(_controller);

  // Future<void> _changeFade() async {
  //     await _controller.forward();
  //     widget.favourites.removeAnimeFromFavourites(widget.index);
  //     _controller.animateBack(0.0, duration: Duration.zero);
  //     // _controller.reverse();
  //     }

  void _changeFade() async {
      await _controller.forward();
      widget.favourites.removeAnimeFromFavourites(widget.index);
      _controller.animateBack(0.0, duration: Duration.zero);
      // _controller.reverse();
      }

  @override
  Widget build(BuildContext context) {
    final FavouritesModel favourites = widget.favourites;
    final int index = widget.index;

    return FadeTransition(
      opacity: _animation,
      child: ListTile(
        style: ListTileStyle.drawer,
        leading: Container(
          width: 34,
          child: Image(
            // Full size image below
            // fit: BoxFit.none,
            image:
                NetworkImage(favourites.animeList[index]!.imageUrl.toString()),
          ),
        ),
        trailing: IconButton(
          splashRadius: 35.0,
          splashColor: Colors.red[800],
            onPressed: () {
              _changeFade();
            },
            icon: const Icon(Icons.delete_outline)),
        title: Text(favourites.animeList[index]!.title.toString()),
        subtitle: Text(
            "${favourites.animeList[index]?.type} (${favourites.animeList[index]?.episodes} episodes) - ${(favourites.animeList[index]?.year == null) ? favourites.animeList[index]?.ifYearNull : favourites.animeList[index]?.year}"),
        isThreeLine: false,
        onTap: () {},
      ),
    );
  }
}
