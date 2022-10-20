//
//  CustomImageView.swift
//  BreakingBadCharacters
//
//  Created by Corey Edh on 10/19/22.
//

import SwiftUI

struct CustomImageView: View {
    @StateObject var imageLoader: ImageLoader
    
    init(urlString: String?) {
        self._imageLoader = StateObject(wrappedValue: ImageLoader(urlString: urlString))
    }
    
    var body: some View {
        Group{
            if (imageLoader.image != nil){
                Image(uiImage: imageLoader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            }else{
                ProgressView()
            }
            
        }.onAppear{
                imageLoader.fetchCharacterImage()
            }
    }
}

struct CustomImageView_Previews: PreviewProvider {
    static var previews: some View {
        CustomImageView(urlString: nil)
    }
}
