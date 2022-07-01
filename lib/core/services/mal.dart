import 'package:dio/dio.dart';
import 'package:fluttanim/models/anime_detail/anime_detail_model.dart';
import 'package:fluttanim/models/anime_list/anime_list_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class MalServices {
  static String accessToken = dotenv.get('ACCESS_TOKEN');
  static String baseUrl = dotenv.get('BASE_URL');
  static Dio dio = Dio();

  static Future<List<AnimeListModel>?> getList() async {
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
      }

      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<AnimeDetailModel?> getDetail(int id) async {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    try {
      var res = await dio.get(
          '$baseUrl/anime/${id.toString()}?fields=id,title,main_picture,alternative_titles,start_date,end_date,synopsis,mean,rank,popularity,num_list_users,num_scoring_users,nsfw,created_at,updated_at,media_type,status,genres,my_list_status,num_episodes,start_season,broadcast,source,average_episode_duration,rating,pictures,background,related_anime,related_manga,recommendations,studios,statistics');

      List<String> genres = [];

      for (var i in res.data['genres']) {
        genres.add(i['name']);
      }

      // List<String> genres = res.data['genres'].map((e) => e['name']);

      return AnimeDetailModel(
          title: res.data['title'],
          studio: res.data['studios'][0]['name'],
          rating: res.data['mean'],
          genres: genres,
          synopsis: res.data['synopsis'],
          imageUrl: res.data['main_picture']['large']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
