//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by junseopLee on 12/3/25.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var isError = false
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }.padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert(isError ? "Something went wrong.." : "Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        // 요청 실패 케이스를 위해 주석처리
        //request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            // Data 객체를 UTF-8 문자열로 변환하여 출력
            if let dataString = String(data: data, encoding: .utf8) {
                print("Received Data String:")
                print(dataString)
            } else {
                print("Failed to convert data to String (possibly non-UTF8 data).")
                print("Raw Data (size: \(data.count)): \(data as NSData)") // 변환 실패 시 원시 데이터 출력
            }
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            isError = false
            
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
            isError = true
            confirmationMessage = "Checkout failed: \(error.localizedDescription)"
        }
        
        showingConfirmation = true
    }
}

#Preview {
    CheckoutView(order: Order())
}
