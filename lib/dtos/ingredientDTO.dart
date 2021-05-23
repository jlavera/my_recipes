class IngredientDTO {
  IngredientDTO(this.quantity, this.unit, this.description);

  final String quantity;
  final String unit;
  final String description;

  static IngredientDTO fromJson(Map json) {
    T getField<T>(String key, T def) {
      return json.containsKey(key) ? json[key] : def;
    }

    return IngredientDTO(
      getField("quantity", ""),
      getField("unit", ""),
      getField("description", ""),
    );
  }

  String get cleanUnit {
    switch (this.unit) {
      case "number":
        {
          return "u";
        }
        break;
      case "slices":
        {
          return "slc";
        }
      default:
        {
          return this.unit;
        }
        break;
    }
  }

  @override
  bool operator ==(Object other) {
    return other is IngredientDTO && this.description == other.description;
  }

  @override
  int get hashCode => description.hashCode;
}
