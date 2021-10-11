import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/home/cubit/cubit.dart';
import 'package:shop/layout/home/cubit/states.dart';
import 'package:shop/model/favouritesModel.dart';
import 'package:shop/themes/styles/color.dart';

class Favourite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        // HomeCubit cubit = HomeCubit.get(context);
        return HomeCubit.get(context).favouriteModel!.data.dataLoad.isNotEmpty ? ConditionalBuilder(
          condition: state is! GetFavoritesLoadingState,
          builder: (context) => ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => productsListItem(
              HomeCubit.get(context).favouriteModel!.data.dataLoad[index],
              HomeCubit.get(context),
            ),
            itemCount: HomeCubit.get(context).favouriteModel!.data.dataLoad.length
            // cubit.favorites.length
            ,
            padding: const EdgeInsets.all(8.0),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        ) : Center(child: Text('Empty'));
      },
    );
  }
  Widget productsListItem(favData, cubit,{bool discount = true}) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  height: 120.0,
                  width: 120.0,
                  image: NetworkImage(favData.product.image),
                ),
                if (favData.product.discount != null && discount )
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  favData.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      '${favData.product.price.round()}',
                      style: TextStyle(fontSize: 12.0, color: defaultColor),
                    ),
                    const SizedBox(width: 20.0),
                    if (favData.product.discount != null && discount)
                      Text(
                        '${favData.product.oldPrice.round()}',
                        style: TextStyle(
                            fontSize: 12.0,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[400]),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () async {
                        cubit.changeFavourites(favData.product.id);
                        // model.changeFavourites(favData.product.id);
                      },
                      icon: CircleAvatar(
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        backgroundColor:
                        (cubit.favorites[favData.product.id] == true)
                            ? defaultColor
                            : Colors.grey[400],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

