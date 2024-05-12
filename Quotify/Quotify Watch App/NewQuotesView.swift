//
//  NewQuotesView.swift
//  Quotify Watch App
//
//  Created by Anuza Simkhada on 12/05/2024.
//

import SwiftUI
import Combine

struct NewQuotesView: View {
    let selectedCategory: String
    @StateObject var displayingQuote: QuotesAPIServices
    @State private var reloadQuotes = PassthroughSubject<Void, Never>()
    @State private var selectedQuotes: [Quote] = [] // Track the selected quotes
    
    init(selectedCategory: String) {
        self.selectedCategory = selectedCategory
        self._displayingQuote = StateObject(wrappedValue: QuotesAPIServices(selectedCategory: selectedCategory))
    }
    
    var body: some View {
        VStack {
            // Quotes
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(displayingQuote.quotes, id: \.self) { quote in
                        HStack{
                            Text(quote.category.prefix(1).capitalized + quote.category.dropFirst())
                                .foregroundColor(.blue)

                            Spacer()
                            Image(systemName: isQuoteSelected(quote) ? "heart.fill" : "heart")
                                .foregroundColor(isQuoteSelected(quote) ? .red : .white)
                                .padding(.trailing, 10)
                                .onTapGesture {
                                    toggleQuoteSelection(quote) // Toggle the selection of the quote
                                }
                        }
                        VStack {
                            Text(quote.quote)
                                .foregroundColor(.white)
                                .fixedSize(horizontal: false, vertical: true)
                            HStack(){
                                Spacer()
                                Text("- " + quote.author)
                                    .foregroundColor(.blue)
                                    .font(.system(size: 14))
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(10)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            
            // Next Button
            HStack {
                Spacer()
                Text("Next")
                    .foregroundColor(.red)
                    .padding(.leading, 10)
                Image(systemName: "chevron.right")
                    .foregroundColor(.red)
                    .padding(.trailing, 10)
            }
            .onTapGesture {
                reloadQuotes.send()
            }
        }
        .onReceive(reloadQuotes) { _ in
            displayingQuote.getQuotes()
        }
        .onAppear {
            displayingQuote.getQuotes()
            if let data = UserDefaults.standard.data(forKey: "SelectedQuotes") {
                selectedQuotes = try! JSONDecoder().decode([Quote].self, from: data)
            }
        }
        
    }
    
    // Check if the quote is selected
    private func isQuoteSelected(_ quote: Quote) -> Bool {
        selectedQuotes.contains { $0.quote == quote.quote && $0.author == quote.author && $0.category == quote.category }
    }
    
    // Toggle the selection of the quote
    private func toggleQuoteSelection(_ quote: Quote) {
        if let index = selectedQuotes.firstIndex(where: { $0.quote == quote.quote && $0.author == quote.author && $0.category == quote.category }) {
            selectedQuotes.remove(at: index) // Remove quote if it is selected
        } else {
            selectedQuotes.append(quote) // Add quote if it is not selected
        }
        if let encodedData = try? JSONEncoder().encode(selectedQuotes) {
            UserDefaults.standard.set(encodedData, forKey: "SelectedQuotes") // Save selected quotes to UserDefaults
        }
    }
}
