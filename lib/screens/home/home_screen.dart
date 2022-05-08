import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app_animated_ui/controllers/home_controller.dart';
import 'package:grocery_app_animated_ui/screens/deatils/details_screen.dart';

import '../../constants.dart';
import '../../models/Product.dart';
import 'components/cart_details_view.dart';
import 'components/cart_short_view.dart';
import 'components/header.dart';
import 'components/product_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final homeController = HomeController();

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -0.7) {
      homeController.changeHomeState(HomeState.cart);
    } else if (details.primaryDelta! > 12) {
      homeController.changeHomeState(HomeState.normal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Container(
          color: const Color(0xFFEAEAEA),
          child: AnimatedBuilder(
              animation: homeController,
              builder: (context, _) {
                return LayoutBuilder(builder: (context, BoxConstraints constraints) {
                  return Stack(
                    children: [
                      AnimatedPositioned(
                        duration: panelTransition,
                        top: homeController.homeState == HomeState.normal
                            ? headerHeight
                            : -(constraints.maxHeight - cartBarHeight * 2 - headerHeight),
                        left: 0,
                        right: 0,
                        height: constraints.maxHeight - headerHeight - cartBarHeight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(defaultPadding * 1.5),
                              bottomRight: Radius.circular(defaultPadding * 1.5),
                            ),
                          ),
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: demo_products.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              mainAxisSpacing: defaultPadding,
                              crossAxisSpacing: defaultPadding,
                            ),
                            itemBuilder: (context, index) => ProductCard(
                              product: demo_products[index],
                              press: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: panelTransition,
                                    reverseTransitionDuration: panelTransition,
                                    pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
                                      opacity: animation,
                                      child: DetailsScreen(
                                        product: demo_products[index],
                                        onProductAdd: () {
                                          homeController.addProductToCart(demo_products[index]);
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: panelTransition,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: homeController.homeState == HomeState.normal
                            ? cartBarHeight
                            : (constraints.maxHeight - cartBarHeight),
                        child: GestureDetector(
                          onVerticalDragUpdate: _onVerticalGesture,
                          child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
                              color: const Color(0xffeaeaea),
                              height: double.infinity,
                              alignment: Alignment.topLeft,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 2000),
                                reverseDuration: panelTransition,
                                child: homeController.homeState == HomeState.normal
                                    ? CartShortView(homeController: homeController)
                                    : CartDetailsView(
                                        controller: homeController,
                                      ),
                              )),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: panelTransition,
                        top: homeController.homeState == HomeState.normal ? 0 : -headerHeight,
                        right: 0,
                        left: 0,
                        height: headerHeight,
                        child: const HomeHeader(),
                      ),
                    ],
                  );
                });
              }),
        ),
      ),
    );
  }
}
