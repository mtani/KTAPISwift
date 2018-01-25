//
//  Enumerations.swift
//  KuveytTurkAPISwift
//
//  Created by Kuveyt Türk on 28.12.2017.
//  Copyright © 2017 Kuveyt Türk. All rights reserved.
//

import UIKit

public class Enumerations
{
    public enum AuthorizationType: Int {
        case ClientCredential
        case AuthorizationCode
    }
    
    public enum HTTPMethodType:String {
        case GET
        case POST
    }
    
}

