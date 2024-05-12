//
//  SavedQuotesView.swift
//  Quotify Watch App
//
//  Created by Anuza Simkhada on 12/05/2024.
//

import Foundation
import SwiftUI

struct SavedQuotesView: View {
    @State private var savedQuotes: [Quote] = [] // Track the saved quotes
    
    var body: some View {
        VStack {
            // Quotes
            if savedQuotes.isEmpty {
                Text("No saved quotes")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(savedQuotes, id: \.self) { quote in
                            VStack {
                                HStack{
                                    Text(quote.category) // Assuming "Saved" is the category for saved quotes
                                        .foregroundColor(.blue)
                                    Spacer()
                                    Image(systemName: "heart.fill") // Always show heart as filled for saved quotes
                                        .foregroundColor(.red) // Heart color is red for saved quotes
                                        .padding(.trailing, 10)
                                        .onTapGesture {
                                            removeQuote(quote) // Remove quote when heart icon is tapped
                                        }
                                }
                                
                                VStack {
                                    Text(quote.quote)
                                        .foregroundColor(.white)
                                        .fixedSize(horizontal: false, vertical: true)
                                    
                                    HStack(){
                                        Spacer()
                                        Text("- " + quote.author) // Display author name
                                            .foregroundColor(.blue)
                                            .font(.system(size: 14))
                                    }
                                }
                                .padding()
                                .background(Color.gray.opacity(0.4))
                                .cornerRadius(10)
                            }
                            .background(Color.clear) // Clear background for VStack to avoid overlapping dividers
                            .overlay(Divider(), alignment: .bottom) // Add divider at the bottom of each item
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .onAppear {
            let defaults = UserDefaults.standard
            if let data = defaults.data(forKey: "SelectedQuotes") {
                savedQuotes = (try? JSONDecoder().decode([Quote].self, from: data)) ?? []
            }
        }
    }
    
    // Remove quote from savedQuotes array and update UserDefaults
    private func removeQuote(_ quote: Quote) {
        savedQuotes.removeAll { $0 == quote }
        if let encodedData = try? JSONEncoder().encode(savedQuotes) {
            UserDefaults.standard.set(encodedData, forKey: "SelectedQuotes")
        }
    }
}

