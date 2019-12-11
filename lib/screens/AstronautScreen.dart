import 'package:flutter/material.dart';
import 'package:people_in_space/model/astronauts.dart';
import 'package:http/http.dart' as http;
import 'package:people_in_space/widgets/AstronautsList.dart';


class AstronautScreen extends StatefulWidget {
  @override
  AstronautScreenState createState() => new AstronautScreenState();
}

class AstronautScreenState extends State<AstronautScreen> {

  _renderBody() {
    return FutureBuilder<List<Astronauts>>(
        future: fetchAstronauts(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? AstronautsList(astronauts: snapshot.data)
              : Center(child: CircularProgressIndicator());
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('People in Space'),
          backgroundColor: Colors.blue[900],
        ),
        body: _renderBody()
    );
  }
}
