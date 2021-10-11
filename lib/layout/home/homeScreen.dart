import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/home/cubit/cubit.dart';
import 'package:shop/layout/home/cubit/states.dart';
import 'package:shop/model/categoriesModel.dart';
import 'package:shop/model/homeModel.dart';
import 'package:shop/themes/styles/color.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, listener) {},
      builder: (context, listener) {
        HomeCubit cubit = HomeCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) =>
              homeBodyBuilder(cubit.homeModel!, cubit.categoriesModel!, cubit),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget homeBodyBuilder(HomeModel model, CategoriesModel categories, HomeCubit cubit) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image),
                      ))
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayInterval: Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                height: 250.0,
                initialPage: 0,
                reverse: false,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Container(
              height: 100.0,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    categoriesHomeItem(categories.data!.data[index]),
                separatorBuilder: (context, index) => SizedBox(
                  width: 1.0,
                ),
                itemCount: categories.data!.data.length,
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.8,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(model.data.products.length,
                  (index) => gridItem(model.data.products[index], cubit)),
            ),
          ],
        ),
      );
  Widget gridItem(Products productModel,HomeCubit cubit) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  height: 200.0,
                  image: NetworkImage(

                      productModel.image

                  ),
                ),
                if (productModel.discount != null)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  ),
              ],
            ),
            Text(
              productModel.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Text(
                  '${productModel.price.round()}',
                  style: TextStyle(fontSize: 12.0,color: defaultColor),
                ),
                SizedBox(
                  width: 10.0,
                ),
                if (productModel.discount != null)
                  Text(
                    '${productModel.oldPrice.round()}',
                    style: TextStyle(
                        fontSize: 12.0,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey[400]),
                  ),
                Spacer(),
                IconButton(
                  onPressed: () async{
                    cubit.changeFavourites(productModel.id);
                  },
                  icon: CircleAvatar(
                    child: Icon(
                      Icons.favorite_border,color: Colors.white,
                    ),
                    backgroundColor: (cubit.favorites[productModel.id] == true) ? defaultColor : Colors.grey[400],
                  ),
                )
              ],
            )
          ],
        ),
      );
  Widget categoriesHomeItem(DataModel categories) => Container(
        padding: EdgeInsets.all(10.0),
        height: 100.0,
        width: 100.0,
        child: Stack(
          children: [
            Image(
              image: NetworkImage(categories.image),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 100.0,
                color: Colors.black45,
                child: Text(
                  categories.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
              ),
            ),
          ],
        ),
      );
}
