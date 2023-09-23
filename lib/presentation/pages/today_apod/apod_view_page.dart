import 'package:astronomy_picture/custom_colors.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/presentation/widgets/today_apod/apod_view_button.dart';
import 'package:flutter/material.dart';

class ApodViewPage extends StatefulWidget {
  final Apod apod;

  const ApodViewPage({
    required this.apod,
    super.key,
  });

  @override
  State<ApodViewPage> createState() => _ApodViewPageState();
}

class _ApodViewPageState extends State<ApodViewPage> {
  late Apod apod;

  bool isImage = true;

  @override
  void initState() {
    apod = widget.apod;

    checkMediaType();

    super.initState();
  }

  void checkMediaType() {
    if (apod.mediaType == 'video') {
      isImage = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [CustomColors.spaceBlue, CustomColors.black],
            ),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  ClipRect(child: buildMediaType()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 350, 30, 0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.centerLeft,
                          colors: [
                            CustomColors.blue,
                            CustomColors.vermilion,
                            CustomColors.vermilion,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: CustomColors.white.withOpacity(.3)),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.blue.withOpacity(.7),
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: const Offset(0, 0),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            apod.title ?? '',
                            style: TextStyle(
                              fontSize: 22,
                              color: CustomColors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            apod.explanation ?? '',
                            style: TextStyle(
                              color: CustomColors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'by ${apod.copyright ?? 'NASA'}',
                            style: TextStyle(
                              color: CustomColors.white,
                            ),
                          ),
                          Text(
                            'date: ${apod.date}',
                            style: TextStyle(
                              color: CustomColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ApodViewButton(
                      icon: Icons.hd,
                      title: 'Image in HD',
                      description:
                          'Images may be inclomplete! Tap here to view full image',
                      onTap: () {},
                    ),
                    const SizedBox(width: 15),
                    ApodViewButton(
                      icon: Icons.bookmark_outline,
                      title: 'Save',
                      description:
                          'Save this content for quick access in future',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMediaType() {
    if (isImage) {
      return GestureDetector(
        child: Container(
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(apod.url ?? ''),
              fit: BoxFit.fitHeight,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            border: Border.all(
              color: CustomColors.white.withOpacity(.5),
            ),
          ),
        ),
        onTap: () {},
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(apod.thumbnailUrl ??
                'https://spaceplace.nasa.gov/gallery-space/en/NGC2336-galaxy.en.jpg'),
            fit: BoxFit.fitHeight,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          border: Border.all(
            color: CustomColors.white.withOpacity(.5),
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Video
          ],
        ),
      );
    }
  }
}
