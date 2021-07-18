import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:submission_1/bloc/search/search_bloc.dart';
import 'package:submission_1/common/styles.dart';
import 'package:submission_1/ui/setting_page.dart';
import 'package:submission_1/ui/widgets/card_restaurants.dart';
import 'package:submission_1/ui/widgets/error_widget.dart';

class SearchPage extends StatefulWidget {
  static const routeName = 'search_page';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ScrollController _controller = ScrollController();
  TextEditingController _filter = TextEditingController();
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

  void checkFilter(String query) async {
    if (query.isNotEmpty && query.length >= 3) {
      context.read<SearchBloc>().add(SearchSubmitEvent(query: query));
    } else if (query.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Search must be minimal 3 character'),
          backgroundColor: Colors.green[300],
        ),
      );
    }
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
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.black,
                    iconSize: 30,
                    onPressed: () {
                      context.read<SearchBloc>().add(
                            SearchIconEvent(
                              expand: true,
                            ),
                          );
                    },
                  );
                } else {
                  return IconButton(
                    icon: Icon(Icons.close),
                    color: Colors.black,
                    iconSize: 30,
                    onPressed: () {
                      context.read<SearchBloc>().add(
                            SearchIconEvent(
                              expand: false,
                            ),
                          );
                      _filter.clear();
                    },
                  );
                }
              },
            ),
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
          title: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchInitial) {
                return Center(
                  child: Text(
                    'Search',
                    style: TextStyle(color: Colors.black),
                  ),
                );
              } else {
                return TextField(
                  onSubmitted: (value) {
                    checkFilter(value);
                  },
                  cursorColor: secondaryColor,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: secondaryColor,
                      ),
                      hintText: 'Search Restaurants Name'),
                );
              }
            },
          ),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchInitial || state is OpenSearch) {
              return _lottieSearchAnimation();
            } else if (state is LoadingSearch) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ListRestaurantSearch) {
              return _listViewBuild(state);
            } else if (state is SearchRestaurantError) {
              return buildErrorWidget(state.message);
            } else if (state is ListRestaurantSearchNotFound) {
              return buildErrorWidget(state.message);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _lottieSearchAnimation() {
    return Center(
      child: Lottie.asset(
        'assets/search.json',
        repeat: true,
        animate: true,
        width: 450,
        height: 450,
      ),
    );
  }

  Widget _listViewBuild(ListRestaurantSearch state) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      controller: _controller,
      itemCount: state.listRestaurant.length,
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
                child:
                    buildRestaurantsItem(context, state.listRestaurant[index])),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _filter.dispose();
  }
}
