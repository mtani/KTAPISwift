//
//  EndPointModel.swift
//  KuveytTurkAPISwift
//
//  Created by Mustafa Tanışır / Kuveyt Türk - BT-Dijital Bankacılık Yazılım Geliştirme on 28.12.2017.
//  Copyright © 2017 Kuveyt Türk. All rights reserved.
//

import UIKit

public class EndPointModel {
    
    public var endPointPath: String?
    public var endPointHttpMethod: HTTPMethodType!
    public var authorizationType: AuthorizationType!
    
    convenience init(endPointPath: String?, endPointHttpMethod: HTTPMethodType, authorizationType: AuthorizationType) {
        self .init()
        self.endPointPath = endPointPath
        self.endPointHttpMethod = endPointHttpMethod
        self.authorizationType = authorizationType
    }
}
