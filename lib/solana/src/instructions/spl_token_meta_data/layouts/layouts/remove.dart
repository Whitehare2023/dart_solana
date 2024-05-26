import 'package:solana/solana/src/instructions/spl_token_meta_data/layouts/instruction/instruction.dart';
import 'package:solana/solana/src/layout/layout.dart';

/// Removes a key-value pair in a token-metadata account layout.
class SPLTokenMetaDataRemoveFieldLayout extends SPLTokenMetaDataProgramLayout {
  /// Key to remove in the additional metadata portion
  final String key;

  /// If the idempotent flag is set to true, then the instruction will not
  /// error if the key does not exist
  final bool idempotent;

  /// Constructs a new instance of [SPLTokenMetaDataRemoveFieldLayout] with the provided key and idempotent flag.
  const SPLTokenMetaDataRemoveFieldLayout(
      {required this.key, required this.idempotent});

  /// Decodes the provided byte array to construct a new [SPLTokenMetaDataRemoveFieldLayout] instance.
  factory SPLTokenMetaDataRemoveFieldLayout.fromBuffer(List<int> bytes) {
    final decode = SPLTokenMetaDataProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instructionBytes:
            SPLTokenMetaDataProgramSplDiscriminate.remove.insturction);

    return SPLTokenMetaDataRemoveFieldLayout(
        idempotent: decode["idempotent"], key: decode["key"]);
  }

  /// Creates a static layout based on fields.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.boolean(property: "idempotent"),
    LayoutUtils.string("key"),
  ]);

  /// The layout structure of this remove field instruction.
  @override
  Structure get layout => _layout;

  /// Gets the instruction bytes for the remove field instruction.
  @override
  List<int> get instruction =>
      SPLTokenMetaDataProgramSplDiscriminate.remove.insturction;

  /// Serializes the remove field instruction data.
  @override
  Map<String, dynamic> serialize() {
    return {"key": key, "idempotent": idempotent};
  }
}
