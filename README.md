# Anime List App Example

An example of my Flutter app using [MyAnimeList API](https://docs.api.jikan.moe/).



https://github.com/kuneleenguss/mal_app_fix/assets/109430656/4d9250a0-a494-48af-a426-91b0f4c30fc7

## Supported features
:rice_ball: Search by name

:rice_ball: Add to Favourites

:rice_ball: Save Favourites to local storage

## App Structure
Feature-first structure based on 2 features atm: Search and Favourites.

### Data folder
The data folder contains all necessary shit that is used to fetch/parse requests from the [MyAnimeList API](https://docs.api.jikan.moe/).

Especially `AnimeRepository` is responsible for fetching data from the [MyAnimeList API](https://docs.api.jikan.moe/) and providing the parsed result.
```java
class AnimeRepository {

  final OpenMalApi _api = OpenMalApi();

  Future<List<Anime>> getAnimeBySearch(String queue) async {
    final response = await http.get(_api.getUri(queue));
    final List<dynamic> parsedResult = jsonDecode(response.body)["data"];

    final List<Anime> animeList = List.generate(
        parsedResult.length, 
        (index) => Anime.fromJson(parsedResult[index])
      );

    return animeList;
  }
}
```

### Features folder
Each of features folders contains model files based on ChangeNotifier that does all logic and presentation files that define UI.

## Packages used
- [provider](https://pub.dev/packages/provider) for managing state
- [http](https://pub.dev/packages/http) for talking to REST API
- [Hive](https://pub.dev/packages/hive) for saving anime list to local storage
