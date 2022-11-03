//
//  DigiAnalyticsExtension.swift
//  iosApp
//
//  Created by Nathan Fallet on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import DigiAnalytics

extension DigiAnalytics {

    #if DEBUG
    static let shared = DigiAnalytics(baseURL: "https://debug.playground.makth.org/")
    #else
    static let shared = DigiAnalytics(baseURL: "https://playground.makth.org/")
    #endif

}
