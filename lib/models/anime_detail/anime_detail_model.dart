class AnimeDetailModel {
  final String title;
  final String studio;
  final num rating;
  final List<String> genres;
  final String synopsis;
  final String imageUrl;

  AnimeDetailModel({
    required this.title,
    required this.studio,
    required this.rating,
    required this.genres,
    required this.synopsis,
    required this.imageUrl,
  });
}
