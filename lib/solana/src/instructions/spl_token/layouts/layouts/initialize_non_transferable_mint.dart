// Manages the layout structure for initializing a non-transferable mint for an SPL token.
import 'package:dart_solana/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:dart_solana/solana/src/layout/layout.dart';

/// Initialize the non transferable extension for the given mint account layout.
class SPLTokenInitializeNonTransferableMintLayout
    extends SPLTokenProgramLayout {
  /// Constructs an SPLTokenInitializeNonTransferableMintLayout instance.
  SPLTokenInitializeNonTransferableMintLayout();

  /// Structure structure for initializing a non-transferable mint.
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  /// Constructs an SPLTokenInitializeNonTransferableMintLayout instance from buffer.
  factory SPLTokenInitializeNonTransferableMintLayout.fromBuffer(
      List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenProgramInstruction.initializeNonTransferableMint.insturction,
    );
    return SPLTokenInitializeNonTransferableMintLayout();
  }

  /// Returns the layout structure.
  @override
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction =
      SPLTokenProgramInstruction.initializeNonTransferableMint.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
