import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_1/bloc/favorite/favorite_bloc.dart';
import 'package:submission_1/common/styles.dart';
import 'package:submission_1/ui/setting_page.dart';
import 'package:submission_1/ui/widgets/card_restaurants.dart';
import 'package:submission_1/ui/widgets/error_widget.dart';

class FavoritePage extends StatefulWidget {
  static const routeName = 'favorite_page';

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  ScrollController _controller = ScrollController();
  double _topContainer = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      double value = _controller.offset / 139;

      setState(() {
        _topContainer = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              color: Colors.black,
              iconSize: 30,
              onPressed: () {
                Navigator.pushNamed(context, SettingPage.routeName);
              },
            ),
          ],
          backgroundColor: primaryColor,
          title: Center(
            child: Text('Favorites'),
          ),
        ),
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (_, state) {
            if (state is FavoriteInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FavoritePageLoaded) {
              return _listViewBuild(state);
            } else if (state is FavoriteNoData) {
              return buildErrorWidget(state.message);
            } else if (state is FavoritePageError){
              return buildErrorWidget((state).message);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _listViewBuild(FavoritePageLoaded state) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      controller: _controller,
      itemCount: state.restaurants.length,
      itemBuilder: (context, index) {
        double scale = 1.0;
        if (_topContainer > 0.5) {
          scale = index + 0.8 - _topContainer;
          if (scale < 0) {
            scale = 0;
          } else if (scale > 1) {
            scale = 1;
          }
        }
        return Opacity(
          opacity: scale,
          child: Transform(
            alignment: Alignment.bottomCenter,
            transform: Matrix4.identity()..scale(scale, scale),
            child: Align(
                heightFactor: 0.8,
                alignment: Alignment.topCenter,
                child: buildRestaurantsItem(context, state.restaurants[index])),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
