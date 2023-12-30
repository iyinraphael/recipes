//
//  DetailView.swift
//  Recipes
//
//  Created by Raphael Iyin on 12/23/23.
//

import SwiftUI

struct DetailView: View {
    @State var viewModel: DetailViewModel?
    @State var image: UIImage?
    var body: some View {
        VStack {
            Image(systemName: "heart")
                .onAppear{
                Task{
                    let recipes = await viewModel?.getRecipes()
                    print(recipes ?? " no recipes")
                }
            }
            Text("New View")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
