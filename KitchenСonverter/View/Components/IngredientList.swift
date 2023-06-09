//
//  IngredientList.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 27.04.2023.
//

import SwiftUI

struct IngredientList: View {

    @StateObject var viewModel: IngredientListViewModel

    var body: some View {
        List {
            ForEach(0 ..< viewModel.recordedIngredient.count, id: \.self) { item in
                IngredientCell(product: viewModel.recordedIngredient[item])
                    .background(.white.opacity(0.8))
                    .listRowInsets(EdgeInsets())
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Удалить") {
                            viewModel.completion(viewModel.recordedIngredient[item])
                        }
                        .tint(.red)
                    }
            }.listRowBackground(Color.clear)
            Text("")
                .listRowBackground(Color.clear)
        }.listStyle(.plain)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(18)
        .ignoresSafeArea()
    }

}
