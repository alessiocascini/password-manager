import 'dart:convert';
import 'dart:io';

/// Reads a JSON file and returns its content as a [Map<String, dynamic>].
///
/// If the file does not exist, it will be created and an empty map will be returned.
/// If the file content is empty or cannot be parsed as a valid JSON object, an empty map is returned.
///
/// [file]: The file to read from.
/// Returns a [Map<String, dynamic>] representing the parsed JSON data.
Future<Map<String, dynamic>> readJSONFile(final File file) async {
  // Check if the file exists; if not, create it and return an empty map.
  if (!await file.exists()) {
    await file.create(recursive: true);
    return {};
  }

  // Read the content of the file as a string.
  String lines = await file.readAsString();

  // If the content is empty (including whitespace-only strings) or not a valid JSON object, return an empty map.
  if (lines.trim().isEmpty || jsonDecode(lines) is! Map<String, dynamic>) {
    return {};
  }

  // Return the parsed JSON content as a map.
  return jsonDecode(lines);
}
