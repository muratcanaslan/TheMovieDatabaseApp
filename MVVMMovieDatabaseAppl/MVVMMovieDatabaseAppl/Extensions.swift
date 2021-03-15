//
//  Extensions.swift
//  MVVMMovieDatabaseAppl
//
//  Created by Murat Can on 11.03.2021.
//

import UIKit
import Moya

extension UIColor {
    convenience init(rgb: UInt) {
       self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }
}
extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    var height: CGFloat {
        return frame.size.height
    }
    var left: CGFloat {
        return frame.origin.x
    }
    var right: CGFloat {
        return left + width
    }
    var top: CGFloat {
        return frame.origin.y
    }
    var bottom: CGFloat {
        return top + height
    }
}

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()
    
    static let displayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
}

extension String {
    static func formattedDate(string: String) -> String {
        guard let date = DateFormatter.dateFormatter.date(from: string) else {
            return string
        }
        return DateFormatter.displayDateFormatter.string(from: date)
    }
}

extension Encodable {
    var urlEncodedQueryString: Task {
        dictionary.urlEncodeQueryString
    }
    
    var dictionary: [String: Any] {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        guard let data = try? encoder.encode(self) else {
            return [:]
        }
        let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        return dict ?? [:]
    }
}

extension Dictionary {

    public var urlEncodeQueryString: Task {
        guard let parameters = self.compactMapValues({ $0 }) as? [String: Any] else { return .requestPlain }
        return Task.requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
}
