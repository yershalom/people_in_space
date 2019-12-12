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
    var biophoto = astronaut.biophoto;
    var biolink = astronaut.biolink;
    var initials = astronaut.initials;
    var countryflag = astronaut.countryflag;
    var country = astronaut.country;

    var cardImage = CachedNetworkImage(
      imageUrl: biophoto,
      imageBuilder: (context, imageProvider) => Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => CircleAvatar(
        maxRadius: 50.0,
        backgroundColor: Colors.brown.shade800,
        child: Text(initials),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );

    var flagImage = CachedNetworkImage(
      imageUrl: countryflag,
      imageBuilder: (context, imageProvider) => Image(
        image: imageProvider,
        height: 32.0,
        width: 32.0,
      ),
      placeholder: (context, url) => Text(country),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );

    return InkWell(
      onTap: () {
        _launchURL(context, biolink);
      },
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: new Container(
          height: 115.0,
          child: new Stack(
            children: <Widget>[
              astroCard(context, flagImage),
              new Positioned(top: 7.5, child: cardImage),
            ],
          ),
        ),
      ),
    );
  }

  Widget astroCard(BuildContext context, CachedNetworkImage flagImage) {
    return new Positioned(
      right: 0.0,
      child: new Container(
        width: 290.0,
        height: 115.0,
        child: new Card(
          color: Colors.blueAccent[50],
          child: new Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 64.0,
            ),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text(astronaut.name,
                    style: Theme.of(context).textTheme.headline),
                new Text(astronaut.location,
                    style: Theme.of(context).textTheme.subhead),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        new Icon(
                          Icons.star,
                        ),
                        new Text(astronaut.daysinspace)
                      ],
                    ),
                    flagImage,
                  ],
                )
              ],
            ),
          ),
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
