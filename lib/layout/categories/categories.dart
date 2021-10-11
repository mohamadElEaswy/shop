import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/home/cubit/cubit.dart';
import 'package:shop/layout/home/cubit/states.dart';
import 'package:shop/model/categoriesModel.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = HomeCubit.get(context);
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              categoriesList(cubit.categoriesModel!.data!.data[index]),
          separatorBuilder: (context, index) => SizedBox(height: 5.0),
          itemCount: cubit.categoriesModel!.data!.data.length,
        );
      },
    );
  }

  Widget categoriesList(DataModel categories) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              child: Image(
                image: NetworkImage(categories.image),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              categories.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
