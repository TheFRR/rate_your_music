import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:rate_your_music/Core/simple_card.dart';
import 'package:rate_your_music/Entities/dart_user.dart';
import 'package:rate_your_music/Entities/music_album.dart';
import 'package:rate_your_music/Entities/rating.dart';
import 'package:rate_your_music/Pages/album_page/album_page.dart';
import 'package:rate_your_music/Stores/music_collection_store.dart';

class MusicCollection extends StatefulWidget {
  const MusicCollection({super.key});
  @override
  State<StatefulWidget> createState() => _MusicCollectionState();
}

class _MusicCollectionState extends State<MusicCollection> {
  late MusicCollectionStore musicCollectionStore;
  late DartUser? currentUser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    musicCollectionStore = Provider.of<MusicCollectionStore>(context);
    currentUser = Provider.of<DartUser?>(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Material(child: Observer(builder: (context)
    {
      return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: getWidget() == null
              ? const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Center(child: Text("Вы ещё не оценивали альбомы...")))
              : Material(
                  child: Observer(
                    builder: ((context) =>
                        Wrap(children: getWidget() as List<Widget>)),
                  ),
                ));
    }
  }

  List<Widget>? getWidget() {
    List<Widget> widgetsToAdd = [];
    var user = currentUser;
    if (user != null) {
      for (var e in musicCollectionStore.albumsList) {
        var currentRatings = (e.Ratings as List)
            .where((rating) => rating.UserID == currentUser!.id);
        int numOfRates = e.Ratings.length;
        double generalRating = 0;
        for (var element in e.Ratings) {
          generalRating += element.Value;
        }
        generalRating /= numOfRates;
        if (currentRatings.isNotEmpty) {
          var currentRating = currentRatings.first;
          widgetsToAdd.add(Material(
            child: Observer(
              builder: (context) => SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SimpleCard(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Material(
                            child: Observer(
                              builder: (context) => InkWell(
                                child: Image(
                                  image: NetworkImage(e.ImageUrl),
                                ),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AlbumPage(e))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                                textAlign: TextAlign.center,
                                "${e.BandName} - ${e.AlbumName}"),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: Wrap(
                              spacing: 0,
                              children: [
                                RatingBar.builder(
                                  itemSize: 20,
                                  initialRating: currentRating.Value,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    //print(rating);
                                  },
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Text('Ваша оценка'))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              width: double.maxFinite,
                              child: Wrap(
                                children: [
                                  RatingBar.builder(
                                    itemSize: 20,
                                    initialRating: generalRating,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      //print(rating);
                                    },
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 5.0),
                                      child: Text('Общая оценка'))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ));
        }
      }
    }
    if (widgetsToAdd.isNotEmpty) return widgetsToAdd;
    return null;
  }
}
