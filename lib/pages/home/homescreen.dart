import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_bluestack/commonwidgets/cacheimageloader.dart';
import 'package:flutter_app_bluestack/commonwidgets/commonwidget.dart';
import 'package:flutter_app_bluestack/commonwidgets/horizontalspace.dart';
import 'package:flutter_app_bluestack/commonwidgets/verticalspace.dart';
import 'package:flutter_app_bluestack/model/apierror.dart';
import 'package:flutter_app_bluestack/model/tournamentresponse.dart';
import 'package:flutter_app_bluestack/provider/home_provider.dart';
import 'package:flutter_app_bluestack/utils/AppColors.dart';
import 'package:flutter_app_bluestack/utils/Messages.dart';
import 'package:flutter_app_bluestack/utils/themes_styles.dart';
import 'package:provider/provider.dart';

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => new _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  HomeProvider _homeProvider;
  final GlobalKey<ScaffoldState> _scaffoldKeys = new GlobalKey<ScaffoldState>();
  List<Tournaments> _dataList;

  //for infinite loading
  bool _hasMore;
  String _cursor;
  bool _error;
  final int _nextPageThreshold = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hasMore = true;
    _error = false;
    _dataList = List<Tournaments>();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    _homeProvider = Provider.of<HomeProvider>(context);

    return new Scaffold(
      key: _scaffoldKeys,
      backgroundColor: AppColors.kWhite,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalSpace(value: 24),
            userInfoWidget(),
            VerticalSpace(value: 24),
            historySummaryWidget(),
            VerticalSpace(value: 24),
            heading,
            VerticalSpace(value: 24),
            createListView(),
          ],
        ),
      ),
    );
  }

  get loader => (_homeProvider.getLoading())
      ? Center(child: CircularProgressIndicator())
      : Container();

  get heading => Text("Recommended for you",
      style: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 22,
        color: AppColors.kBlack,
      ));

  Future<void> _getData() async {
    await new Future.delayed(new Duration(milliseconds: 500));
    _homeProvider.setLoading();

    //check internet conneciton first
    bool gotInternetConnection = await hasInternetConnection(
      mounted: mounted,
      canShowAlert: true,
      onFail: () {
        _homeProvider.hideLoader();
        showInSnackBar(Messages.noInternetError);
      },
      onSuccess: () {},
    );

    if (gotInternetConnection) {
      var response = await _homeProvider.getTournamentData(1, _cursor, context);
      if (response is APIError) {
        showInSnackBar(response.message ?? Messages.genericError);
      } else {
        var tournamentData = response as TournamentResponse;
        _cursor = tournamentData.data.cursor;
        _hasMore = _cursor != null;
        _dataList.addAll(tournamentData.data.tournaments);
      }
    }
  }

  Future<void> _getDataLoadMore() async {
    //check internet conneciton first
    bool gotInternetConnection = await hasInternetConnection(
      mounted: mounted,
      canShowAlert: true,
      onFail: () {
        showInSnackBar(Messages.noInternetError);
       _error=true;
       setState(() {

       });
      },
      onSuccess: () {},
    );
    if (gotInternetConnection) {
      var response = await _homeProvider.getTournamentData(1, _cursor, context);
      if (response is APIError) {
        // showInSnackBar(response.message ?? Messages.genericError);
      } else {
        var tournamentData = response as TournamentResponse;
        _cursor = tournamentData.data.cursor;
        _hasMore = _cursor != null;
        _dataList.addAll(tournamentData.data.tournaments);
      }
    }
  }

  void showInSnackBar(String value) {
    _scaffoldKeys.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  Widget createListView() {
    return Expanded(
      child: new ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: _dataList.length + (_hasMore ? 1 : 0),
        itemBuilder: (BuildContext context, int index) {
          if (index == _dataList.length - _nextPageThreshold) {
            _getDataLoadMore();
          }
          if (index == _dataList.length) {
            if (_error) {
              return Center(
                  child: InkWell(
                onTap: () {
                  setState(() {
                    _error = false;
                    _getDataLoadMore();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text("Error while loading photos, tap to try agin"),
                ),
              ));
            } else {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ));
            }
          }
          return listItem(_dataList[index]);
        },
      ),
    );
  }

  Widget userInfoWidget() => Row(
        children: [
          new Container(
              width: 95.0,
              height: 95.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          "https://i.imgur.com/BoN9kdC.png")))),
          HorizontalSpace(
            value: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Simon Backer",
                  style: TextThemes.userNameStyle,
                ),
                SizedBox(
                  height: 16,
                ),
                getScoreWidget(1000)
              ],
            ),
          )
        ],
      );

  Widget getScoreWidget(int score) => Container(
      width: 160,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.blue, width: 1.0)),
      child: Container(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                    text: '$score',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.blue)),
                TextSpan(text: ' Elo rating!', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ));

  Widget historySummaryWidget() => Row(
        children: [
          Expanded(
            child: tournamentPlayedWidget(34),
          ),
          Expanded(
            child: tournamentWonWidget(09),
          ),
          Expanded(
            child: winningPercentageWidget(26),
          )
        ],
      );

  Widget tournamentPlayedWidget(int count) => Container(
        decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFFDE7109),
                  const Color(0xFFE38B07),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "$count",
                style: TextThemes.tournamentHistoryScoreTheme,
              ),
              Text("Tournaments\nPlayed",
                  textAlign: TextAlign.center,
                  style: TextThemes.tournamentHistoryScoreTitleTheme),
            ],
          ),
        ),
      );

  Widget tournamentWonWidget(int count) => Container(
        decoration: BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                const Color(0xFF5F259B),
                const Color(0xFF7B31A5),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "$count",
                style: TextThemes.tournamentHistoryScoreTheme,
              ),
              Text("Tournaments\Won",
                  textAlign: TextAlign.center,
                  style: TextThemes.tournamentHistoryScoreTitleTheme),
            ],
          ),
        ),
      );

  Widget winningPercentageWidget(int count) => Container(
        decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFFE54437),
                  const Color(0xFFE8643D),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
                topLeft: Radius.circular(0.0),
                bottomLeft: Radius.circular(0.0))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "$count%",
                style: TextThemes.tournamentHistoryScoreTheme,
              ),
              Text(
                "Winning\npercentage",
                textAlign: TextAlign.center,
                style: TextThemes.tournamentHistoryScoreTitleTheme,
              ),
            ],
          ),
        ),
      );

  Widget listItem(Tournaments tournaments) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                  child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: CacheImageLoader(
                        url: tournaments.coverUrl,
                        boxFit: BoxFit.cover,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tournaments.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            VerticalSpace(
                              value: 8,
                            ),
                            Text(
                              tournaments.gameName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.kGrey.withOpacity(0.7)),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 24.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
