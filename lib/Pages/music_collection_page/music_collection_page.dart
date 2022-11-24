import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rate_your_music/Core/simple_card.dart';

class MusicCollection extends StatelessWidget {
  const MusicCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...[1, 2, 3, 4, 5].map((e) => SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SimpleCard(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Image(
                          image: NetworkImage(
                              'https://cdn1.ozone.ru/s3/multimedia-5/c1000/6025912553.jpg'),
                        ),
                        const Text('Ночной проспект - Кислоты'),
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
                              const Text('Ваша оценка')
                            ],
                          ),
                        ),
                        SizedBox(
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
                              const Text('Общая оценка')
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
