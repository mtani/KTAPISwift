//
//  EndPoint.swift
//  KuveytTurkAPISwift
//
//  Created by Kuveyt Türk on 27.12.2017.
//  Copyright © 2017 Kuveyt Türk. All rights reserved.
//

import UIKit
import p2_OAuth2

/**
 An Enum class about endpoints
 */
public class EndPoint {
    
    
    public enum EndPointType {
        case Accounts
        case AccountTransactions
        case Receipt
        case UserOTPSend
        case UserOTPVerify
        case MoneyTransferExecute
        case MoneyTransferToIBAN
        case MoneyTransferToAccount
        case MoneyTransferToName
        case CashWithdrawalFromATMviaQRCode
        case MoneyTransferToGSM
        case MoneyTransferToGSMTransactions
        case MoneyTransferToGSMCanceling
        case LoanFinanceList
        case KuveytTurkXTMList
        case KuveytTurkATMList
        case BankList
        case BankBranchList
        case FXCurrencyRates
        case FxCurrencyList
        case LoanFinanceCalculation
        case LoanFinanceCalculationParameter
        case LoanFinanceInstallments
        case LoanFinanceInfo
        case TestCustomerList
        case KuveytTurkBranchList
    }
}



