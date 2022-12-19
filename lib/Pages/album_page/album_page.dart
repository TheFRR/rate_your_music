import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:rate_your_music/Entities/music_album.dart';

import '../../Stores/music_collection_store.dart';

// ignore: must_be_immutable
class AlbumPage extends StatefulWidget {
  AlbumPage(this.currentAlbum, {super.key});
  late MusicAlbum currentAlbum;
  @override
  State<StatefulWidget> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late MusicCollectionStore musicCollectionStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    musicCollectionStore = Provider.of<MusicCollectionStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.currentAlbum.BandName} - ${widget.currentAlbum.AlbumName}"),
      ),
      body: Wrap(
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Image(
              alignment: Alignment.topCenter,
              image: NetworkImage(
                  'https://cdn1.ozone.ru/s3/multimedia-5/c1000/6025912553.jpg'),
            ),
          ),
          const Center(child: Text("Рейтинг: 4.2 из 5.0 из 12345 оценок")),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
                child: Text("Жанры: ${widget.currentAlbum.Genres.first}")),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 8.0),
              child: RatingBar.builder(
                itemSize: 30,
                initialRating: 0,
                minRating: 0.5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (_) =>
                    musicCollectionStore.update(widget.currentAlbum),
              ),
            ),
          )
        ],
      ),
    );
  }
}
