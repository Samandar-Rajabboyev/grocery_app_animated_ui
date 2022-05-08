import 'package:flutter/material.dart';
import 'package:grocery_app_animated_ui/constants.dart';

import '../../../controllers/home_controller.dart';
import 'cart_detailsview_card.dart';

class CartDetailsView extends StatelessWidget {
  const CartDetailsView({Key? key, required this.controller}) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Cart',
            style: Theme.of(context).textTheme.headline6,
          ),
          ...List.generate(controller.cart.length, (index) => CartDetailsViewCard(productItem: controller.cart[index])),
          const SizedBox(
            height: defaultPadding,
          ),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: const Text("Next - \$30")))
        ],
      ),
    );
  }
}
