import 'package:dart_solana/solana/src/layout/layout.dart';

/// An enumeration of valid ComputeBudgetInstructionType's
class ComputeBudgetProgramInstruction implements ProgramLayoutInstruction {
  @override
  final int insturction;
  @override
  final String name;
  const ComputeBudgetProgramInstruction(this.insturction, this.name);
  static const ComputeBudgetProgramInstruction requestUnits =
      ComputeBudgetProgramInstruction(0, "RequestUnits");
  static const ComputeBudgetProgramInstruction requestHeapFrame =
      ComputeBudgetProgramInstruction(1, "RequestHeapFrame");
  static const ComputeBudgetProgramInstruction setComputeUnitLimit =
      ComputeBudgetProgramInstruction(2, "SetComputeUnitLimit");
  static const ComputeBudgetProgramInstruction setComputeUnitPrice =
      ComputeBudgetProgramInstruction(3, "SetComputeUnitPrice");

  static const List<ComputeBudgetProgramInstruction> values = [
    requestUnits,
    requestHeapFrame,
    setComputeUnitLimit,
    setComputeUnitPrice
  ];
  static ComputeBudgetProgramInstruction? getInstruction(dynamic value) {
    try {
      return values.firstWhere((element) => element.insturction == value);
    } on StateError {
      return null;
    }
  }
}
