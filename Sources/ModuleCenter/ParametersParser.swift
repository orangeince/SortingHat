//
//  ParametersParser.swift
//  SortingHat
//
//  Created by 少 on 2019/3/1.
//

import Foundation

public struct ParametersParser {
    /// Parse enum's associatedtype tuple to a dict format
    public static func parse(enumType: Any) -> [String: Any] {
        var params = [String: Any]()
        let mir = Mirror(reflecting: enumType)
        for (_, value) in mir.children {
            let subMir = Mirror(reflecting: value)
            for (subLabel, subValue) in subMir.children {
                guard let key = subLabel  else { break }
                params[key] = subValue
            }
        }
        return params
    }
}
