import 'package:famous_place/Trek.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collapsible SliverAppBar',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isExpanded = false;
  late Future<TrekData> _trekDataFuture;

  @override
  void initState() {
    super.initState();
    _trekDataFuture = loadTrekData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<TrekData>(
        future: _trekDataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            TrekData trekData = snapshot.data!;
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  expandedHeight: 240,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(trekData.bannerTitle),
                    background: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 1.5,
                        viewportFraction: 1.0, // set viewportFraction to 1.0
                      ),
                      items: trekData.bannerImages.map((url) {
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(url),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                  floating: true,
                  snap: true,
                  pinned: true,
                ),
              ],
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 48,
                      //width: 30,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 15, 0.0, 0.0),
                        child: RatingBarIndicator(
                          rating: trekData.rating,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 25.0,
                          direction: Axis.horizontal,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 440,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 15, 0.0, 0.0),
                        child: Text(trekData.description),
                      ),
                    ),
                    // Container(
                    //   padding: EdgeInsets.fromLTRB(0.0, 15, 0.0, 0.0),
                    ListTile(
                      leading: new MyBullet(),
                      title: Text(trekData.details[0]),
                    ),
                    ListTile(
                      leading: new MyBullet(),
                      title: Text(trekData.details[1]),
                    ),
                    ListTile(
                      leading: new MyBullet(),
                      title: Text(trekData.details[2]),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 15, 0.0, 0.0),
                      child: Text(
                        'Popular Treks',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 15, 0.0, 0.0),
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 16 / 9,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: trekData.popularTreks.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      trekData.popularTreks[index]['thumbnail'],
                                      fit: BoxFit.cover,
                                      height: double.infinity,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.7)
                                          ],
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            trekData.popularTreks[index]
                                                ['title'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              RatingBarIndicator(
                                                rating: 5,
                                                itemBuilder: (context, index) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 20.0,
                                                direction: Axis.horizontal,
                                              ),
                                              SizedBox(width: 8),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            print('err${snapshot.error}');
            return const Center(
              child: Text("Error loading data"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 10.0,
      width: 10.0,
      decoration: new BoxDecoration(
        color: Colors.black54,
        shape: BoxShape.circle,
      ),
    );
  }
}
