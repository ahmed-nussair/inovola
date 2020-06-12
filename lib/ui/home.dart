import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:http/http.dart' as http;

import 'custome_icons.dart';

class Home extends StatefulWidget {
  final Map data;

  Home({@required this.data});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _current;

  final _carouselController = CarouselController();

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  @override
  void initState() {
    _current = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    DateTime date = DateTime.parse(widget.data['date']);

    final thresholdWidth = 450;
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: <Widget>[
            // Images
            Stack(
              children: <Widget>[
                CarouselSlider(
                  items: map<Widget>(
                    widget.data['img'],
                        (index, i) {
                      return Image.network(i, fit: BoxFit.cover, width: 1000.0);
                    },
                  ).toList(),
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                ),
                widget.data['img'].length > 1
                    ? Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(
                      widget.data['img'],
                          (index, url) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _current = index;
                            });
                            _carouselController.animateToPage(_current,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.linear);
                          },
                          child: Container(
                            width: _current == index ? 15.0 : 10.0,
                            height: _current == index ? 15.0 : 10.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index? Color(0xffffffff): Color(0xffffffff).withOpacity(0.8)),
                          ),
                        );
                      },
                    ),
                  ),
                )
                    : Container(),
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        Container(
                          height: MediaQuery.of(context).size.width / 15,
                          width: MediaQuery.of(context).size.width / 15,
                          child: Image.asset('assets/share.png',),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width / 15,
                          width: MediaQuery.of(context).size.width / 15,
                          child: Image.asset('assets/star.png',),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            //Interest
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(8.0),
              child: Text('#${widget.data['interest']}',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > thresholdWidth?20:15,
                ),
              ),
            ),

            // Title
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(8.0),
              child: Text('${widget.data['title']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width > thresholdWidth?30:20,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  // date
                  Row(
                    children: <Widget>[
                      Icon(Icons.calendar_today),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      Text('${intl.DateFormat('EEEE, d MMMM, h:mm aaaa',).format(date)}',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width > thresholdWidth?20:15,
                        ),
                      )
                    ],
                  ),

                  // address
                  Row(
                    children: <Widget>[
                      Icon(CustomIcons.pin_outline),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      Text('${widget.data['address']}',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width > thresholdWidth?20:15,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),


            Divider(
              thickness: MediaQuery.of(context).size.width > thresholdWidth?2:1,
            ),

            // trainer name and image
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  FutureBuilder(
                    future: isItGoodImageUrl(widget.data['trainerImg']),
//                  future: isItGoodImageUrl('https://www.publicdomainpictures.net/pictures/270000/nahled/avatar-people-person-business-.jpg'),
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        bool good = snapshot.data;

                        if(good) {
                          return CircleAvatar(
                            radius: MediaQuery.of(context).size.width / 15,
                            backgroundImage: NetworkImage(widget.data['trainerImg']),
                          );
                        } else {
                          return Icon(Icons.person);
                        }
                      }
                      return Icon(Icons.person);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  Text('${widget.data['trainerName']}',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width > thresholdWidth?20:15,
                    ),
                  ),
                ],
              ),
            ),

            // trainer info
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.data['trainerInfo'],
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > thresholdWidth?20:15,
                ),
              ),
            ),

            Divider(
              thickness: MediaQuery.of(context).size.width > thresholdWidth?2:1,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('عن الدورة',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width > thresholdWidth?20:15,
                ),
              ),
            ),

            // Occasion Details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.data['occasionDetail'],
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > thresholdWidth?20:15,
                ),
              ),
            ),

            Divider(
              thickness: MediaQuery.of(context).size.width > thresholdWidth?2:1,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('تكلفة الدورة',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width > thresholdWidth?20:15,
                ),
              ),
            ),

            // Reservation Types
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: List.generate(widget.data['reservTypes'].length, (index){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(widget.data['reservTypes'][index]['name'],
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width > thresholdWidth?20:15,
                        ),
                      ),
                      Text('${widget.data['reservTypes'][index]['price']} SAR',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width > thresholdWidth?20:15,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> isItGoodImageUrl(String url) async {
    var response = await http.get(url);
    
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
