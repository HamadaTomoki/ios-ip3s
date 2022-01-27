//
//  ContentView.swift
//  H29061
//
//  Created by 浜田知季 on 2022/01/25.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var snackViewModel = SnackViewModel()

    var body: some View {
        VStack{
            SnackScreen(snackViewModel: snackViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
