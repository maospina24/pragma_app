import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  InformationPage({Key? key}) : super(key: key);

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  Widget _separator = const SizedBox(
    height: 10,
  );

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String name = arguments['name'];
    final String url = arguments['url'];
    final String description = arguments['description'];
    final String text = arguments['text'];

    return Scaffold(
      appBar: AppBar(
        title: Text("$name"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _container(url, description, text),
      ),
    );
  }

  Widget _container(String url, String description, String texto) {
    return Column(
      children: [
        Flexible(flex: 5, child: _imagen(url)),
        _separator,
        _separator,
        Flexible(
            flex: 5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "$texto",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  _separator,
                  Text(
                    "$description",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _imagen(String url) {
    return FadeInImage(
      placeholder: AssetImage('assets/carga.gif'),
      image: NetworkImage(url),
      fit: BoxFit.cover,
    );
  }
}
