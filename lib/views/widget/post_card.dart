// import 'package:application/generated/assets.gen.dart';
// import 'package:application/models/models.dart';
// import 'package:application/repositories/repository.dart';
// import 'package:application/styles/styles.dart';
// import 'package:application/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/post.dart';
import '../../style/colors.dart';
import '../../style/tokens.dart';
import '../../utils/formatter.dart';

class PostCard extends StatelessWidget {
  final Post? data;
  final String? imgUrl;
  // Repository? _repo;

  PostCard(this.data, this.imgUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    TextStyle titleStyle =
        theme.textTheme.subtitle1!.apply(color: AppColors.text60);
    TextStyle contentStyle =
        theme.textTheme.caption!.apply(color: AppColors.text40);
    TextStyle infoStyle = theme.textTheme.caption!.apply(
      color: AppColors.text50,
    );

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final screenWidth = constraints.maxWidth;
      final screenHeight = constraints.maxHeight;
      return Container(
        // color: Colors.amber,
        // width: screenWidth * 0.8,
        margin: AppEdgeInsets.vertical8.add(AppEdgeInsets.horizontal16),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data!.title,
                            style: titleStyle,
                            overflow: TextOverflow.clip,
                          ),
                          AppSpacers.height8,
                          SizedBox(
                            height: 32,
                            child: Text(
                              data!.content,
                              style: contentStyle,
                              // minFontSize: 13,
                              maxLines: 2,
                            ),
                          )
                        ]),
                  ],
                )),
                AppSpacers.width4,

                // Container(
                //   width: screenWidth * 0.3,
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Container(
                //           width: 64,
                //           height: 64,
                //           decoration: BoxDecoration(
                //               image: DecorationImage(
                //                 // fit: BoxFit.cover,
                //                 fit: BoxFit.contain,
                //                 image: CachedNetworkImageProvider(imgUrl!,
                //                 maxHeight: 64, maxWidth: 100
                //                 ),
                //               ),
                //               border: Border.all(width: 1, color: AppColors.primary),
                //               borderRadius: AppBorderRadius.circular48),
                //         ),
                //       )
                //     ],
                //   ),
                // ),

                Container(
                    width: 100,
                    height: 64,

                    child: Row(
                      children: [
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30.0,
                            child: ClipRRect(
                              child: Image.asset('assets/avatar_logo.png'),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        )
                      ],
                    )
                ),



              ],
            ),
            AppSpacers.height16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: screenWidth * 0.17,
                    child: Text(
                      // data!.nickName,
                      data!.writer,
                      overflow: TextOverflow.ellipsis,
                      style: infoStyle,
                    )),
                /*Text(r
                  data!.nickName,
                  style: infoStyle,
                ),*/
                AppSpacers.width16,
                Expanded(
                  flex: 5,
                  child: Text(
                    // formatyyMMddHHmm(data!.isCreatedAt),
                    data!.isCreatedAt,
                    overflow: TextOverflow.ellipsis,
                    style: infoStyle,
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // ImageIcon(
                        //   Assets.images.icHeart18,
                        //   size: 15,
                        // ),
                        AppSpacers.width8,
                        // Text(
                        //   // data!.likeCount.toString(),
                        //   data!.content,
                        //   style: infoStyle,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                        AppSpacers.width8,
                        AppSpacers.width8,
                        // ImageIcon(
                        //   Assets.images.icReply18,
                        //   size: 15,
                        // ),
                        AppSpacers.width8,
                        // Text(
                        //   data!.replyCount.toString(),
                        //   style: infoStyle,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                      ],
                    )),
              ],
            )
          ],
        ),
      );
    });
  }
}
