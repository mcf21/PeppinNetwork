//
//  NetworkError.swift
//  PeppinNetwork
//
//  Created by Major League Digital on 10/8/21.
//

import Foundation

public enum NetworkError: Error {
    case badURL
    case cannotGetData
    case networkConnectionFailed
    case cannotDecode
}
