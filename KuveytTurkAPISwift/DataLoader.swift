//
//  DataLoader.swift
//  KuveytTurkAPISwift
//
//  Created by Kuveyt Türk on 26.12.2017.
//  Copyright © 2017 Kuveyt Türk. All rights reserved.
//

import UIKit
import p2_OAuth2

/**
 A class that makes loading data from a protected endpoint easier.
 */
public class DataLoader: OAuth2DataLoader {
    
    /**
     This method takes endpoint name, oauth2 object and parameters to create an URL. Returns URLRequest
     
     - parameter endpoint:   The endpoint to call
     - parameter oauth2:     The OAuth2 instance to use for authorization when loading data.
     - parameter parameters: Request parameters
     */
    public func createMethodRequest(enpoint: EndPoint.EndPointType, oauth2: OAuth2Base, parameters: [String: String]?) -> URLRequest?
    {
        var bodyData : Data?
        oauth2.clientConfig.parameters = parameters
        var components = URLComponents()
        components.scheme = ConnectionOptions.urlSchema
        components.host = ConnectionOptions.host
        
        let endPointModel: EndPointModel? = getEndPointModel(endPoint: enpoint)
        
        if((endPointModel != nil) && (endPointModel?.endPointPath) != nil)
        {
            components.path = endPointModel!.endPointPath!
        }
        else{
            return nil
        }
        
        
        if(oauth2.clientConfig.parameters != nil){
            if(endPointModel?.endPointHttpMethod == .GET){
                var queryItems = [URLQueryItem]()
                for (key, value) in oauth2.clientConfig.parameters! {
                    queryItems.append(URLQueryItem(name: key, value: value))
                }
                
                components.queryItems = queryItems
                oauth2.clientConfig.query = components.query!
                oauth2.clientConfig.isPostMethod = false
            }
            else{
                do{
                    bodyData = try JSONSerialization.data(withJSONObject: oauth2.clientConfig.parameters as Any, options: [])
                }catch{
                    
                }
                oauth2.clientConfig.query =  String(data: bodyData!, encoding: String.Encoding.utf8)
                oauth2.clientConfig.isPostMethod = true
            }
        }
        
        oauth2.clientConfig.isPublicEndPoint = endPointModel?.isPublicEndPoint
        
        var request = URLRequest (url: components.url!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("1", forHTTPHeaderField: "LanguageId")
        request.httpMethod = (endPointModel?.endPointHttpMethod.rawValue)!
        if((bodyData != nil) && endPointModel?.endPointHttpMethod == .POST)
        {
            request.httpBody = bodyData
        }
        return request
        
    }
    
    /**
     This method takes  path, endpoint name, oauth2 object and parameters to create an URL. Returns URLRequest
     
     - parameter path:       The URL path for request
     - parameter endpoint:   The endpoint type to call
     - parameter oauth2:     The OAuth2 instance to use for authorization when loading data.
     - parameter parameters: Request parameters
     */
    public func createMethodRequestWith(path: String, enpoint: EndPoint.EndPointType, oauth2: OAuth2Base, parameters: [String: String]?) -> URLRequest?
    {
        var bodyData : Data?
        oauth2.clientConfig.parameters = parameters
        var components = URLComponents()
        components.scheme = ConnectionOptions.urlSchema
        components.host = ConnectionOptions.host
        
        let endPointModel: EndPointModel? = getEndPointModelWith(path: path, endPoint: enpoint)
        
        if((endPointModel != nil) && (endPointModel?.endPointPath) != nil)
        {
            components.path = endPointModel!.endPointPath!
        }
        else {
            return nil
        }
        
        if(oauth2.clientConfig.parameters != nil)
        {
            if(endPointModel?.endPointHttpMethod == .GET)
            {
                var queryItems = [URLQueryItem]()
                for (key, value) in oauth2.clientConfig.parameters! {
                    queryItems.append(URLQueryItem(name: key, value: value))
                }
                
                components.queryItems = queryItems
                oauth2.clientConfig.query = components.query!
                oauth2.clientConfig.isPostMethod = false
            }
            else
            {
                do{
                    bodyData = try JSONSerialization.data(withJSONObject: oauth2.clientConfig.parameters as Any, options: [])
                }catch{
                    
                }
                oauth2.clientConfig.query =  String(data: bodyData!, encoding: String.Encoding.utf8)
                oauth2.clientConfig.isPostMethod = true
            }
        }
        
        oauth2.clientConfig.isPublicEndPoint = endPointModel?.isPublicEndPoint
        
        var request = URLRequest (url: components.url!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("1", forHTTPHeaderField: "LanguageId")
        request.httpMethod = (endPointModel?.endPointHttpMethod.rawValue)!
        if((bodyData != nil) && endPointModel?.endPointHttpMethod == .POST)
        {
            request.httpBody = bodyData
        }
        return request
        
    }
    
    /**
     This method takes endpoint type to create and return EndPoint Model
     
     - parameter endpoint:   The endpoint type to call
     */
    
    func getEndPointModel(endPoint: EndPoint.EndPointType) -> EndPointModel? {
        
        if(endPoint == .Accounts){
            return EndPointModel.init(endPointPath: "/prep/v1/accounts", endPointHttpMethod: .GET , isPublicEndPoint: false)
        }
        else if(endPoint == .UserOTPSend){
            return EndPointModel.init(endPointPath: "/prep/v1/user/otp", endPointHttpMethod: .POST , isPublicEndPoint: false)
        }
        else if(endPoint == .UserOTPVerify){
            return EndPointModel.init(endPointPath: "/prep/v1/user/otp/verify", endPointHttpMethod: .POST , isPublicEndPoint: false)
        }
        else if(endPoint == .MoneyTransferExecute){
            return EndPointModel.init(endPointPath: "/prep/v1/transfers/execute", endPointHttpMethod:.POST , isPublicEndPoint: false)
        }
        else if (endPoint == .MoneyTransferToIBAN){
            return EndPointModel.init(endPointPath: "/prep/v1/transfers/toIBAN", endPointHttpMethod: .POST, isPublicEndPoint: false)
        }
        else if (endPoint == .MoneyTransferToAccount){
            return EndPointModel.init(endPointPath: "/prep/v1/transfers/toAccount", endPointHttpMethod: .POST, isPublicEndPoint: false)
        }
        else if (endPoint == .MoneyTransferToName){
            return EndPointModel.init(endPointPath: "/prep/v1/transfers/toName", endPointHttpMethod: .POST, isPublicEndPoint: false)
        }
        else if (endPoint == .CashWithdrawalFromATMviaQRCode){
            return EndPointModel.init(endPointPath: "/prep/v1/transfers/fromATMByQRCode", endPointHttpMethod: .POST, isPublicEndPoint: false)
        }
        else if (endPoint == .MoneyTransferToGSM){
            return EndPointModel.init(endPointPath: "/prep/v1/transfers/toGSM", endPointHttpMethod: .POST, isPublicEndPoint: false)
        }
        else if(endPoint == .MoneyTransferToGSMTransactions){
            return EndPointModel.init(endPointPath: "/prep/v1/transfers/toGSM/transactions", endPointHttpMethod: .POST, isPublicEndPoint: false)
        }
        else if(endPoint == .MoneyTransferToGSMCanceling){
            return EndPointModel.init(endPointPath: "/prep/v1/transfers/toGSM/cancel", endPointHttpMethod: .POST, isPublicEndPoint: false)
        }
        else if(endPoint == .FXCurrencyRates){
            return EndPointModel.init(endPointPath: "/prep/v1/fx/rates", endPointHttpMethod: .GET, isPublicEndPoint: true)
        }
        else if(endPoint == .FxCurrencyList){
            return EndPointModel.init(endPointPath: "/prep/v1/data/fecs", endPointHttpMethod: .GET, isPublicEndPoint: true)
        }
        else if(endPoint == .KuveytTurkBranchList){
            return EndPointModel.init(endPointPath: "/prep/v1/data/branches", endPointHttpMethod:.GET , isPublicEndPoint: true)
        }
        else if(endPoint == .BankList){
            return EndPointModel.init(endPointPath: "/prep/v1/data/banks", endPointHttpMethod:.GET , isPublicEndPoint: true)
        }
        else if(endPoint == .KuveytTurkXTMList){
            return EndPointModel.init(endPointPath: "/prep/v1/data/xtms", endPointHttpMethod:.GET , isPublicEndPoint: true)
        }
        else if(endPoint == .KuveytTurkATMList){
            return EndPointModel.init(endPointPath: "/prep/v1/data/atms", endPointHttpMethod:.GET , isPublicEndPoint: true)
        }
        else if(endPoint == .LoanFinanceCalculation){
            return EndPointModel.init(endPointPath: "/prep/v1/calculations/loan", endPointHttpMethod:.GET , isPublicEndPoint: true)
        }
        else if(endPoint == .LoanFinanceCalculationParameter){
            return EndPointModel.init(endPointPath: "/prep/v1/data/loans", endPointHttpMethod:.GET , isPublicEndPoint: true)
        }
        else if(endPoint == .LoanFinanceList){
            return EndPointModel.init(endPointPath: "/prep/v1/loans", endPointHttpMethod:.GET , isPublicEndPoint: false)
        }
        else if(endPoint == .TestCustomerList){
            return EndPointModel.init(endPointPath: "/prep/v1/data/testcustomers", endPointHttpMethod:.GET , isPublicEndPoint: true)
        }
        else {
            return nil
        }
    }
    
    /**
     This method takes path and endpoint type to create and return EndPoint Model
     
     - parameter endpoint:   The endpoint type to call
     */
    func getEndPointModelWith(path: String, endPoint: EndPoint.EndPointType) -> EndPointModel? {
        if(endPoint == .LoanFinanceInstallments){
            return EndPointModel.init(endPointPath: path, endPointHttpMethod:.GET , isPublicEndPoint: false)
        }
        else if(endPoint == .LoanFinanceInfo){
            return EndPointModel.init(endPointPath: path, endPointHttpMethod:.GET , isPublicEndPoint: false)
        }
        else if(endPoint == .BankBranchList){
            return EndPointModel.init(endPointPath: path, endPointHttpMethod: .GET, isPublicEndPoint: true)
        }
        else if(endPoint == .Receipt)
        {
            return EndPointModel.init(endPointPath: path, endPointHttpMethod: .GET , isPublicEndPoint: false)
        }
        else if(endPoint == .AccountTransactions)
        {
            return EndPointModel.init(endPointPath: path, endPointHttpMethod: .GET , isPublicEndPoint: false)
        }
        else {
            return nil
        }
    }
    
    override open func perform(request: URLRequest, callback: @escaping ((OAuth2Response) -> Void)) {
        
        super.perform(request: request, callback: callback)
    }
    
}

