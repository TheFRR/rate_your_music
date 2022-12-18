import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ночной проспект - Кислоты'),
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
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Center(child: Text("Жанры: Post-Punk, Post-Industrial")),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 8.0),
              child: RatingBar.builder(
                itemSize: 30,
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (double value) {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
