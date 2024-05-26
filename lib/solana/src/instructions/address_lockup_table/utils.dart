import 'package:dart_solana/solana/src/address/sol_address.dart';
import 'package:dart_solana/solana/src/layout/layout.dart';
import 'package:dart_solana/solana/src/models/pda/pda.dart';

import 'constant.dart';

class AddressLookupTableProgramUtils {
  static ProgramDerivedAddress findAddressLookupTableProgram(
      {required SolAddress authority, required BigInt recentSlot}) {
    return ProgramDerivedAddress.find(seedBytes: [
      authority.toBytes(),
      LayoutUtils.u64().serialize(recentSlot)
    ], programId: AddressLookupTableProgramConst.programId);
  }
}
