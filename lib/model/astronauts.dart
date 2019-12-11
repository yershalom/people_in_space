import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

String url =
    'https://www.howmanypeopleareinspacerightnow.com/peopleinspace.json';

Future<List<Astronauts>> fetchAstronauts(http.Client client) async {
  final response = await client.get(url);

  return compute(parseAstronauts, response.body);
}

List<Astronauts> parseAstronauts(String responseBody) {
  final parsed =
  json.decode(responseBody)['people'].cast<Map<String, dynamic>>();

  return parsed
      .map<Astronauts>((json) => Astronauts.fromJson(json))
      .toList();
}

class Astronauts {
  final String name;
  final String biophoto;
  final int biophotowidth;
  final int biophotoheight;
  final String country;
  final String countryflag;
  final String launchdate;
  final int careerdays;
  final String title;
  final String location;
  final String bio;
  final String biolink;
  final String twitter;
  final String daysinspace;

  Astronauts({this.name,
    this.biophoto,
    this.biophotowidth,
    this.biophotoheight,
    this.country,
    this.countryflag,
    this.launchdate,
    this.careerdays,
    this.title,
    this.location,
    this.bio,
    this.biolink,
    this.twitter,
    this.daysinspace});

  factory Astronauts.fromJson(Map<String, dynamic> json) {
    final date2 = DateTime.now();
    final _launchdate = DateTime.parse(json['launchdate']);
    final daysinspace = date2.difference(_launchdate).inDays.toString();
    return Astronauts(
        name: json['name'],
        biophoto: json['biophoto'],
        biophotowidth: json['biophotowidth'],
        biophotoheight: json['biophotoheight'],
        country: json['country'],
        countryflag: json['countryflag'],
        launchdate: json['launchdate'],
        careerdays: json['careerdays'],
        title: json['title'],
        location: json['location'],
        bio: json['bio'],
        biolink: json['biolink'],
        twitter: json['twitter'],
        daysinspace: daysinspace);
  }
}
