//
//  ContentView.swift
//  BreakingBadCharacters
//
//  Created by Corey Edh on 10/19/22.
//

import SwiftUI

struct BreakingBadView: View {
    @StateObject var viewModel = BreakingBadViewModel()
    
    @State private var searchText = ""
    @State private var pickSeason = "All Seasons"
    
    
    var body: some View {
        NavigationView {VStack{
            List {
                ForEach(viewModel.characterList,id: \.char_id) { character in
                    NavigationLink {
                        BreakingBadCharacter(character: character)
                    } label: {
                        CharacterCellView(character: character)
                    }
                    
                    
                }.frame(height: 80)
                
            }.navigationTitle("Breaking Bad")
                .searchable(text: $searchText)
                .onAppear{
                    viewModel.getCharacters()
                }
            Picker("Filter By Season", selection: $pickSeason ) {
                ForEach(viewModel.breakingBadSeasons, id: \.self) { season in
                    if season == "All Seasons"{
                        Text(season)
                    }else{
                        Text("Season " + String(season))
                        
                    }
                }
            }.onChange(of: pickSeason) { _ in
                viewModel.filterBySeason(pickSeason)
            }.onChange(of: searchText) { _ in
                viewModel.searchCharacter(searchText)
            }
            
        }
        }
        
    }
    
}

struct BreakingBadCharacter: View{
    @State var character: CharacterModel
    
    var body: some View{
        VStack{
            HStack{
                Text(character.name ?? "Unnamed").font(.system(size: 40)).minimumScaleFactor(0.1).lineLimit(1)
                    .padding()
                
                CustomImageView(urlString: character.img)
                    .cornerRadius(10)
                    .frame(width: UIScreen.main.bounds.height * 0.2 , height: UIScreen.main.bounds.height * 0.2)
                
                    .shadow(radius: 20).padding(.bottom,20)
                
            }
            
            List{
                VStack(alignment: .leading) {
                    HStack{
                        Text("Occupation: ").scaledToFit().bold()
                        Spacer()
                        if character.occupation?.count != 0{
                            VStack(alignment: .leading){
                                ForEach(character.occupation!, id:\.self){ occupation in
                                    Text(occupation)
                                }
                                
                            }
                        }else{
                            Text("N/A")
                        }
                        
                    }.padding()
                    
                    HStack{
                        Text("Status: ").bold()
                        Spacer()
                        Text(character.status ?? "N/A")
                    }.padding()
                    
                    HStack{
                        Text("Nickname: ").bold()
                        Spacer()
                        Text(character.nickname ?? "N/A")
                    }.padding()
                    
                    
                    HStack{
                        Text("Season Appearance: ").bold()
                        Spacer()
                        if character.appearance?.count != 0{
                            ForEach(character.appearance!, id:\.self){ season in
                                Text(String(season))
                            }
                        }else{
                            Text("N/A")
                        }
                    }.padding()
                    
                }.font(.system(size: 20))
            }
            .frame(height: UIScreen.main.bounds.height * 0.76)
            
            
        }
    }
    
}

struct BreakingBadView_Previews: PreviewProvider {
    static var previews: some View {
        BreakingBadView()
    }
}

struct CharacterCellView: View {
    @State var character: CharacterModel
    
    
    var body: some View {
        HStack{
            
            CustomImageView(urlString: character.img)
                .cornerRadius(10)
                .frame(width:80,height: 80)
            
            Spacer()
            Text(character.name ?? "Unnamed")
                .font(.system(size: 20))
            
            
        }
    }
}
