import 'package:flutter/material.dart';

import 'package:fluttanim/core/services/mal.dart';
import 'package:fluttanim/constants/colors.dart';

class AnimeDetailView extends StatelessWidget {
  final dynamic data;
  const AnimeDetailView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: MalServices.getDetail(data['id']),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
          backgroundColor: const Color(kPrimaryColors),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              'Detail Anime',
              textAlign: TextAlign.center,
            ),
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_border_rounded))
            ],
          ),
          body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight / 40),
                        child: Stack(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 24.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(kButtonCardColorBack),
                                      borderRadius: BorderRadius.circular(32)),
                                  height: deviceHeight / 2,
                                  width: deviceWidth / 2,
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(kButtonCardColorMid),
                                      borderRadius: BorderRadius.circular(32)),
                                  height: deviceHeight / 2,
                                  width: deviceWidth / 1.85,
                                ),
                              ),
                            ),
                            Center(
                              child: Hero(
                                tag: data['id'].toString(),
                                child: ClipRRect(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(32)),
                                  child: Image.network(
                                    data['imageUrl'],
                                    height: deviceHeight / 2,
                                    width: deviceWidth / 1.75,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      if (snapshot.data == null)
                        const Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else ...[
                        Text(
                          snapshot.data.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Studio: ${snapshot.data.studio}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 8),
                            const Text('|',
                                style: TextStyle(color: Colors.white)),
                            const SizedBox(width: 8),
                            Text(snapshot.data.rating.toString(),
                                style: const TextStyle(color: Colors.white)),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.orange,
                              size: 18,
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            spacing: 16,
                            runSpacing: 0,
                            children: snapshot.data.genres
                                .map<Widget>(
                                  (e) => Chip(
                                    backgroundColor:
                                        const Color(kButtonCardColor),
                                    side: BorderSide.none,
                                    label: Text(e),
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Synopsis',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              style: TextStyle(height: deviceHeight / 512),
                              text: snapshot.data.synopsis)
                        ])),
                        const SizedBox(height: 16),
                      ],
                    ],
                  ))),
        );
      },
    );
  }
}
