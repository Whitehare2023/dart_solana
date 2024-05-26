import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class SolanaTokenAccountUtils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.publicKey('mint'),
    LayoutUtils.publicKey('owner'),
    LayoutUtils.u64('amount'),
    LayoutUtils.boolean32('delegateOption'),
    LayoutUtils.publicKey('delegate'),
    LayoutUtils.u8('state'),
    LayoutUtils.boolean32('isNativeOption'),
    LayoutUtils.u64('rentExemptReserve'),
    LayoutUtils.u64('delegatedAmount'),
    LayoutUtils.boolean32('closeAuthorityOption'),
    LayoutUtils.publicKey('closeAuthority'),
  ]);

  static int get accountSize => layout.span;
  static const int accountTypeSize = 1;
}

/// Account data.
class SolanaTokenAccount extends LayoutSerializable {
  final SolAddress address;

  /// The mint associated with this account
  final SolAddress mint;

  /// The owner of this account.
  final SolAddress owner;

  /// The amount of tokens this account holds.
  final BigInt amount;

  /// If [delegate] is Some then [delegatedAmount] represents
  /// the amount authorized by the delegate
  final SolAddress? delegate;

  /// The amount delegated
  final BigInt delegatedAmount;

  /// The account's state
  final AccountState state;
  final BigInt? rentExemptReserve;

  /// Optional authority to close the account.
  final SolAddress? closeAuthority;

  /// this is a native token, and the value logs the
  /// rent-exempt reserve. An Account is required to be rent-exempt, so
  /// the value is used by the Processor to ensure that wrapped SOL
  /// accounts do not drop below this threshold.
  bool get isNative => rentExemptReserve != null;

  const SolanaTokenAccount(
      {required this.address,
      required this.mint,
      required this.owner,
      required this.amount,
      required this.delegate,
      required this.delegatedAmount,
      required this.rentExemptReserve,
      required this.closeAuthority,
      required this.state});
  factory SolanaTokenAccount.fromBuffer(
      {required List<int> data, required SolAddress address}) {
    if (data.length < SolanaTokenAccountUtils.accountSize) {
      throw MessageException("Account data length is insufficient.", details: {
        "Expected": SolanaTokenAccountUtils.accountSize,
        "length": data.length
      });
    }
    final decode = LayoutSerializable.decode(
        bytes: data, layout: SolanaTokenAccountUtils.layout);
    final bool delegateOption = decode["delegateOption"];
    final bool isNativeOption = decode["isNativeOption"];
    final bool hasCloseAuthority = decode["closeAuthorityOption"];
    final AccountState state = AccountState.fromValue(decode["state"]);
    if (data.length > SolanaTokenAccountUtils.accountSize) {
      final accountType = SolanaTokenAccountType.fromValue(
          data[SolanaTokenAccountUtils.accountSize]);
      if (accountType != SolanaTokenAccountType.account) {
        throw MessageException("Invalid account type.", details: {
          "account type": accountType.name,
          "Excepted": SolanaTokenAccountType.account
        });
      }
    }
    return SolanaTokenAccount(
        address: address,
        mint: decode["mint"],
        owner: decode["owner"],
        amount: decode["amount"],
        delegate: delegateOption ? decode["delegate"] : null,
        delegatedAmount: decode["delegatedAmount"],
        state: state,
        rentExemptReserve: isNativeOption ? decode["rentExemptReserve"] : null,
        closeAuthority: hasCloseAuthority ? decode["closeAuthority"] : null);
  }

  @override
  Structure get layout => SolanaTokenAccountUtils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "mint": mint,
      "owner": owner,
      "amount": amount,
      "delegateOption": delegate == null ? false : true,
      "delegate": delegate ?? SolAddress.defaultPubKey,
      "delegatedAmount": delegatedAmount,
      "state": state.value,
      "isNativeOption": isNative,
      "rentExemptReserve": rentExemptReserve ?? BigInt.zero,
      "closeAuthorityOption": closeAuthority == null ? false : true,
      "closeAuthority": closeAuthority ?? SolAddress.defaultPubKey,
    };
  }

  @override
  String toString() {
    return "SolanaTokenAccount${serialize()}";
  }
}
