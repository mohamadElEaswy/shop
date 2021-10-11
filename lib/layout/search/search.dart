import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/components/components.dart';
import 'package:shop/layout/favourit/favourit.dart';
import 'package:shop/layout/home/cubit/cubit.dart';
import 'package:shop/layout/search/cubit/cubit.dart';
import 'package:shop/layout/search/cubit/state.dart';
import 'package:shop/model/searchModel.dart';
import 'package:shop/themes/styles/color.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  defaultTextForm(
                      controller: searchController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Type to search';
                        }
                      },
                      onSubmit: (value) {
                        print(value);
                        if (formKey.currentState!.validate()) {
                          SearchCubit.get(context).search(value.toString());
                        }
                      },
                      fieldTitle: 'Search'),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ConditionalBuilder(
                    condition: state is SearchSuccessState,
                    builder: (context) => Expanded(
                      child: ListView.builder(
                        itemExtent: 400.0,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => _productsListItem(
                          SearchCubit.get(context).model.data.dataLoad[index],
                          // HomeCubit.get(context),
                          discount: false,
                        ),
                        itemCount:
                            SearchCubit.get(context).model.data.dataLoad.length
                        // cubit.favorites.length
                        ,
                        padding: const EdgeInsets.all(8.0),
                      ),
                    ),
                    fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _productsListItem(Product productsData,
          // cubit,
          {bool discount = true}) =>
      Padding(
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
                      image: NetworkImage(productsData.image),
                    ),
                    if (productsData.discount != null && discount)
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
                      productsData.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          '${productsData.price.round()}',
                          style: TextStyle(fontSize: 12.0, color: defaultColor),
                        ),
                        const SizedBox(width: 20.0),
                        if (productsData.discount != null && discount)
                          Text(
                            '${productsData.oldPrice.round()}',
                            style: TextStyle(
                                fontSize: 12.0,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey[400]),
                          ),
                        Spacer(),
                        // IconButton(
                        //   onPressed: () async {
                        //     cubit.changeFavourites(productsData.product.id);
                        //     // model.changeFavourites(favData.product.id);
                        //   },
                        //   icon: CircleAvatar(
                        //     child: const Icon(
                        //       Icons.favorite_border,
                        //       color: Colors.white,
                        //     ),
                        //     backgroundColor:
                        //     (cubit.favorites[productsData.product.id] == true)
                        //         ? defaultColor
                        //         : Colors.grey[400],
                        //   ),
                        // )
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
