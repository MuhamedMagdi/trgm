# Trgm - Key-Message Translation Tool

This tool provides a simple way to translate a given message based on the provided key across multiple languages. It supports various languages and outputs the corresponding translation for a given key.

## Installation

To install the `trgm` tool, follow these steps:

**Clone the repository**:
```sh
git clone <repository_url>
```

**Navigate to the project directory**:
```sh
cd trgm
```

**Build and install the tool**:
```sh
sudo make install
```

## Usage

### Running the tool

Once installed, you can run the tool by typing:
```sh
trgm
```

The tool will prompt you to input a key-message pair. You can enter the key and message in the following format:
```
key=message
```

Where:
```
key represents the identifier for the message.
message is the text to be translated.
```

### Example Input and Output

Upon execution, the tool will output translations for the given key in different languages. For example:

```sh
⋊> ~/p/trgm trgm

Enter the key and message to translate in the format 'key=message': key=message

Arabic
key=رسالة

French
key=message

Swahili
key=ujumbe

Kinyarwanda
key=ubutumwa
```