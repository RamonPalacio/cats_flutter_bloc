import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../catapp_theme.dart';

class CatCard extends StatelessWidget {
  const CatCard(
      {Key? key,
      required this.catPhoto,
      required this.title,
      required this.origin,
      required this.description,
      required this.weight})
      : super(key: key);

  final String origin;
  final String title;
  final String description;
  final String weight;
  final String? catPhoto;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),

      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: catPhoto != null
                ? CachedNetworkImage(
                    imageUrl: catPhoto!,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.dstATop),
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    progressIndicatorBuilder:
                        (_, __, DownloadProgress valueprogress) {
                      return Stack(children: [
                        Center(
                          child: CircularProgressIndicator(
                              value: valueprogress.downloaded /
                                  (valueprogress.totalSize ?? 1)),
                        ),
                      ]);
                    },
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : const SizedBox(),
          ),
          Positioned(
              child: Text(
                origin,
                style: CatAppTheme.darkTextTheme.bodyText1,
              ),
              left: 16,
              top: 16),
          Positioned(
            child: Text(
              title,
              style: CatAppTheme.darkTextTheme.headline2,
            ),
            top: 36,
            left: 16,
          ),
          Positioned(
            child: SizedBox(
              width: 260,
              child: Text(
                description,
                style: CatAppTheme.darkTextTheme.bodyText1,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
            ),
            bottom: 40,
            right: 16,
          ),
          Positioned(
            child: Text(
              weight,
              style: CatAppTheme.darkTextTheme.bodyText1,
            ),
            bottom: 10,
            right: 16,
          )
        ],
      ),
      constraints: const BoxConstraints.expand(
        width: 350,
        height: 450,
      ),

      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     colorFilter: ColorFilter.mode(
      //         Colors.black.withOpacity(0.5), BlendMode.dstATop),
      //     image: const NetworkImage(
      //         'https://clinicadentalarias.com/wp-content/uploads/2016/10/orionthemes-placeholder-image.jpg'),
      //     fit: BoxFit.cover,
      //   ),
      //   borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      // ),
    );
  }
}
