import 'dart:convert';

import 'package:covidapp/countrypage.dart';
import 'package:covidapp/datasource.dart';
import 'package:covidapp/panels/infopanel.dart';
import 'package:covidapp/panels/srilankanpanel.dart';
import 'package:covidapp/panels/worldwide.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  fethWorldWideData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v3/covid-19/all');
    setState(() {
      worldData = jsonDecode(response.body);
    });
  }

  Map countryData;
  fethcountryData() async {
    http.Response response = await http
        .get('https://corona.lmao.ninja/v3/covid-19/countries/sri%20lanka');
    setState(() {
      countryData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    fethWorldWideData();
    fethcountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid Information Center"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Global Infomation",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CountryPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryBlack,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Regional",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            worldData == null
                ? CircularProgressIndicator()
                : WorldWidePanel(
                    worldData: worldData,
                  ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text("Local Information",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            countryData == null
                ? Container()
                : SrilankanPalen(
                    countryData: [countryData],
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 10),
              child: InfoPanel(),
            ),
            SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}
