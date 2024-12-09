import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/property_bloc.dart';
import '../bloc/property_event.dart';
import '../bloc/property_state.dart';
import 'add_edit_property_page.dart';

class PropertyListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Properties'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: BlocProvider.of<PropertyBloc>(context),
                    child: AddEditPropertyPage(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<PropertyBloc, PropertyState>(
        builder: (context, state) {
          if (state is PropertyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PropertyLoaded) {
            final properties = state.properties;
            return ListView.builder(
              itemCount: properties.length,
              itemBuilder: (context, index) {
                final property = properties[index];
                return Card(
                  child: ListTile(
                    leading: property['image'] != null
                        ? Image.network(property['image'], fit: BoxFit.cover)
                        : Icon(Icons.image_not_supported),
                    title: Text(property['name']),
                    subtitle: Text('${property['price']} USD'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: BlocProvider.of<PropertyBloc>(context),
                                  child: AddEditPropertyPage(
                                    property: property,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context
                                .read<PropertyBloc>()
                                .add(DeleteProperty(property['id']));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is PropertyError) {
            return Center(child: Text(state.error));
          }
          return const Center(child: Text('No properties found.'));
        },
      ),
    );
  }
}
