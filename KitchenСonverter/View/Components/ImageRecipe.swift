//
//  ImageRecipe.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 29.04.2023.
//

import SwiftUI

struct ImageRecipe: View {

    var recipe: Recipe
    var size: CGFloat

    var body: some View {
        
        if let image = UIImage(data: recipe.Image) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .foregroundColor(.white)
                .frame(width: size, height: size)
                .cornerRadius(16)
                .shadow(color: .white, radius: 10)
        } else {
            Image("RecipeIcons")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.white)
                .frame(width: size, height: size)
                .cornerRadius(16)
        }
    }
    
}
