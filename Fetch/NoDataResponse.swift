//
//  NoDataResponse.swift
//  Fetch
//
//  Created by David Haynes on 14/12/2017.
//  Copyright © 2017 David Hardiman. All rights reserved.
//

import Foundation

/// Represents a response that has no data to parse
public struct NoDataResponse {}

/// Wraps HTTP error response codes in an Error
///
/// - httpError: The HTTP response error code
public enum NoDataResponseError: Error {
    case httpError(code: Int)
}

/// Use this result type when you don't want to parse (e.g. for a response with
/// no data). The result will be `success` for http status codes below 400, or
/// `failure` for anything else.
public typealias VoidResult = Result<NoDataResponse>

extension NoDataResponse: Parsable {
    public static func parse(from data: Data?, status: Int, headers: [String: String]?, errorParser: ErrorParsing.Type?, userInfo: [String: Any]?) -> VoidResult {
        if status < 400 {
            return .success(NoDataResponse())
        } else {
            return .failure(NoDataResponseError.httpError(code: status))
        }
    }
}
