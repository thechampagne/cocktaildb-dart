/// TheCocktailDB API client.
library cocktaildb;

export 'src/types.dart';

import 'dart:convert';
import 'dart:io';
import 'src/types.dart';

class CocktailDBException implements Exception {

  late String _message;

  CocktailDBException(String message) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}

Future<String> _getRequest(String endpoint) async {
  Uri uri = Uri.parse("https://thecocktaildb.com/api/json/v1/1/${endpoint}");
  var request = await new HttpClient().getUrl(uri);
  var response = await request.close();

  var stream = response.transform(Utf8Decoder());

  String content = "";

  await for (var i in stream) {
    content += i;
  }
  return content;
}

/// Search cocktail by name.
///
/// * `s` Cocktail name.
///
/// Returns List of Cocktail.
Future<List<Cocktail>> search(String s) async {
  try {
    var response = await _getRequest("search.php?s=${s.trim()}");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["drinks"] == null || json["drinks"].length == 0) {
      throw "no results found";
    }
    List<Cocktail> list = [];
    for (var i in json["drinks"]) {
      list.add(Cocktail.fromJson(i));
    }
    return list;
  } catch(ex) {
    throw new CocktailDBException(ex.toString());
  }
}

/// Search cocktails by first letter.
///
/// * `c` Cocktails letter.
///
/// Returns List of Cocktail.
Future<List<Cocktail>> searchByLetter(String c) async {
  try {
    var response = await _getRequest("search.php?f=${c[0]}");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["drinks"] == null || json["drinks"].length == 0) {
      throw "no results found";
    }
    List<Cocktail> list = [];
    for (var i in json["drinks"]) {
      list.add(Cocktail.fromJson(i));
    }
    return list;
  } catch(ex) {
    throw new CocktailDBException(ex.toString());
  }
}

/// Search ingredient by name.
///
/// * `s` Ingredient name.
///
/// Returns Ingredient.
Future<Ingredient> searchIngredient(String s) async {
  try {
    var response = await _getRequest("search.php?i=${s.trim()}");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["ingredients"] == null || json["ingredients"].length == 0) {
      throw "no results found";
    }
    var data = Ingredient.fromJson(json["ingredients"][0]);
    return data;
  } catch(ex) {
    throw new CocktailDBException(ex.toString());
  }
}

/// Search cocktail details by id.
///
/// * `i` Cocktail id.
///
/// Returns Cocktail.
Future<Cocktail> searchById(int i) async {
  try {
    var response = await _getRequest("lookup.php?i=${i}");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["drinks"] == null || json["drinks"].length == 0) {
      throw "no results found";
    }
    var data = Cocktail.fromJson(json["drinks"][0]);
    return data;
  } catch(ex) {
    throw new CocktailDBException(ex.toString());
  }
}

/// Search ingredient by ID.
///
/// * `i` Ingredient ID.
///
/// Returns Ingredient.
Future<Ingredient> searchIngredientById(int i) async {
  try {
    var response = await _getRequest("lookup.php?iid=${i}");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["ingredients"] == null || json["ingredients"].length == 0) {
      throw "no results found";
    }
    var data = Ingredient.fromJson(json["ingredients"][0]);
    return data;
  } catch(ex) {
    throw new CocktailDBException(ex.toString());
  }
}

/// Search a random cocktail.
///
/// Returns Random cocktail.
Future<Cocktail> random() async {
  try {
    var response = await _getRequest("random.php");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["drinks"] == null || json["drinks"].length == 0) {
      throw "no results found";
    }
    var data = Cocktail.fromJson(json["drinks"][0]);
    return data;
  } catch(ex) {
    throw new CocktailDBException(ex.toString());
  }
}

