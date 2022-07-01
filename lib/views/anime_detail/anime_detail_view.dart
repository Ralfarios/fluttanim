import 'package:flutter/material.dart';

import 'package:fluttanim/constants/colors.dart';

class AnimeDetailView extends StatelessWidget {
  final dynamic data;
  const AnimeDetailView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
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
              onPressed: () {}, icon: const Icon(Icons.bookmark_border_rounded))
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(32)),
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
                  const Text(
                    'Wonder Egg Priority',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Text(
                        'Studio: Clover Works',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      Text('|', style: TextStyle(color: Colors.white)),
                      SizedBox(width: 8),
                      Text('7.2', style: TextStyle(color: Colors.white)),
                      SizedBox(width: 4),
                      Icon(
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
                      children: const [
                        Chip(
                          backgroundColor: Color(kButtonCardColor),
                          side: BorderSide.none,
                          label: Text('Drama'),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        Chip(
                          backgroundColor: Color(kButtonCardColor),
                          side: BorderSide.none,
                          label: Text('Action'),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ],
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
                        text:
                            "Following the suicide of her best and only friend, Koito Nagase, Ai Ooto is left grappling with her new reality. With nothing left to live for, she follows the instructions of a mysterious entity and gets roped into purchasing an egg, or specifically, a Wonder Egg.\n\nUpon breaking the egg in a world that materializes during her sleep, Ai is tasked with saving people from the adversities that come their way. In doing so, she believes that she has moved one step closer to saving her best friend. With this dangerous yet tempting opportunity in the palms of her hands, Ai enters a place where she must recognize the relationship between other people's demons and her own.\n\nAs past trauma, unforgettable regrets, and innate fears hatch in the bizarre world of Wonder Egg Priority, a young girl discovers the different inner struggles tormenting humankind and rescues them from their worst fears.\n\n[Written by MAL Rewrite]")
                  ])),
                  const SizedBox(height: 16),
                ],
              ))),
    );
  }
}
