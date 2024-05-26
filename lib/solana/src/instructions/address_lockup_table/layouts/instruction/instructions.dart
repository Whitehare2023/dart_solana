import 'package:solana/solana/src/layout/layout.dart';

class AddressLookupTableProgramInstruction implements ProgramLayoutInstruction {
  @override
  final int insturction;
  @override
  final String name;
  const AddressLookupTableProgramInstruction(this.insturction, this.name);
  static const AddressLookupTableProgramInstruction createLookupTable =
      AddressLookupTableProgramInstruction(0, "CreateLookupTable");
  static const AddressLookupTableProgramInstruction freezeLookupTable =
      AddressLookupTableProgramInstruction(1, "FreezeLookupTable");
  static const AddressLookupTableProgramInstruction extendLookupTable =
      AddressLookupTableProgramInstruction(2, "ExtendLookupTable");
  static const AddressLookupTableProgramInstruction deactivateLookupTable =
      AddressLookupTableProgramInstruction(3, "DeactivateLookupTable");
  static const AddressLookupTableProgramInstruction closeLookupTable =
      AddressLookupTableProgramInstruction(4, "CloseLookupTable");
  static const List<AddressLookupTableProgramInstruction> values = [
    createLookupTable,
    freezeLookupTable,
    extendLookupTable,
    deactivateLookupTable,
    closeLookupTable
  ];
  static AddressLookupTableProgramInstruction? getInstruction(dynamic value) {
    try {
      return values.firstWhere((element) => element.insturction == value);
    } on StateError {
      return null;
    }
  }
}
