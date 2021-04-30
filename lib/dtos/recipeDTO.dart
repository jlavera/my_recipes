class RecipeDTO {
  RecipeDTO(this.name, this.source, this.thumbnailUrl, this.fullImageUrl,
      this.tags, this.ingredients, this.steps);

  final String name;
  final String source;
  final String thumbnailUrl; // TODO change url to actual image
  final String fullImageUrl;
  final List<String> tags;
  final List<String> ingredients;
  final List<String> steps;
}
