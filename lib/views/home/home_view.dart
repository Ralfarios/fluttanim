import 'package:fluttanim/core/services/mal.dart';
import 'package:flutter/material.dart';

import 'package:fluttanim/constants/colors.dart';

import './mock_data.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: MalServices.getList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Scaffold(
                backgroundColor: Color(kPrimaryColors),
                body: Center(child: CircularProgressIndicator()));
          }
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              backgroundColor: const Color(kPrimaryColors),
              appBar: AppBar(
                title: const Text(
                  'Fluttanim',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 72,
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const TextField(
                        style: TextStyle(color: Color(kGrayColors)),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 56,
                            minHeight: 56,
                          ),
                          hintText: 'Search...',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(kGrayColors),
                          ),
                          hintStyle: TextStyle(color: Color(kGrayColors)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(kGrayColors40)),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Categories',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(14, 14),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {},
                              child: const Text(
                                'See More',
                                style: TextStyle(color: Color(kGrayColors)),
                              )),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 96,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: mockData.length,
                          itemBuilder: (context, idx) => Padding(
                            padding: idx == 0 || idx == mockData.length - 1
                                ? EdgeInsets.only(
                                    left: (idx == 0 ? 0 : 4),
                                    right: (idx == mockData.length - 1 ? 0 : 4))
                                : const EdgeInsets.symmetric(horizontal: 4.0),
                            child: CategoryCard(
                              icon: mockData[idx]['icon'],
                              id: mockData[idx]['id'],
                              title: mockData[idx]['title'],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Popular',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(14, 14),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {},
                              child: const Text(
                                'See More',
                                style: TextStyle(color: Color(kGrayColors)),
                              )),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          spacing: deviceWidth / 24,
                          runSpacing: deviceWidth / 24,
                          children: snapshot.data
                              .map<Widget>((e) => PopularCard(
                                    id: e.id,
                                    imageUrl: e.imageUrl,
                                    rating: e.rating,
                                    title: e.title,
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class PopularCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final num rating;
  final int id;
  const PopularCard(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.rating,
      required this.id})
      : super(key: key);

  List<Widget> ratingStars(num rating) {
    int base = 5;
    List<Widget> filled = [];
    List<Widget> hollow = [];
    for (int i = 0; i < (rating).floor(); i++) {
      filled.add(const Icon(Icons.star_rounded, color: Colors.orange));
    }
    for (int i = 0; i < (base - rating).floor(); i++) {
      filled.add(const Icon(Icons.star_border_rounded, color: Colors.orange));
    }
    return [
      ...filled,
      if (rating % 1 != 0)
        const Icon(Icons.star_half_rounded, color: Colors.orange),
      ...hollow
    ];
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: (deviceWidth / 2) - deviceWidth / 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: deviceHeight / 3,
            width: (deviceWidth / 2) - deviceWidth / 16,
            child: Stack(
              children: [
                Positioned.fill(
                  bottom: 0,
                  child: Hero(
                    tag: id.toString(),
                    child: ClipRRect(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        child: Image.network(
                          imageUrl,
                          height: deviceHeight / 3,
                          width: (deviceWidth / 2) - deviceWidth / 16,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                Positioned.fill(
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(24)),
                          onTap: () => Navigator.pushNamed(context, '/detail',
                              arguments: {'id': id, 'imageUrl': imageUrl}),
                        ))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(top: 1.0),
              child: Text(
                rating.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            const Icon(
              Icons.star_rounded,
              color: Colors.orange,
              size: 16,
            )
          ])
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String icon;
  final int id;
  final String title;

  const CategoryCard(
      {Key? key, required this.icon, required this.id, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 102,
      height: 96,
      decoration: BoxDecoration(
          color: const Color(kButtonCardColor),
          borderRadius: BorderRadius.circular(20)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                icon,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
