//
//  ContentView.swift
//  Quotify Watch App
//
//  Created by Anuza Simkhada on 12/05/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    NavigationLink(destination: ChooseCategoryView()) {
                        Text("New Quotes")
                            .foregroundColor(Color.black)
                            .fontWeight(.regular)
                    }
                    .background(Color.blue)
                    .cornerRadius(24)
                    .padding()
                    
                    NavigationLink(destination: SavedQuotesView()) {
                        Text("Saved Quotes")
                            .foregroundColor(Color.black)
                            .fontWeight(.regular)
                    }
                    .background(Color.blue)
                    .cornerRadius(24)
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
