import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Введите свой запрос...',
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
              style: TextStyle(fontWeight: FontWeight.bold), "История поиска"),
        ),
        Wrap(children: [
          ...[1, 2, 3].map((e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextFormField(
                readOnly: true,
                initialValue: "Бебра",
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.subdirectory_arrow_left)),
              ))),
        ])
      ],
    );
  }
}
