//
// Created by 浜田知季 on 2022/01/27.
//

import SwiftUI

struct SnackScreen : View {

    @ObservedObject var snackViewModel: SnackViewModel

    var body: some View {
        List(snackViewModel.snackList, id: \.self) { item in
            HStack {
                AsyncImage(url: URL(string: item.image)) { image in
                    image.resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.black, lineWidth: 2.0))
                } placeholder: {
                    ProgressView()
                }
                VStack(alignment: .leading) {
                    Text(item.name).font(.body)
                    Text(item.regist).font(.footnote)
                }
            }
                    .padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
        }
                .onAppear(perform: {
                    snackViewModel.getSnackList()
                })
    }

}
