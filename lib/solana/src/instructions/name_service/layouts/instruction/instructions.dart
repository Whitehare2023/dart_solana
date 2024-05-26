import 'package:solana/solana/src/layout/layout.dart';

class NameServiceProgramInstruction implements ProgramLayoutInstruction {
  @override
  final int insturction;
  @override
  final String name;
  const NameServiceProgramInstruction(this.insturction, this.name);
  static const NameServiceProgramInstruction create =
      NameServiceProgramInstruction(0, "Create");
  static const NameServiceProgramInstruction update =
      NameServiceProgramInstruction(1, "Update");
  static const NameServiceProgramInstruction transfer =
      NameServiceProgramInstruction(2, "Transfer");
  static const NameServiceProgramInstruction delete =
      NameServiceProgramInstruction(3, "Delete");
  static const NameServiceProgramInstruction realloc =
      NameServiceProgramInstruction(4, "Realloc");

  static const List<NameServiceProgramInstruction> values = [
    create,
    update,
    transfer,
    delete,
    realloc
  ];
  static NameServiceProgramInstruction? getInstruction(dynamic value) {
    try {
      return values.firstWhere((element) => element.insturction == value);
    } on StateError {
      return null;
    }
  }
}
