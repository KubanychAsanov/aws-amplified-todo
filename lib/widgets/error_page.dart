import 'package:flutter/material.dart';

import '../constants.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error,
                size: 45,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Что-то пошло не так!",
                style: heading,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Повторите попытку позже.",
                textAlign: TextAlign.center,
                style: normalText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .8,
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.shopping_cart,
              size: 45,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Ваша корзина пуста",
              style: heading,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Добавьте свои любимые книги, чтобы отслеживать список корзины.",
              textAlign: TextAlign.center,
              style: normalText,
            ),
          ],
        ),
      ),
    );
  }
}