/// Filter by ingredient.
///
/// * `s` Ingredient name.
///
/// Returns List of Filter.
Future<List<Filter>> filterByIngredient(String s) async {
  try {
    var response = await _getRequest("filter.php?i=${s.trim()}");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["drinks"] == null || json["drinks"].length == 0) {
      throw "no results found";
    }
    List<Filter> list = [];
    for (var i in json["drinks"]) {
      list.add(Filter.fromJson(i));
    }
    return list;
  } catch(ex) {
    throw new CocktailDBException(ex.toString());
  }
}

/// Filter by alcoholic.
///
/// * `s` Alcoholic name.
///
/// Returns List of Filter.
Future<List<Filter>> filterByAlcoholic(String s) async {
  try {
    var response = await _getRequest("filter.php?a=${s.trim()}");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["drinks"] == null || json["drinks"].length == 0) {
      throw "no results found";
    }
    List<Filter> list = [];
    for (var i in json["drinks"]) {
      list.add(Filter.fromJson(i));
    }
    return list;
  } catch(ex) {
    throw new CocktailDBException(ex.toString());
  }
}

/// Filter by Category.
///
/// * `s` Category name.
///
/// Returns List of Filter.
Future<List<Filter>> filterByCategory(String s) async {
  try {
    var response = await _getRequest("filter.php?c=${s.trim()}");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["drinks"] == null || json["drinks"].length == 0) {
      throw "no results found";
    }
    List<Filter> list = [];
    for (var i in json["drinks"]) {
      list.add(Filter.fromJson(i));
    }
    return list;
  } catch(ex) {
    throw new CocktailDBException(ex.toString());
  }
}

/// Filter by Glass.
///
/// * `s` Glass name.
///
/// Returns List of Filter.
Future<List<Filter>> filterByGlass(String s) async {
  try {
    var response = await _getRequest("filter.php?g=${s.trim()}");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["drinks"] == null || json["drinks"].length == 0) {
      throw "no results found";
    }
    List<Filter> list = [];
    for (var i in json["drinks"]) {
      list.add(Filter.fromJson(i));
    }
    return list;
  } catch(ex) {
    throw new CocktailDBException(ex.toString());
  }
}

/// List the categories filter.
///
/// Returns List of String.
Future<List<String>> categoriesFilter() async {
  try {
    var response = await _getRequest("list.php?c=list");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["drinks"] == null || json["drinks"].length == 0) {
      throw "no results found";
    }
    List<String> list = [];
    for (var i in json["drinks"]) {
      list.add(i["strCategory"]);
    }
    return list;
  } catch(ex) {
    throw new CocktailDBException(ex.toString());
  }
}

/// List the glasses filter.
///
/// Returns List of String.
Future<List<String>> glassesFilter() async {
  try {
    var response = await _getRequest("list.php?g=list");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["drinks"] == null || json["drinks"].length == 0) {
      throw "no results found";
    }
    List<String> list = [];
    for (var i in json["drinks"]) {
      list.add(i["strGlass"]);
    }
    return list;
  } catch(ex) {
    throw new CocktailDBException(ex.toString());
  }
}

/// List the ingredients filter.
///
/// Returns List of String.
Future<List<String>> ingredientsFilter() async {
  try {
    var response = await _getRequest("list.php?i=list");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["drinks"] == null || json["drinks"].length == 0) {
      throw "no results found";
    }
    List<String> list = [];
    for (var i in json["drinks"]) {
      list.add(i["strIngredient1"]);
    }
    return list;
  } catch(ex) {
    throw new CocktailDBException(ex.toString());
  }
}

/// List the alcoholic filter.
///
/// Returns List of String.
Future<List<String>> alcoholicFilter() async {
  try {
    var response = await _getRequest("list.php?a=list");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["drinks"] == null || json["drinks"].length == 0) {
      throw "no results found";
    }
    List<String> list = [];
    for (var i in json["drinks"]) {
      list.add(i["strAlcoholic"]);
    }
    return list;
  } catch(ex) {
    throw new CocktailDBException(ex.toString());
  }
}