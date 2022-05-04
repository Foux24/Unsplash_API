//
//  NetworkService.swift
//  Unsplash_API
//
//  Created by Vitalii Sukhoroslov on 04.05.2022.
//

import Foundation
import Alamofire

/*
 Network Service - Сервис для работы с сетью
 */

/// Входящий протокол нетворк сервиса
protocol NetworkServiceOtput: AnyObject {
    func loadRendomPhoto(completion: @escaping (Result<[CollectionPhoto], FriendsError>) -> Void)
    func searchPhoto(textSearch: String, completion: @escaping (Result<[CollectionPhoto], FriendsError>) -> Void)
    func getDetailPhoto(id: String, completion: @escaping (Result<DetailPhoto, FriendsError>) -> Void)
}

/// енум  с типами методов
fileprivate enum TypeMethods: String {
    case photosGetAll = "/photos/"
    case searchPhotos = "/search/photos"
}

/// енум с типами запросов
fileprivate enum TypeRequest: String {
    case get = "GET"
}

/// енум с ключом доступа к апи
fileprivate enum ApiKey: String {
    case apiKey = "QpKsimqOMtB-dBrZDa4D8Ik0FEYiCIVyB_HGoInuJx0"
}

/// енум с ошибками
enum FriendsError: Error {
    case parseError
    case requestError(Error)
}

// MARK: - NetworkService
final class NetworkService {
    
    /// Протокол
    private let scheme: String = "https"
    
    /// Корневой урл
    private let host: String = "api.unsplash.com"
    
    /// Для парсинга
    private let decoder = JSONDecoder()
}

// MARK: - Extension RequestApiService on the RequestApiServiceInput
extension NetworkService: NetworkServiceOtput {
    
    /// Получение рендомных фотографии
    func loadRendomPhoto(completion: @escaping (Result<[CollectionPhoto], FriendsError>) -> Void) {
        DispatchQueue.global(qos: .utility).async { [self] in
            let params: [String: String] = ["per_page":"30"]
            let url = configureUrl(apiKey: .apiKey,
                                   method: .photosGetAll,
                                   httpMethod: .get,
                                   params: params)
            
            AF.request(url).responseData(queue: DispatchQueue.global()) { [weak self] response in
                guard let data = response.data else { return }
                do {
                    guard let result = try self?.decoder.decode([CollectionPhoto].self, from: data) else {return}
                    DispatchQueue.main.async {
                        return completion(.success(result))
                    }
                } catch {
                    return completion(.failure(.parseError))
                }
            }
        }
    }
    
    /// Поиск фотогрфий по названию
    func searchPhoto(textSearch: String, completion: @escaping (Result<[CollectionPhoto], FriendsError>) -> Void) {
       DispatchQueue.global(qos: .utility).async { [self] in
           let params: [String: String] = ["per_page":"30",
                                           "query":"\(textSearch)"
           ]
           let url = configureUrl(apiKey: .apiKey,
                                  method: .searchPhotos,
                                  httpMethod: .get,
                                  params: params)
           
           AF.request(url).responseData(queue: DispatchQueue.global()) { [weak self] response in
               guard let data = response.data else { return }
               do {
                   guard let result = try self?.decoder.decode(SearchCollectionPhoto.self, from: data) else {return}
                   DispatchQueue.main.async {
                       return completion(.success(result.results))
                   }
               } catch {
                   return completion(.failure(.parseError))
               }
           }
       }
   }
    
    /// Получение подробной информации о фото
    func getDetailPhoto(id: String, completion: @escaping (Result<DetailPhoto, FriendsError>) -> Void) {
        DispatchQueue.global(qos: .utility).async { [self] in
            let url: String = "https://api.unsplash.com/photos/\(id)?client_id=\(ApiKey.apiKey.rawValue)"
            print(url)
            AF.request(url).responseData(queue: DispatchQueue.global()) { [weak self] response in
                guard let data = response.data else { return }
                do {
                    guard let result = try self?.decoder.decode(DetailPhoto.self, from: data) else {return}
                    DispatchQueue.main.async {
                        return completion(.success(result))
                    }
                } catch {
                    return completion(.failure(.parseError))
                }
            }
        }
    }
}

// MARK: - Private
private extension NetworkService {
    
    /// Конфигурация url
    func configureUrl(apiKey: ApiKey,
                      method: TypeMethods,
                      httpMethod: TypeRequest,
                      params: [String: String]) -> URL {
        
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "client_id", value: apiKey.rawValue))
        for (param, value) in params {
            queryItems.append(URLQueryItem(name: param, value: value))
        }
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = method.rawValue
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            fatalError("URL is invalid")
        }
        return url
    }
}
