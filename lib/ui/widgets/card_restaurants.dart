import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_1/bloc/detail/detail_bloc.dart';
import 'package:submission_1/data/api/api_service.dart';
import 'package:submission_1/ui/detail_page.dart';

Widget buildRestaurantsItem(BuildContext context, dynamic restaurants) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, DetailPage.routeName,
          arguments: restaurants.id);
      context.read<DetailBloc>().add(DetailInitialEvent());
    },
    child: Container(
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.green.withAlpha(200), blurRadius: 7)
        ],
      ),
      child: Container(
        margin: EdgeInsets.only(top: 15, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
              tag: restaurants.id,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                  ApiService.baseImgUrl + restaurants.pictureId,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  restaurants.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.star,
                        color: Colors.green[300],
                      ),
                    ),
                    Text(
                      restaurants.rating,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.green[300],
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  restaurants.city,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
