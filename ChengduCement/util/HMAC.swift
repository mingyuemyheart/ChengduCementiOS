//
//  HMAC.swift
//  ChengduCement
//
//  Created by 孙晓明 on 2020/8/10.
//  Copyright © 2020 孙晓明. All rights reserved.
//

import Foundation
import CryptoKit

/**
sha-256加密，iOS13以上才可用
*/
@available(iOS 13.0, *)
extension Digest {
    var bytes: [UInt8] { Array(makeIterator()) }
    var data: Data { Data(bytes) }
    var hexStr: String {
        bytes.map { String(format: "%02X", $0) }.joined()
    }
}

@available(iOS 13.0, *)
func sha256(content: String) -> String {
    guard let data = content.data(using: .utf8) else { return "" }
    let digest = SHA256.hash(data: data)
//    print(digest.data) // 32 bytes
    print(digest.hexStr.lowercased()) // B94D27B9934D3E08A52E52D7DA7DABFAC484EFE37A5380EE9088F7ACE2EFCDE9
    return digest.hexStr.lowercased()
}

/**
 sha-256加密
 */
extension String {
    func sha256() -> String {
        if let stringData = self.data(using: String.Encoding.utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
    }

    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }

    private func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)

        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        return hexString
    }

}
