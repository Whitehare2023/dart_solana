import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.publicKey('delegate'),
  ]);

  static int get accountSize => layout.span;

  static Map<String, dynamic> decode(List<int> extensionData) {
    try {
      if (extensionData.length < accountSize) {
        throw MessageException("Account data length is insufficient.",
            details: {"Expected": accountSize, "length": extensionData.length});
      }
      return LayoutSerializable.decode(bytes: extensionData, layout: layout);
    } catch (e) {
      throw MessageException("Invalid extionsion bytes");
    }
  }

  static Map<String, dynamic> decodeFromAccount(List<int> accountBytes) {
    try {
      final extensionBytes =
          SPLToken2022Utils.readExtionsionBytesFromAccountData(
              accountBytes: accountBytes,
              extensionType: ExtensionType.permanentDelegate,
              type: SolanaTokenAccountType.mint);
      return LayoutSerializable.decode(bytes: extensionBytes, layout: layout);
    } catch (e) {
      throw MessageException("Invalid extionsion bytes");
    }
  }
}

class PermanentDelegate extends LayoutSerializable {
  final SolAddress delegate;
  const PermanentDelegate({required this.delegate});

  factory PermanentDelegate.fromBuffer(List<int> extensionData) {
    final decode = _Utils.decode(extensionData);
    return PermanentDelegate(delegate: decode["delegate"]);
  }
  factory PermanentDelegate.fromAccountBytes(List<int> accountBytes) {
    final decode = _Utils.decodeFromAccount(accountBytes);
    return PermanentDelegate(delegate: decode["delegate"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {"delegate": delegate};
  }

  @override
  String toString() {
    return "PermanentDelegate${serialize()}";
  }
}
