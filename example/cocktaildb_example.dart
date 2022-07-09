import 'package:cocktaildb/cocktaildb.dart';

void main() {
  search("Margarita").then((drinks) =>
      drinks.forEach((drink) => print(drink.strDrink))
  );
}