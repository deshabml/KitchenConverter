//
//  PhotoPickerRecipeViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 05.05.2023.
//

import SwiftUI
import PhotosUI

class PhotoPickerRecipeViewModel: ObservableObject {

    @Published var selectedPhoto: PhotosPickerItem? {
        didSet {
            if let selectedPhoto {
                self.convertPhoto(photo: selectedPhoto)
            }
        }
    }
    @Published var loadedImage: MediaFile?
    @Published var imageStandard: Image = Image("RecipeIcons")
    var imageForPresentation: Image {
        if let loadedImage, let image = UIImage(data: loadedImage.data) {
            let image = Image(uiImage: image)
            return image
        } else {
            let image = imageStandard
            return image
        }
    }

    func setupImageStandard(_ imageStandard: Image) {
        self.imageStandard = imageStandard
    }

    func setupLoadedImage(loadedImage: MediaFile) {
        DispatchQueue.main.async {
            self.loadedImage = loadedImage
        }
    }

    func reloadLoadedImage() {
        loadedImage = loadedImage
    }

    func convertPhoto(photo: PhotosPickerItem) {
        photo.loadTransferable(type: Data.self) { result in
            switch result {
                case .success(let data):
                    if let data,
                       let _ = UIImage(data: data) {
                        self.setupLoadedImage(loadedImage: MediaFile(data: data))
                        DispatchQueue.main.async {
                            self.reloadLoadedImage()
                        }
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
}
