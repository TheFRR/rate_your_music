import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rate_your_music/Entities/dart_user.dart';
import 'package:rate_your_music/Entities/music_album.dart';
import 'package:rate_your_music/Entities/rating.dart';
import 'package:rate_your_music/Pages/home_page/home_page.dart';
import 'package:rate_your_music/Pages/music_collection_page/music_collection_page.dart';
import 'package:rate_your_music/Stores/music_collection_store.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as path;

class AddAlbum extends StatefulWidget {
  const AddAlbum({super.key});
  @override
  State<StatefulWidget> createState() => AddAlbumState();
}

class AddAlbumState extends State<AddAlbum> {
  late MusicCollectionStore musicCollectionStore;

  io.File? image;

  String imageUrl = "";
  var ref;
  var downloadUrl;

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
    final DartUser? user = Provider.of<DartUser?>(context);
    final picker = ImagePicker();
    String id;
    var uploadTask;
    var firebaseStorageRef;
    String fileName;
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
                child: image == null
                    ? Image.network(
                        width: MediaQuery.of(context).size.width * 0.65,
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDpYgKX6Na9EAfhKgjLD4iyPugeNE0wggdkw&usqp=CAU")
                    : Image.file(image as io.File,
                        width: MediaQuery.of(context).size.width * 0.65),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: ElevatedButton(
                      onPressed: () async {
                        final pickedFile =
                            await picker.getImage(source: ImageSource.gallery);
                        final io.File _image = io.File(pickedFile!.path);
                        setState(() {
                          image = _image;
                        });
                      },
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
                onPressed: () async => {
                      fileName = path.basename(image!.path),
                      firebaseStorageRef = FirebaseStorage.instance,
                      ref = firebaseStorageRef.ref().child(
                          'upload/$fileName' + DateTime.now().toString()),
                      uploadTask = ref.putFile(image!),
                      downloadUrl = await uploadTask,
                      imageUrl = await downloadUrl.ref.getDownloadURL(),
                      id = FirebaseFirestore.instance
                          .collection('albums')
                          .doc()
                          .id,
                      currentMusicAlbum = MusicAlbum(
                          id,
                          nameController.text,
                          bandController.text,
                          [genresController.text],
                          [Rating(0, user!.id)],
                          imageUrl),
                      FirebaseFirestore.instance
                          .collection('albums')
                          .doc(id)
                          .set(currentMusicAlbum.toMap()),
                      musicCollectionStore.add(currentMusicAlbum),
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
