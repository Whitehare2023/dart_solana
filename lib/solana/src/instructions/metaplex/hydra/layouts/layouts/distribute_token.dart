import 'package:dart_solana/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:dart_solana/solana/src/layout/layout.dart';

class MetaplexHydraDistributeTokenLayout extends MetaplexHydraProgramLayout {
  final bool distributeForMint;
  const MetaplexHydraDistributeTokenLayout({required this.distributeForMint});

  factory MetaplexHydraDistributeTokenLayout.fromBuffer(List<int> data) {
    final decode = MetaplexHydraProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexHydraProgramInstruction.processDistributeToken.insturction);
    return MetaplexHydraDistributeTokenLayout(
        distributeForMint: decode["distributeForMint"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.boolean(property: "distributeForMint"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexHydraProgramInstruction.processDistributeToken.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"distributeForMint": distributeForMint};
  }
}
