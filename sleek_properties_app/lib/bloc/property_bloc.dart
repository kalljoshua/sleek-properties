import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/property_service.dart';
import 'property_event.dart';
import 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final PropertyService propertyService;

  PropertyBloc(this.propertyService) : super(PropertyInitial()) {
    on<FetchProperties>(_onFetchProperties);
    on<AddProperty>(_onAddProperty);
    on<UpdateProperty>(_onUpdateProperty);
    on<DeleteProperty>(_onDeleteProperty);
  }

  void _onFetchProperties(FetchProperties event, Emitter<PropertyState> emit) async {
    emit(PropertyLoading());
    try {
      final properties = await propertyService.fetchProperties();
      emit(PropertyLoaded(properties));
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  void _onAddProperty(AddProperty event, Emitter<PropertyState> emit) async {
    try {
      await propertyService.addProperty(event.property);
      add(FetchProperties());
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  void _onUpdateProperty(UpdateProperty event, Emitter<PropertyState> emit) async {
    try {
      await propertyService.updateProperty(event.id, event.property);
      add(FetchProperties());
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  void _onDeleteProperty(DeleteProperty event, Emitter<PropertyState> emit) async {
    try {
      await propertyService.deleteProperty(event.id);
      add(FetchProperties());
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }
}
