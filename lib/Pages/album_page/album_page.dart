import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:rate_your_music/Entities/dart_user.dart';
import 'package:rate_your_music/Entities/music_album.dart';
import 'package:rate_your_music/Entities/rating.dart';
import 'package:rate_your_music/Pages/home_page/home_page.dart';

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
    List<Rating> currrentRatingsList = widget.currentAlbum.Ratings;
    Iterable<Rating> ratingFromCurrentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.currentAlbum.BandName} - ${widget.currentAlbum.AlbumName}"),
      ),
      body: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image(
              alignment: Alignment.topCenter,
              image: NetworkImage(widget.currentAlbum.ImageUrl),
            ),
          ),
          const Center(child: Text("Рейтинг: 4.2 из 5.0 из 12345 оценок")),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
                child: Text("Жанры: ${widget.currentAlbum.Genres.first}")),
          ),
          Center(
            child: Material(
              child: Observer(
                builder: (context) => Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                  child: RatingBar.builder(
                      itemSize: 30,
                      initialRating: widget.currentAlbum.Ratings
                              .where((e) =>
                                  e.UserID ==
                                  Provider.of<DartUser?>(context,
                                          listen: false)!
                                      .id)
                              .isNotEmpty
                          ? widget.currentAlbum.Ratings
                              .where((e) =>
                                  e.UserID ==
                                  Provider.of<DartUser?>(context,
                                          listen: false)!
                                      .id)
                              .first
                              .Value
                          : 0,
                      minRating: 0.5,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                      onRatingUpdate: (value) => {
                            ratingFromCurrentUser = currrentRatingsList.where(
                                (item) =>
                                    item.UserID ==
                                    Provider.of<DartUser?>(context,
                                            listen: false)!
                                        .id),
                            if (ratingFromCurrentUser.isNotEmpty)
                              {
                                currrentRatingsList[currrentRatingsList
                                        .indexOf(ratingFromCurrentUser.first)] =
                                    Rating(
                                        value,
                                        Provider.of<DartUser?>(context,
                                                listen: false)!
                                            .id),
                              }
                            else
                              {
                                currrentRatingsList.add(Rating(
                                    value,
                                    Provider.of<DartUser?>(context,
                                            listen: false)!
                                        .id)),
                              },
                            FirebaseFirestore.instance
                                .collection('albums')
                                .doc(widget.currentAlbum.AlbumID)
                                .update({
                              'ratings': currrentRatingsList
                                  .map((e) => e.toMap())
                                  .toList()
                            }),
                            musicCollectionStore.update(widget.currentAlbum),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()))
                          }),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
