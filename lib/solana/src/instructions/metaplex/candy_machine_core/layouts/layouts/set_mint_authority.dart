import 'package:solana/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:solana/solana/src/layout/layout.dart';

class MetaplexCandyMachineSetMintAuthorityLayout
    extends MetaplexCandyMachineProgramLayout {
  const MetaplexCandyMachineSetMintAuthorityLayout();

  factory MetaplexCandyMachineSetMintAuthorityLayout.fromBuffer(
      List<int> data) {
    MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction
            .setMintAuthority.insturction);
    return MetaplexCandyMachineSetMintAuthorityLayout();
  }
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.blob(8, property: "instruction")]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexCandyMachineProgramInstruction.setMintAuthority.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
