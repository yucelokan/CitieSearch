//
//  Stubber.swift
//
//
//  Created by okan.yucel on 5.03.2022.
//

import Foundation

public enum Stubber {
    public static func getDataFromLocal<T: Decodable>(
        fileName: String, completion: @escaping (Result<T, Error>) -> Void
    ) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let path = Bundle(for: EmptyClass.self).path(forResource: fileName, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "no json file", code: 400, userInfo: nil)))
            }
        }
    }
}

private final class EmptyClass {}
