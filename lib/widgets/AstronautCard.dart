import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:people_in_space/model/astronauts.dart';

final baseTextStyle = const TextStyle(fontFamily: 'Poppins');

final headerTextStyle = baseTextStyle.copyWith(
  color: Colors.black,
  fontSize: 20.0,
  fontWeight: FontWeight.w600,
);

class AstronautCard extends StatelessWidget {
  final Astronauts astronaut;

  const AstronautCard({Key key, this.astronaut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = astronaut.name;
    var biophoto = astronaut.biophoto;
    var biophotowidth = astronaut.biophotowidth;
    var biophotoheight = astronaut.biophotoheight;
    var country = astronaut.country;
    var countryflag = astronaut.countryflag;
    var launchdate = astronaut.launchdate;
    var careerdays = astronaut.careerdays;
    var title = astronaut.title;
    var location = astronaut.location;
    var bio = astronaut.bio;
    var biolink = astronaut.biolink;
    var twitter = astronaut.twitter;

    var cardContent = Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(5.0),
      height: 100.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name),
        ],
      ),
    );
    final cardIcon = Container(
        padding: const EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 16.0),
        alignment: FractionalOffset.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              child: Image.network(countryflag, height: 32.0, width: 32.0),
              padding: EdgeInsets.only(bottom: 15.0),
            ),
            CachedNetworkImage(
              imageUrl: biophoto,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ],
        ));
    var cardText = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            child: new Text(name, style: headerTextStyle),
            padding: EdgeInsets.only(bottom: 15.0),
          ),
          Text(title),
          Text(bio.length > 32 ? "${bio.substring(0, 32)}..." : bio)
        ],
      ),
    );
    return InkWell(
      onTap: () {
        _launchURL(context, biolink);
      },
      child: Card(
        margin: EdgeInsets.all(5.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          children: <Widget>[cardIcon, cardText],
        ),
      ),
    );
  }

  void _launchURL(BuildContext context, String url) async {
    try {
      await launch(url,
          option: new CustomTabsOption(
            toolbarColor: Theme.of(context).primaryColor,
            enableDefaultShare: true,
            enableUrlBarHiding: true,
            showPageTitle: true,
            animation: new CustomTabsAnimation(
              startEnter: 'slide_up',
              startExit: 'android:anim/fade_out',
              endEnter: 'android:anim/fade_in',
              endExit: 'slide_down',
            ),
          ));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
