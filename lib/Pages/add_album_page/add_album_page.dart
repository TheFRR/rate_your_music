import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rate_your_music/Entities/music_album.dart';
import 'package:rate_your_music/Pages/home_page/home_page.dart';
import 'package:rate_your_music/Pages/music_collection_page/music_collection_page.dart';
import 'package:rate_your_music/Stores/music_collection_store.dart';

class AddAlbum extends StatefulWidget {
  const AddAlbum({super.key});
  @override
  State<StatefulWidget> createState() => AddAlbumState();
}

class AddAlbumState extends State<AddAlbum> {
  late MusicCollectionStore musicCollectionStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    musicCollectionStore = Provider.of<MusicCollectionStore>(context);
  }

  final TextEditingController nameController =
      TextEditingController(text: 'Название альбома...');

  final TextEditingController bandController =
      TextEditingController(text: 'Исполнитель...');

  final TextEditingController genresController =
      TextEditingController(text: 'Жанры...');

  @override
  Widget build(BuildContext context) {
    MusicAlbum currentMusicAlbum;
    return ListView(children: [
      Wrap(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
            child: Text("Добавление альбома",
                style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
      Wrap(children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0, left: 10.0),
          child: Text("Шаг 1: название исполнителя"),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
              decoration:
                  const InputDecoration(suffixIcon: Icon(Icons.man_outlined)),
              controller: bandController,
              onChanged: (text) {
                setState(() {});
              }),
        ),
      ]),
      Wrap(children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0, left: 10.0),
          child: Text("Шаг 2: название альбома"),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(suffixIcon: Icon(Icons.title)),
            onChanged: (text) {
              setState(() {});
            },
          ),
        )
      ]),
      Wrap(children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0, left: 10.0),
          child: Text("Шаг 3: жанры"),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
              controller: genresController,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.music_note_rounded)),
              onChanged: (text) {
                setState(() {});
              }),
        )
      ]),
      Wrap(children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0, left: 10.0),
          child: Text("Шаг 4: обложка альбома"),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
              child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.black26),
                ),
                child: Image.network(
                    width: MediaQuery.of(context).size.width * 0.65,
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDpYgKX6Na9EAfhKgjLD4iyPugeNE0wggdkw&usqp=CAU"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Row(children: const [
                        Icon(Icons.image_outlined),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text("Выберите изображение"),
                        )
                      ])),
                ),
              )
            ],
          )),
        )
      ]),
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: ElevatedButton(
                onPressed: () => {
                      currentMusicAlbum = MusicAlbum(nameController.text,
                          bandController.text, [genresController.text]),
                      FirebaseFirestore.instance
                          .collection('albums')
                          .add(currentMusicAlbum.toMap()),
                      musicCollectionStore.add(nameController.text,
                          bandController.text, [genresController.text]),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()))
                    },
                child: const Center(
                  child: Text("Добавить альбом"),
                )),
          ),
        ),
      )
    ]);
  }
}
