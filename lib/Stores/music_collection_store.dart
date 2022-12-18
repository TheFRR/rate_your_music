import 'package:mobx/mobx.dart';
import 'package:rate_your_music/Entities/music_album.dart';
part 'music_collection_store.g.dart';

// ignore: library_private_types_in_public_api
class MusicCollectionStore = _MusicCollectionStoreBase
    with _$MusicCollectionStore;

abstract class _MusicCollectionStoreBase with Store {
  final albumsList = ObservableList.of([
    MusicAlbum("Кислоты", "Ночной проспект", ["Post-Punk", "Post-Industrial"]),
    MusicAlbum("Сахар", "Ночной проспект", ["Post-Punk", "Post-Industrial"])
  ]);

  @action
  void add() {
    albumsList.add(MusicAlbum(
        "Асбастос", "Ночной проспект", ["Post-Punk", "Post-Industrial"]));
  }
}
