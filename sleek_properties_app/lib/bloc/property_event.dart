abstract class PropertyEvent {}

class FetchProperties extends PropertyEvent {}

class AddProperty extends PropertyEvent {
  final Map<String, dynamic> property;
  AddProperty(this.property);
}

class UpdateProperty extends PropertyEvent {
  final int id;
  final Map<String, dynamic> property;
  UpdateProperty(this.id, this.property);
}

class DeleteProperty extends PropertyEvent {
  final int id;
  DeleteProperty(this.id);
}