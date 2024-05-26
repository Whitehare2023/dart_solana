import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:dart_solana/solana/src/layout/layout.dart';

abstract class MetaplexCandyMachineProgramLayout extends ProgramLayout {
  const MetaplexCandyMachineProgramLayout();
  @override
  abstract final List<int> instruction;
  static ProgramLayout fromBytes(List<int> data) {
    return UnknownProgramLayout(data);
  }

  static Map<String, dynamic> decodeAndValidateStruct({
    required Structure layout,
    required List<int> bytes,
    required List<int> instruction,
  }) {
    final decode = layout.decode(bytes);
    final instcutionData = decode["instruction"];
    if (!bytesEqual(instcutionData, instruction)) {
      throw MessageException("invalid instruction bytes", details: {
        "expected": BytesUtils.toHexString(instruction),
        "instruction": BytesUtils.toBinary(instcutionData)
      });
    }

    return decode;
  }
}
