import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:rate_your_music/Core/simple_card.dart';
import 'package:rate_your_music/Pages/album_page/album_page.dart';
import 'package:rate_your_music/Stores/music_collection_store.dart';

import '../../Stores/login_store.dart';

class MusicCollection extends StatefulWidget {
  const MusicCollection({super.key});
  @override
  State<StatefulWidget> createState() => _MusicCollectionState();
}

class _MusicCollectionState extends State<MusicCollection> {
  late MusicCollectionStore musicCollectionStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    musicCollectionStore = Provider.of<MusicCollectionStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          children: [
            for (var e in musicCollectionStore.albumsList)
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SimpleCard(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          InkWell(
                            child: const Image(
                              image: NetworkImage(
                                  'https://cdn1.ozone.ru/s3/multimedia-5/c1000/6025912553.jpg'),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AlbumPage())),
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
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
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
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
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
          ],
        ));
  }
}
