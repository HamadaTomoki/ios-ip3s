//
//  ContentView.swift
//  H29061
//
//  Created by 浜田知季 on 2022/01/25.
//

import SwiftUI

struct ContentView: View {
    @State var snackViewModel = SnackViewModel()

    var body: some View {
        List(snackViewModel.snackList, id: \.self) { item in
            Text("hogehgoe")
        }
                .onAppear(perform: {
                    snackViewModel.getSnackList()
                    print(snackViewModel.snackList)
                })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
