import 'package:flutter/material.dart';
import 'package:people_in_space/model/astronauts.dart';
import 'package:people_in_space/widgets/AstronautCard.dart';

class AstronautsList extends StatelessWidget {
  final List<Astronauts> astronauts;

  const AstronautsList({Key key, this.astronauts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: astronauts.length,
        itemBuilder: (context, index) {
          return AstronautCard(astronaut: astronauts[index]);
        });
  }
}
