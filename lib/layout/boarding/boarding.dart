import 'package:flutter/material.dart';
import 'package:shop/constants/constFunctions.dart';
import 'package:shop/layout/login/login.dart';
import 'package:shop/network/local/cacheHelper.dart';
import 'package:shop/themes/styles/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  BoardingModel({required this.title, required this.body, required this.image});
  final String image;
  final String title;
  final String body;
}

class BoardingScreen extends StatefulWidget {
  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(
        title: 'Title Screen 1',
        body: 'Body Text Screen 1',
        image: 'assets/images/intro/intro.jpg'),
    BoardingModel(
        title: 'Title Screen 2',
        body: 'Body Text Screen 2',
        image: 'assets/images/intro/introo.jpg'),
    BoardingModel(
        title: 'Title Screen 3',
        body: 'Body Text Screen 3',
        image: 'assets/images/intro/introoo.jpg'),
  ];

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => submit(),
            child: Text('SKIP'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: boarding.length,
                physics: BouncingScrollPhysics(),
                controller: pageController,
                itemBuilder: (context, index) {
                  return boardingItem(boarding[index]);
                },
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10.0,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 700),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  void submit(){
     CacheHelper.sharedPreferences!.setBool('isFirst', true).then((value){
       if(value){navigateAndRemove(context, LoginScreen());}
     });
  }
}

//Page View Item
Widget boardingItem(BoardingModel boarding) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(boarding.image),
          ),
        ),
        SizedBox(height: 30.0),
        Text(
          boarding.title,
          style: TextStyle(fontSize: 24.0, color: Colors.black),
        ),
        SizedBox(height: 15.0),
        Text(boarding.body),
      ],
    );
