import Foundation

enum SnackError: Error {
    case NoDataAvailable
    case CanNotProcessData
    case invalidURL
}

struct Networking {
    static let shared = Networking()
    let session = URLSession.shared
    let snackURL = "https://www.sysbird.jp/webapi/?apikey=guest&format=json&list"

    func getSnackList(completion: @escaping (Result<SnackInfo, SnackError>) -> Void) {
        guard let SnackURL = URL(string: snackURL) else {
            completion(.failure(.invalidURL))
            return
        }
        let dataTask = session.dataTask(with: SnackURL) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let jsonData = data else {
                completion(.failure(.NoDataAvailable))
                return
            }
            print(jsonData)
            do {
                let decoder = JSONDecoder()
                let snackResponse = try decoder.decode(SnackInfo.self, from: jsonData)
                completion(.success(snackResponse))
            } catch {
                let nsError = error as NSError
                print(error.localizedDescription)
                print(nsError.userInfo)
                completion(.failure(.CanNotProcessData))
            }
        }
        dataTask.resume()
    }
}
