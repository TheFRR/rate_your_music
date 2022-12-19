// ignore_for_file: non_constant_identifier_names

class MusicAlbum {
  String AlbumName = "";
  String BandName = "";
  List<String> Genres = [];

  MusicAlbum(String albumName, String bandName, List<String> genres) {
    AlbumName = albumName;
    BandName = bandName;
    Genres = genres;
  }

  MusicAlbum._(
      {required this.AlbumName, required this.BandName, required this.Genres});

  factory MusicAlbum.fromJson(Map<String, dynamic> data) {
    return MusicAlbum._(
        AlbumName: data['albumName'] as String,
        BandName: data['bandName'] as String,
        Genres: data['genres'].cast<String>());
  }

  Map<String, dynamic> toMap() {
    return {'albumName': AlbumName, 'bandName': BandName, 'genres': Genres};
  }
}
