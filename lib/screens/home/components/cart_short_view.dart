import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../controllers/home_controller.dart';

class CartShortView extends StatelessWidget {
  const CartShortView({
    Key? key,
    required this.homeController,
  }) : super(key: key);

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Cart',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          width: defaultPadding,
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                homeController.cart.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: defaultPadding / 2),
                  child: Hero(
                    tag: homeController.cart[index].product!.title! + '_cartTag',
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(homeController.cart[index].product!.image!),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            homeController.totalCartItems().toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
          ),
        ),
      ],
    );
  }
}
