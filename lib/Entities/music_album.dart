// ignore_for_file: non_constant_identifier_names

import 'package:rate_your_music/Entities/rating.dart';

class MusicAlbum {
  String AlbumID = "";
  String AlbumName = "";
  String BandName = "";
  String ImageUrl = "";
  List<String> Genres = [];
  List<Rating> Ratings = [];

  MusicAlbum(String albumID, String albumName, String bandName,
      List<String> genres, List<Rating> ratings, String imageUrl) {
    AlbumID = albumID;
    AlbumName = albumName;
    BandName = bandName;
    Genres = genres;
    Ratings = ratings;
    ImageUrl = imageUrl;
  }

  MusicAlbum._(
      {required this.AlbumID,
      required this.AlbumName,
      required this.BandName,
      required this.Genres,
      required this.Ratings,
      required this.ImageUrl});

  factory MusicAlbum.fromJson(Map<String, dynamic> data) {
    return MusicAlbum._(
        AlbumID: data['albumID'] as String,
        AlbumName: data['albumName'] as String,
        BandName: data['bandName'] as String,
        ImageUrl: data['imageUrl'] as String,
        Genres: data['genres'].cast<String>(),
        Ratings:
            (data['ratings'] as List).map((e) => Rating.fromJson(e)).toList());
  }

  Map<String, dynamic> toMap() {
    return {
      'albumID': AlbumID,
      'albumName': AlbumName,
      'imageUrl': ImageUrl,
      'bandName': BandName,
      'genres': Genres,
      'ratings': Ratings.map((e) => e.toMap()).toList()
    };
  }
}
