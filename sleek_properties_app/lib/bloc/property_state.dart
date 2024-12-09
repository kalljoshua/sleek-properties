abstract class PropertyState {}

class PropertyInitial extends PropertyState {}

class PropertyLoading extends PropertyState {}

class PropertyLoaded extends PropertyState {
  final List<dynamic> properties;
  PropertyLoaded(this.properties);
}

class PropertyError extends PropertyState {
  final String error;
  PropertyError(this.error);
}