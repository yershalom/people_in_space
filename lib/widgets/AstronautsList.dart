import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:people_in_space/model/astronauts.dart';

final baseTextStyle = const TextStyle(fontFamily: 'Poppins');

final headerTextStyle = baseTextStyle.copyWith(
  color: Colors.black,
  fontSize: 20.0,
  fontWeight: FontWeight.w600,
);

class AstronautsList extends StatelessWidget {
  final List<Astronauts> astronauts;

  const AstronautsList({Key key, this.astronauts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: astronauts.length,
        itemBuilder: (context, index) {
          var name = astronauts[index].name;
          var biophoto = astronauts[index].biophoto;
          var biophotowidth = astronauts[index].biophotowidth;
          var biophotoheight = astronauts[index].biophotoheight;
          var country = astronauts[index].country;
          var countryflag = astronauts[index].countryflag;
          var launchdate = astronauts[index].launchdate;
          var careerdays = astronauts[index].careerdays;
          var title = astronauts[index].title;
          var location = astronauts[index].location;
          var bio = astronauts[index].bio;
          var biolink = astronauts[index].biolink;
          var twitter = astronauts[index].twitter;
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
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(biophoto),
                    backgroundColor: Colors.transparent,
                  )
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Row(
                children: <Widget>[cardIcon, cardText],
              ),
            ),
          );
        });
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
