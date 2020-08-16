import 'package:Covid19/widgets/shimmer.dart';
import 'package:flutter/material.dart';

class SkeletonSummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SkeletonBox(width: 160, height: 24),
                SizedBox(height: 4.0),
                SkeletonBox(width: 100, height: 16),
              ],
            ),
            SkeletonBox(width: 100, height: 24),
          ],
        ),
        SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFF498ED0)),
                    ),
                    SizedBox(width: 8.0),
                    SkeletonBox(width: 80, height: 24)
                  ],
                ),
                SizedBox(height: 8.0),
                SkeletonBox(width: 40, height: 24)
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFF0283D)),
                    ),
                    SizedBox(width: 8.0),
                    SkeletonBox(width: 80, height: 24)
                  ],
                ),
                SizedBox(height: 8.0),
                SkeletonBox(width: 40, height: 24)
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFF5B0611)),
                    ),
                    SizedBox(width: 8.0),
                    SkeletonBox(width: 80, height: 24)
                  ],
                ),
                SizedBox(height: 8.0),
                SkeletonBox(width: 40, height: 24)
              ],
            )
          ],
        )
      ],
    );
  }
}

class SkeletonBox extends StatelessWidget {
  final double width;
  final double height;

  SkeletonBox({@required this.width, @required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(width: width, height: height, color: Colors.white));
  }
}

class SkeletonChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SkeletonBox(width: double.infinity, height: 300);
  }
}

class SkeletonCountriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (_, __) => SkeletonCountryRow(),
        itemCount: 5);
  }
}

class SkeletonCountryRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          SkeletonBox(width: 80, height: 16),
          SizedBox(width: 12.0),
          Expanded(
            child: SkeletonBox(width: 80, height: 16),
          ),
          SizedBox(width: 8.0),
          SkeletonBox(width: 80, height: 16)
        ],
      ),
    );
  }
}
