//
//  String+md5.swift
//  MarvelCharacters
//
//  Created by Adrián García Ledesma on 22/6/21.
//

import Foundation
import CryptoKit

func md5Hash(_ source: String) -> String {
    return Insecure.MD5.hash(data: source.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
}
