//
//  The MIT License (MIT)
//
//  Copyright (c) 2017 Srdan Rasic (@srdanrasic)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

extension String {
    func appendingPathComponent(_ pathComponent: String) -> String {
        return NSString(string: self).appendingPathComponent(pathComponent)
    }
}

extension Dictionary {
    var jsonString: String {
        if let json = try? JSONSerialization.data(withJSONObject: self, options: []), let stringValue = String(data: json, encoding: .utf8) {
            return stringValue
        } else {
            return ""
        }
    }
}

extension Array {
    var jsonString: String {
        if let json = try? JSONSerialization.data(withJSONObject: self, options: []), let stringValue = String(data: json, encoding: .utf8) {
            return stringValue
        } else {
            return ""
        }
    }
}

extension Dictionary {
    var keyValuePairs: String {
        return map { kv in
            let key = kv.key
            let value = "\(kv.value)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            return "\(key)=\(value)"
        }.joined(separator: "&")
    }
}

extension Dictionary {
    public mutating func merge(contentsOf dictionary: [Key: Value]) {
        dictionary.forEach { key, value in
            self[key] = value
        }
    }

    public func merging(contentsOf dictionary: [Key: Value]) -> [Key: Value] {
        var me = self
        me.merge(contentsOf: dictionary)
        return me
    }
}

public protocol OptionalProtocol {
    associatedtype Wrapped
    var _unbox: Wrapped? { get }
    init(nilLiteral: ())
    init(_ some: Wrapped)
}

extension Optional: OptionalProtocol {
    public var _unbox: Wrapped? {
        return self
    }
}

extension Dictionary where Value: OptionalProtocol {
    public var nonNils: [Key: Value.Wrapped] {
        var result: [Key: Value.Wrapped] = [:]

        forEach { pair in
            if let value = pair.value._unbox {
                result[pair.key] = value
            }
        }

        return result
    }
}

extension Decodable {
    public static func dataDecodeable<T>() -> ((Data) throws -> T) where T: Decodable {
        return { (data: Data) in
            let decoder: JSONDecoder = .init()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        }
    }
}

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    public func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension UIColor {
    static public let midnightGreen = UIColor.init(red: 17/255.0, green: 75/255.0, blue: 95/255.0, alpha: 1)
    static public let teaGreen = UIColor.init(red: 198/255, green: 218/255, blue: 191/255, alpha: 1)
    static public let champagne = UIColor.init(red: 243/255, green: 233/255, blue: 210/255, alpha: 1)
}

extension UIViewController {
    public func setGradientBackground(viewController: UIViewController) {
        let colorTop =  UIColor(red: 243/255.0, green: 233/255.0, blue: 210/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 17/255.0, green: 75/255.0, blue: 95/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = viewController.view.bounds
                
        switch viewController {
        case is UITableViewController:
            let tableViewController = viewController as! UITableViewController
            let backgroundView = UIView(frame: tableViewController.tableView.bounds)
            backgroundView.layer.insertSublayer(gradientLayer, at: 0)
            tableViewController.tableView.backgroundView = backgroundView
        default:
            viewController.view.layer.insertSublayer(gradientLayer, at:0)
        }
        
    }
}
