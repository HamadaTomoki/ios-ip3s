//
// Created by 浜田知季 on 2022/01/26.
//

import Foundation

class SnackViewModel: ObservableObject {

    @Published var snackList = Array<SnackInfo.Snack>()

    func getSnackList() {
        Networking.shared.getSnackList { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let snackRes):
                self?.snackList = snackRes.item
            }
        }
    }
}