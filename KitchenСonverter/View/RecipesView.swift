//
//  RecipesView.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 21.04.2023.
//

import SwiftUI

struct RecipesView: View {

    @StateObject var viewModel = RecipesViewModel()
    @State var showAddDish = false
    @State var showDeleteDish = false
    @State var locationDishPicker = -130.0
    
    var body: some View {
        ZStack {
            RecipesGrid(viewModel: viewModel.recipesGridViewModel)
                .environmentObject(viewModel)
            VStack {
                HStack() {
                    Spacer()
                    NavigationLink {
                        AddRecipesView(viewModel: AddRecipesViewModel(),
                                       isEdit: false,
                                       isViewer: false)
                            .environmentObject(viewModel)
                    } label: {
                        AddButton()
                    }
                }
                Spacer()
            }
            VStack {
                Spacer()
                HStack {
                    DishPicker(viewModel: viewModel.dishPickerViewModel,
                               showAddDish: $showAddDish,
                               showDeleteDish: $showDeleteDish, complitionHidden: {
                        locationDishPicker = -130
                    }, complitionActive: {
                        locationDishPicker = 0
                    })
                    .offset(x: locationDishPicker, y: 0)
                    Spacer()
                }
                .padding(.vertical, 150)
            }
        }
        .modifier(BackgroundElement(ImageName: "RecipesBackgraund", onApperComplition: {
            viewModel.loadingScreen()
            locationDishPicker = 0
        }))
        .modifier(AlertElement(TextFirst: viewModel.dishTextAlert,
                               switchAlertFirst: $viewModel.showCoincidenceAlert,
                               TextSecond: "Вы уверены, что хотите удалить группу \"\(viewModel.dishPickerViewModel.dishPicker.name)\"?",
                               switchAlertSecond: $viewModel.showDeleteDishAlert, complitionAlertSecond: {
            if viewModel.deleteDish() {
                showDeleteDish.toggle()
            }
        }))
        .animation(.easeInOut(duration: 0.3), value: showAddDish)
        .animation(.easeInOut(duration: 0.3), value: showDeleteDish)
        .animation(.linear(duration: 0.2), value: viewModel.dishPickerViewModel.dishPicker)
        .animation(Animation.easeInOut(duration: 0.5), value: locationDishPicker)
    }
    
}
