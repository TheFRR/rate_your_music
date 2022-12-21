import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rate_your_music/Entities/music_album.dart';
import 'package:rate_your_music/Pages/album_page/album_page.dart';
import 'package:rate_your_music/Stores/music_collection_store.dart';

class Search extends StatefulWidget {
  const Search({super.key});
  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late MusicCollectionStore musicCollectionStore;

  late TextEditingController requestBandController;
  late TextEditingController requestNameController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    musicCollectionStore = Provider.of<MusicCollectionStore>(context);
  }

  @override
  void initState() {
    super.initState();
    requestBandController = TextEditingController();
    requestNameController = TextEditingController();
  }

  bool equalsIgnoreCase(String string1, String string2) {
    return string1.toLowerCase() == string2.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: TextField(
              controller: requestBandController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Исполнитель...',
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 5),
              child: TextField(
                controller: requestNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Альбом...',
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: ElevatedButton(
                    onPressed: () {
                      var item = musicCollectionStore.albumsList
                          .where((element) =>
                              equalsIgnoreCase(element.AlbumName,
                                  requestNameController.text) &&
                              equalsIgnoreCase(
                                  element.BandName, requestBandController.text))
                          .toList();
                      if (item.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AlbumPage(item.first)));
                      } else {
                        Fluttertoast.showToast(
                            msg: "Ничего не найдено...",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    child: const Center(
                      child: Text("Найти альбом"),
                    )),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
                style: TextStyle(fontWeight: FontWeight.bold),
                "История поиска"),
          ),
          Wrap(children: [
            ...[1, 2, 3].map((e) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextFormField(
                  readOnly: true,
                  initialValue: e.toString(),
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.subdirectory_arrow_left)),
                ))),
          ])
        ],
      ),
    ]);
  }
}
