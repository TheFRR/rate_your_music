import 'package:mobx/mobx.dart';
import 'package:rate_your_music/Entities/music_album.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'music_collection_store.g.dart';

// ignore: library_private_types_in_public_api
class MusicCollectionStore = _MusicCollectionStoreBase
    with _$MusicCollectionStore;

abstract class _MusicCollectionStoreBase with Store {
  ObservableList albumsList = ObservableList<MusicAlbum>.of([]);
  Map ratingsDict = <MusicAlbum, double>{};

  _MusicCollectionStoreBase() {
    var collection = FirebaseFirestore.instance.collection('albums');
    collection.get().then((value) {
      for (var item in value.docs) {
        albumsList.add(MusicAlbum.fromJson(item.data()));
      }
    });
  }

  @action
  void add(String albumName, String bandName, List<String> genres) {
    albumsList.add(MusicAlbum(albumName, bandName, genres));
  }

  @action
  void update(MusicAlbum album) {
    albumsList.firstWhere((element) => element == album).BandName = "Floppa";
  }
}
