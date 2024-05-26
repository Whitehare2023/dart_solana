import 'package:solana/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:solana/solana/src/instructions/metaplex/candy_machine_core/types/candy_machine_types/types/candy_machine_data.dart';
import 'package:solana/solana/src/instructions/metaplex/token_meta_data/types/types/token_standard.dart';
import 'package:solana/solana/src/layout/layout.dart';

class MetaplexCandyMachineInitializeCandyMachineV2Layout
    extends MetaplexCandyMachineProgramLayout {
  final CandyMachineData data;
  final MetaDataTokenStandard tokenStandard;
  const MetaplexCandyMachineInitializeCandyMachineV2Layout(
      {required this.data, required this.tokenStandard});

  factory MetaplexCandyMachineInitializeCandyMachineV2Layout.fromBuffer(
      List<int> data) {
    final decode = MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction
            .initializeCandyMachineV2.insturction);
    return MetaplexCandyMachineInitializeCandyMachineV2Layout(
        data: CandyMachineData.fromJson(decode["candyMachineData"]),
        tokenStandard: MetaDataTokenStandard.fromJson(decode["tokenStandard"]));
  }
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    CandyMachineData.staticLayout,
    LayoutUtils.wrap(MetaDataTokenStandard.staticLayout,
        property: "tokenStandard")
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction => MetaplexCandyMachineProgramInstruction
      .initializeCandyMachineV2.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "candyMachineData": data.serialize(),
      "tokenStandard": tokenStandard.serialize()
    };
  }
}
