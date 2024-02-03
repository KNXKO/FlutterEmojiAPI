# Emoji Dart Code

This Dart code provides a model (`Emoji`) and methods for parsing JSON data related to emojis. It includes enums for emoji categories and groups. The primary use case seems to be handling emoji data, with parsing logic designed for a specific structure.

## Dependencies

- [Dart](https://dart.dev/): A programming language optimized for building mobile, desktop, server, and web applications.

## Usage

1. Ensure Dart is installed. If not, follow the [Dart installation guide](https://dart.dev/get-dart).
2. Copy the provided Dart code into your Dart/Flutter project.
3. Ensure necessary dependencies like `http` and `html` are created or imported.
4. Run the Dart code to observe its functionality.

## Emoji Model

### `Emoji` Class

- Represents an emoji with properties such as name, category, group, HTML code, and Unicode.

#### Methods

- `fromJson`: Factory method to create an `Emoji` object from a JSON map.
- `toJson`: Converts an `Emoji` object to a JSON map.

### Enums

- `Category`: Enumerates emoji categories.
- `Group`: Enumerates emoji groups.

### `EnumValues` Class

- Helper class for mapping enum values to strings and vice versa.

## Note

This code is part of a larger project and assumes integration with Flutter. The actual behavior may depend on data retrieved from the specified API (`https://emojihub.yurace.pro/api/all`).

Feel free to integrate and modify this code based on your project's requirements.

For any questions or further assistance, please don't hesitate to reach out.
