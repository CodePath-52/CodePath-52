//
//  APIHandler.swift
//  CodePath-52
//
//  Created by Gregory Sinaga on 4/21/22.
//

import Foundation
import Alamofire
import Parse

enum APIHandler: URLRequestConvertible {
    
    static let url = URL(string: "https://api.endlessmedical.com/swagger/v1")!
    static let pass = "I have read, understood and I accept and agree to comply with the Terms of Use of EndlessMedicalAPI and Endless Medical services. The Terms of Use are available on endlessmedical.com"
    static var SessionID = ""
    
    // cases:
    // "Internal" API function cases (preface these with updating age entry)
    case updateSymptom(name : String, val : Int)
    // the value passed in for symptoms expecting enum values seem to match the sandbox one, with the first option having an integer value of 1, 1 seems to equivalent to not having the symptom at all though
    case getDiseases(num : Int)
    case getSpecializations(num : Int)
    case initAPISession
    case acceptTOS
    
    var path: String {
        switch self {
            case .updateSymptom(_, _):
                return "/dx/UpdateFeature"
            case .getDiseases(_):
                return "/dx/Analyze"
            case .getSpecializations(_):
                return "/dx/GetSuggestedSpecializations"
            case .initAPISession:
                return "/dx/InitSession"
            case .acceptTOS:
                return "/dx/AcceptTermsOfUse"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .updateSymptom(_, _):
                return .post
            case .getDiseases(_):
                return .get
            case .getSpecializations(_):
                return .get
            case .initAPISession:
                return .get
            case .acceptTOS:
                return .post
        }
    }
    
    var encoding: URLEncoding {
        switch self {
            default:
                return .default
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: APIHandler.url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        var params = Parameters()
        request.addValue("Content-type", forHTTPHeaderField: "application/json; charset=UTF-8") // Always expecting JSON back
        switch self {
        case .updateSymptom(let name, let val):
            params["SessionID"] = APIHandler.SessionID
            params["name"] = name
            params["value"] = val
            break
        case .getDiseases(let num):
            params["SessionID"] = APIHandler.SessionID
            params["NumberOfResults"] = num
            break
        case .getSpecializations(let num):
            params["SessionID"] = APIHandler.SessionID
            params["NumberOfResults"] = num
            break
        case .initAPISession:
            break
        case .acceptTOS:
            params["SessionID"] = APIHandler.SessionID
            params["passphrase"] = APIHandler.pass
            break
        }
        
        request = try encoding.encode(request, with: params)
        return request
    }
    
}

class APIClass {
//    init() { // initializes whole API session
//        APIHandler.initSessionID()
//        APIHandler.acceptTOS()
//    }
    @discardableResult
    private static func performRequest<T:Decodable>(route: APIHandler, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (AFResult<T>) -> Void) -> DataRequest {
        return AF.request(route)
            .responseDecodable(decoder: decoder) { (response: AFDataResponse<T>) in
                completion(response.result)
            }
    }
    
    // API Functions
    // Setup
    // GET: Gets API SessionID
    static func initSessionID() {
        performRequest(route: APIHandler.initAPISession) { <#Result<Decodable, AFError>#> in {
            
            }
        }
    }
    // SYMPTOMS
}
