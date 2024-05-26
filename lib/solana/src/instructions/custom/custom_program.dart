import 'package:dart_solana/solana/src/address/sol_address.dart';
import 'package:dart_solana/solana/src/layout/program_layouts/program_layout.dart';
import 'package:dart_solana/solana/src/models/models.dart';

class CustomProgram extends TransactionInstruction {
  CustomProgram({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, layout: layout, programId: programId);
}
