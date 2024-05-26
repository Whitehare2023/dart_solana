import 'package:dart_solana/solana/src/address/sol_address.dart';
import 'package:dart_solana/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:dart_solana/solana/src/layout/layout.dart';

/// Update the metadata pointer address layout.
class SPLToken2022UpdateMetadataPointerLayout extends SPLTokenProgramLayout {
  /// The new account address that holds the metadata
  final SolAddress? metadataAddress;
  SPLToken2022UpdateMetadataPointerLayout({required this.metadataAddress});

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.wrap(MetadataPointerInstruction.staticLayout,
        property: "metadataPointer"),
    LayoutUtils.publicKey("metadataAddress"),
  ]);

  factory SPLToken2022UpdateMetadataPointerLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction:
            SPLTokenProgramInstruction.metadataPointerExtension.insturction);
    return SPLToken2022UpdateMetadataPointerLayout(
        metadataAddress: decode["authority"] == SolAddress.defaultPubKey
            ? null
            : decode["authority"]);
  }

  @override
  Structure get layout => _layout;

  @override
  final int instruction =
      SPLTokenProgramInstruction.metadataPointerExtension.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "metadataPointer": MetadataPointerInstruction.update.serialize(),
      "metadataAddress": metadataAddress ?? SolAddress.defaultPubKey
    };
  }
}
