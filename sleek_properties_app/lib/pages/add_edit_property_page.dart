import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../bloc/property_bloc.dart';
import '../bloc/property_event.dart';

class AddEditPropertyPage extends StatefulWidget {
  final Map<String, dynamic>? property;

  const AddEditPropertyPage({Key? key, this.property}) : super(key: key);

  @override
  _AddEditPropertyPageState createState() => _AddEditPropertyPageState();
}

class _AddEditPropertyPageState extends State<AddEditPropertyPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
        text: widget.property != null ? widget.property!['name'] : '');
    _descriptionController = TextEditingController(
        text: widget.property != null ? widget.property!['description'] : '');
    _priceController = TextEditingController(
        text: widget.property != null
            ? widget.property!['price'].toString()
            : '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _saveProperty() {
    if (_formKey.currentState!.validate()) {
      final property = {
        'name': _nameController.text,
        'description': _descriptionController.text,
        'price': _priceController.text,
      };

      // Include the image if available
      if (_selectedImage != null) {
        property['image'] = _selectedImage!.path;
      }

      if (widget.property != null) {
        // Edit Property
        context
            .read<PropertyBloc>()
            .add(UpdateProperty(widget.property!['id'], property));
      } else {
        // Add Property
        context.read<PropertyBloc>().add(AddProperty(property));
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.property != null ? 'Edit Property' : 'Add Property'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a name' : null,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a description' : null,
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a price' : null,
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _pickImage,
                  child: _selectedImage != null
                      ? Image.file(
                          _selectedImage!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        )
                      : widget.property != null &&
                              widget.property!['image'] != null
                          ? Image.network(
                              widget.property!['image'],
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 150,
                              width: 150,
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.add_photo_alternate,
                                size: 50,
                              ),
                            ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _saveProperty,
                  child: const Text('Save Property'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
