import 'package:solana/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:solana/solana/src/layout/layout.dart';

class SPLToken2022WithdrawWithheldTokensFromMintLayout
    extends SPLTokenProgramLayout {
  SPLToken2022WithdrawWithheldTokensFromMintLayout();

  factory SPLToken2022WithdrawWithheldTokensFromMintLayout.fromBuffer(
      List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.transferFeeExtension.insturction,
    );
    return SPLToken2022WithdrawWithheldTokensFromMintLayout();
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u8("transferFee"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  final int instruction =
      SPLTokenProgramInstruction.transferFeeExtension.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "transferFee": TransferFeeInstructionInstruction
          .withdrawWithheldTokensFromMint.value,
    };
  }
}
