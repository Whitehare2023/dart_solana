import 'package:dart_solana/solana/src/instructions/metaplex/gumdrop/layouts/instruction/instruction.dart';
import 'package:dart_solana/solana/src/layout/layout.dart';

class MetaplexGumdropCloseDistributorLayout
    extends MetaplexGumdropProgramLayout {
  final int walletBump;
  final int bump;
  const MetaplexGumdropCloseDistributorLayout(
      {required this.walletBump, required this.bump});

  factory MetaplexGumdropCloseDistributorLayout.fromBuffer(List<int> data) {
    final decode = MetaplexGumdropProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexGumdropProgramInstruction.closeDistributor.insturction);
    return MetaplexGumdropCloseDistributorLayout(
        walletBump: decode["walletBump"], bump: decode["bump"]);
  }

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("bump"),
    LayoutUtils.u8("walletBump"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexGumdropProgramInstruction.closeDistributor.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"bump": bump, "walletBump": walletBump};
  }
}
