import 'package:flutter/material.dart';
import 'package:pragma_app/src/services/service.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _service = Service();
  List<dynamic> _data = [];
  List<dynamic> _dataAux = [];
  int _currentItemCount = 0;
  final TextEditingController _searchController = TextEditingController();
  bool _isVisible = true;

  Widget _separator = const SizedBox(
    height: 10,
  );

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _getData() async {
    List<dynamic> newData = await _service.getData();
    setState(() {
      _data.addAll(newData);
      _dataAux.addAll(newData);
      _currentItemCount = _data.length;
      _isVisible = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
          child: Column(
            children: [
              const Text(
                "Catbreeds",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              _separator,
              search(),
              _separator,
              Expanded(child: listCards())
            ],
          ),
        ),
      ),
    );
  }

  Widget search() {
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        setState(() {
          _data = _dataAux;
          _data = _filterData(value);
        });
      },
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.search),
        fillColor: Colors.grey.shade100,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  List<dynamic> _filterData(String value) {
    if (value.isEmpty) {
      return _dataAux;
    } else {
      return _data
          .where((item) =>
              item['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
  }

  Widget listCards() {
    String text = '';

    return Stack(
      children: [
        ListView.builder(
          itemCount: _currentItemCount,
          itemBuilder: (BuildContext context, int index) {
            if (index >= _data.length) {
              return const SizedBox();
            } else {
              text =
                  "País Origen: ${_data[index]["origin"]}\nInteligencia: ${_data[index]["intelligence"]}\nAdaptabilidad: ${_data[index]["adaptability"]}\nTiempo de vida: ${_data[index]["life_span"]}";

              return catBreeed(
                  _data[index]["name"],
                  _data[index]["origin"],
                  _data[index]["cfa_url"]?.toString() ?? '',
                  _data[index]["intelligence"],
                  text,
                  _data[index]["description"]);
            }
          },
        ),
        Visibility(
            visible: _isVisible,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  _separator,
                  _separator,
                  Text('Preparando información...')
                ],
              ),
            ))
      ],
    );
  }

  Widget catBreeed(String name, String origin, String url, int intelligence,
      String text, String description) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("$name"),
                ),
                Expanded(child: Container()),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'information', arguments: {
                      'name': name,
                      'url': url,
                      'description': description,
                      'text': text
                    });
                  },
                  child: Text(
                    "Más...",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            FadeInImage(
              placeholder: AssetImage('assets/carga.gif'),
              image: NetworkImage(url),
              fit: BoxFit.cover,
            ),
            Row(
              children: [
                Text("$origin"),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("$intelligence"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
