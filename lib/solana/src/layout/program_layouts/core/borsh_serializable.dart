import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:solana/solana/src/layout/layout.dart';

/// Abstract class for objects that can be serialized using a specific layout.
abstract class LayoutSerializable {
  const LayoutSerializable();

  /// The layout representing the structure of the object for serialization.
  abstract final Structure layout;

  /// Serializes the object to a map.
  Map<String, dynamic> serialize();

  /// Converts the object to bytes using Borsh serialization.
  List<int> toBytes() {
    final LayoutByteWriter data = LayoutByteWriter(layout.span);
    final size = layout.encode(serialize(), data);
    if (layout.span < 0) {
      return data.sublist(0, size);
    }
    return data.toBytes();
  }

  /// Converts the object to a hexadecimal string.
  String toHex() {
    return BytesUtils.toHexString(toBytes());
  }

  /// Decodes Borsh serialized bytes.
  ///
  /// - [bytes] : The bytes to decode.
  /// - [layout] : The layout representing the structure of the object.
  /// - [validator] (optional): A map used for validation.
  static Map<String, dynamic> decode(
      {required List<int> bytes,
      required Structure layout,
      Map<String, dynamic> validator = const {}}) {
    try {
      final decode = layout.decode(bytes);

      for (final i in validator.entries) {
        if (i.value is List) {
          if (!iterableIsEqual(i.value, decode[i.key])) {
            throw MessageException("cannot validate borsh bytes",
                details: {"excepted": validator, "instruction": decode});
          }
        } else {
          if (i.value != decode[i.key]) {
            throw MessageException("cannot validate borsh bytes",
                details: {"excepted": validator, "instruction": decode});
          }
        }
      }
      return decode;
    } catch (e) {
      throw MessageException("cannot validate borsh bytes");
    }
  }
}
