import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddAlbum extends StatelessWidget {
  const AddAlbum({super.key});

  @override
  Widget build(BuildContext context) {
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
            initialValue: "Бебра",
            decoration:
                const InputDecoration(suffixIcon: Icon(Icons.man_outlined)),
          ),
        )
      ]),
      Wrap(children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0, left: 10.0),
          child: Text("Шаг 2: название альбома"),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            initialValue: "Бебра",
            decoration: const InputDecoration(suffixIcon: Icon(Icons.title)),
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
            initialValue: "Бебра",
            decoration: const InputDecoration(
                suffixIcon: Icon(Icons.music_note_rounded)),
          ),
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
                onPressed: () {},
                child: const Center(
                  child: Text("Добавить альбом"),
                )),
          ),
        ),
      )
    ]);
  }
}
