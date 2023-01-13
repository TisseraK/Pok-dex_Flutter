import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:pokedex/constant.dart';

Future<bool> getListPokemon(BuildContext context) async {
  var response = await Dio().get('https://pokebuildapi.fr/api/v1/pokemon');
  pokemonList.clear();
  print(response.data.length);
  for (var i = 0; i < response.data.length; i++) {
    var dataa = response.data[i];
    pokemonList.add(
      pokemon(
          dataa['name'],
          dataa['image'],
          dataa['pokedexId'],
          dataa['apiTypes'],
          dataa['stats'],
          dataa['apiGeneration'],
          dataa['apiResistances'],
          context),
    );
  }
  return true;
}

Widget pokemon(String name, String url, int pokedexID, var apiTyppe, var stats,
    int generation, var resistance, BuildContext context) {
  var _h = MediaQuery.of(context).size.height;
  var _w = MediaQuery.of(context).size.width;
  return GestureDetector(
    onTap: () {
      List<Widget> apiTypes = [];

      for (var i = 0; i < apiTyppe.length; i++) {
        var dataa = apiTyppe[i];
        apiTypes.add(Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(30)),
          child: Text(
            dataa["name"].toString(),
            style: TextStyle(color: Colors.white),
          ),
        ));
      }
      showModalBottomSheet(
          enableDrag: true,
          isScrollControlled: true,
          barrierColor: Colors.black.withOpacity(0.6),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          context: context,
          builder: (context) {
            return Container(
                padding: EdgeInsets.only(
                    top: _h * 0.025, left: _w * 0.025, right: _w * 0.025),
                height: _h * 0.7,
                width: _w,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 51, 51, 51),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: ListView(children: [
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.20,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CachedNetworkImage(
                          imageUrl: url,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: Colors.red,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        //image: AssetImage('assets/maison.png'))),
                      ),
                      Text(
                        name,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: _h * 0.03,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: apiTypes,
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Text(
                        "Génération : $generation",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: _h * 0.025,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Text(
                        "Stats",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: _h * 0.025,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Text(
                        "HP : ${stats['HP'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Attaque : ${stats['attack'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Défense : ${stats['defense'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Attaque Spéciale : ${stats['special_attack'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Défense Spéciale : ${stats['special_defense'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Speed : ${stats['speed'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Text(
                        "Résistance",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: _h * 0.025,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Text(
                        "Normal : ${resistance[0]['damage_multiplier'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: resistance[0]['damage_multiplier'] > 1
                                ? Colors.red
                                : resistance[0]['damage_multiplier'] < 1
                                    ? Colors.green
                                    : Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Combat : ${resistance[1]['damage_multiplier'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: resistance[1]['damage_multiplier'] > 1
                                ? Colors.red
                                : resistance[1]['damage_multiplier'] < 1
                                    ? Colors.green
                                    : Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Vol : ${resistance[2]['damage_multiplier'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: resistance[2]['damage_multiplier'] > 1
                                ? Colors.red
                                : resistance[2]['damage_multiplier'] < 1
                                    ? Colors.green
                                    : Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Poison : ${resistance[3]['damage_multiplier'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: resistance[3]['damage_multiplier'] > 1
                                ? Colors.red
                                : resistance[3]['damage_multiplier'] < 1
                                    ? Colors.green
                                    : Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Sol : ${resistance[4]['damage_multiplier'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: resistance[4]['damage_multiplier'] > 1
                                ? Colors.red
                                : resistance[4]['damage_multiplier'] < 1
                                    ? Colors.green
                                    : Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Roche : ${resistance[5]['damage_multiplier'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: resistance[5]['damage_multiplier'] > 1
                                ? Colors.red
                                : resistance[5]['damage_multiplier'] < 1
                                    ? Colors.green
                                    : Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Insecte : ${resistance[6]['damage_multiplier'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: resistance[6]['damage_multiplier'] > 1
                                ? Colors.red
                                : resistance[6]['damage_multiplier'] < 1
                                    ? Colors.green
                                    : Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Spectre : ${resistance[7]['damage_multiplier'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: resistance[7]['damage_multiplier'] > 1
                                ? Colors.red
                                : resistance[7]['damage_multiplier'] < 1
                                    ? Colors.green
                                    : Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Acier : ${resistance[8]['damage_multiplier'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: resistance[8]['damage_multiplier'] > 1
                                ? Colors.red
                                : resistance[8]['damage_multiplier'] < 1
                                    ? Colors.green
                                    : Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Feu : ${resistance[9]['damage_multiplier'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: resistance[9]['damage_multiplier'] > 1
                                ? Colors.red
                                : resistance[9]['damage_multiplier'] < 1
                                    ? Colors.green
                                    : Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Eau : ${resistance[10]['damage_multiplier'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: resistance[10]['damage_multiplier'] > 1
                                ? Colors.red
                                : resistance[10]['damage_multiplier'] < 1
                                    ? Colors.green
                                    : Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Plante : ${resistance[11]['damage_multiplier'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: resistance[11]['damage_multiplier'] > 1
                                ? Colors.red
                                : resistance[11]['damage_multiplier'] < 1
                                    ? Colors.green
                                    : Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Électrik : ${resistance[12]['damage_multiplier'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: resistance[12]['damage_multiplier'] > 1
                                ? Colors.red
                                : resistance[12]['damage_multiplier'] < 1
                                    ? Colors.green
                                    : Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Psy : ${resistance[13]['damage_multiplier'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: resistance[13]['damage_multiplier'] > 1
                                ? Colors.red
                                : resistance[13]['damage_multiplier'] < 1
                                    ? Colors.green
                                    : Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Glace : ${resistance[14]['damage_multiplier'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: resistance[14]['damage_multiplier'] > 1
                                ? Colors.red
                                : resistance[14]['damage_multiplier'] < 1
                                    ? Colors.green
                                    : Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Dragon : ${resistance[15]['damage_multiplier'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: resistance[15]['damage_multiplier'] > 1
                                ? Colors.red
                                : resistance[15]['damage_multiplier'] < 1
                                    ? Colors.green
                                    : Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Ténèbres : ${resistance[16]['damage_multiplier'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: resistance[16]['damage_multiplier'] > 1
                                ? Colors.red
                                : resistance[16]['damage_multiplier'] < 1
                                    ? Colors.green
                                    : Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Fée : ${resistance[17]['damage_multiplier'].toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: resistance[17]['damage_multiplier'] > 1
                                ? Colors.red
                                : resistance[17]['damage_multiplier'] < 1
                                    ? Colors.green
                                    : Colors.white,
                            fontSize: _h * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ]));
          });
    },
    child: Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.height * 0.025,
          vertical: MediaQuery.of(context).size.height * 0.025 / 2),
      height: MediaQuery.of(context).size.height * 0.10,
      width: MediaQuery.of(context).size.width * 0.975,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 78, 78, 78),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.10,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height * 0.025),
                  ),
                  Text(
                    "Pokédex ID #$pokedexID",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: MediaQuery.of(context).size.height * 0.015),
                  ),
                ]),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.10,
            width: MediaQuery.of(context).size.width * 0.3,
            child: CachedNetworkImage(
              imageUrl: url,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                value: downloadProgress.progress,
                color: Colors.red,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            //image: AssetImage('assets/maison.png'))),
          ),
        ],
      ),
      //image: AssetImage('assets/maison.png'))),
    ),
  );
}
