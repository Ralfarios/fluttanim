import 'package:dio/dio.dart';
import 'package:fluttanim/models/anime_list/anime_list_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class MalServices {
  static Future<List<AnimeListModel>?> getList() async {
    String accessToken = dotenv.get('ACCESS_TOKEN');
    String baseUrl = dotenv.get('BASE_URL');
    Dio dio = Dio();

    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    try {
      var res = await dio
          .get('$baseUrl/anime/ranking?ranking_type=all&limit=10&fields=mean');

      if (res.statusCode == 200) {
        var data = res.data['data'];
        List<AnimeListModel> animeList = [];

        for (var el in data) {
          AnimeListModel animeListModel = AnimeListModel(
              title: el['node']['title'],
              imageUrl: el['node']['main_picture']['medium'],
              id: el['node']['id'],
              rating: el['node']['mean']);
          animeList.add(animeListModel);
        }

        return animeList;
        // return res.data['data'].map((e) => AnimeListModel(
        //     title: e['node']['title'],
        //     imageUrl: e['node']['main_picture']['medium'],
        //     id: e['node']['id'],
        //     rating: e['node']['mean']));
      }

      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
