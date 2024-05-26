import 'package:solana/solana/src/layout/layout.dart';

/// Additional fee information on a reserve
///
/// These exist separately from interest accrual fees, and are specifically for
/// the program owner and frontend host. The fees are paid out as a percentage
/// of liquidity token amounts during repayments and liquidations.
class ReserveFeesConfig {
  /// Fee assessed on `BorrowObligationLiquidity`, expressed as a Wad.
  /// Must be between 0 and 10^18, such that 10^18 = 1.  A few examples for
  /// clarity:
  /// 1% = 10_000_000_000_000_000
  /// 0.01% (1 basis point) = 100_000_000_000_000
  /// 0.00001% (Aave borrow fee) = 100_000_000_000
  final BigInt borrowFeeWad;

  /// Fee for flash loan, expressed as a Wad.
  /// 0.3% (Aave flash loan fee) = 3_000_000_000_000_000
  final BigInt flashLoanFeeWad;

  /// Amount of fee going to host account, if provided in liquidate and repay
  final int hostFeePercentage;
  const ReserveFeesConfig(
      {required this.borrowFeeWad,
      required this.flashLoanFeeWad,
      required this.hostFeePercentage});
  factory ReserveFeesConfig.fromJson(Map<String, dynamic> json) {
    return ReserveFeesConfig(
        borrowFeeWad: json["borrowFeeWad"],
        flashLoanFeeWad: json["flashLoanFeeWad"],
        hostFeePercentage: json["hostFeePercentage"]);
  }

  static Structure layout = LayoutUtils.struct([
    LayoutUtils.u64('borrowFeeWad'),
    LayoutUtils.u64('flashLoanFeeWad'),
    LayoutUtils.u8('hostFeePercentage')
  ], "fees");

  Map<String, dynamic> serialize() {
    return {
      "borrowFeeWad": borrowFeeWad,
      "flashLoanFeeWad": flashLoanFeeWad,
      "hostFeePercentage": hostFeePercentage
    };
  }

  @override
  String toString() {
    return "ReserveFeesConfig${serialize()}";
  }
}
