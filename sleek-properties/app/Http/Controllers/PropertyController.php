<?php

namespace App\Http\Controllers;

use App\Models\Property;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class PropertyController extends Controller
{
    public function index()
    {
        return Property::all();
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string',
            'description' => 'required|string',
            'price' => 'required|numeric',
            'image' => 'nullable|image|max:2048',
        ]);
    
        if ($request->hasFile('image')) {
            $validated['image'] = $request->file('image')->store('uploads', 'public');
        }
    
        $property = Property::create($validated);
        return response()->json($property, 201);
    }
    
    public function update(Request $request, $id)
    {
        $property = Property::findOrFail($id);
    
        $validated = $request->validate([
            'name' => 'required|string',
            'description' => 'required|string',
            'price' => 'required|numeric',
            'image' => 'nullable|image|max:2048',
        ]);
    
        if ($request->hasFile('image')) {
            // Delete the old image if exists
            if ($property->image) {
                Storage::delete('public/uploads' . $property->image);
            }
            $validated['image'] = $request->file('image')->store('uploads', 'public');
        }
    
        $property->update($validated);
        return response()->json($property);
    }
    

    public function destroy($id)
    {
        Property::findOrFail($id)->delete();
        return response()->json(['message' => 'Deleted successfully']);
    }
}
