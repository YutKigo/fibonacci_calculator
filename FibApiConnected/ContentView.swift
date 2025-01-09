//
//  ContentView.swift
//  FibApiConnected
//
//  Created by 木越湧太 on 2025/01/08.
//

import SwiftUI

struct ContentView: View {
    var fibData = FibData() // FibDataクラスを使用するためのインスタンス
    @State var inputText: String = ""
    @State var showInvalidInputAlert: Bool = false
    @State var message = ""
    
    var body: some View {
        VStack {
            Text("フィボナッチ数を計算しよう！")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            
            Text("第n項のフィボナッチ数を表示します")
                .multilineTextAlignment(.center)
                .padding(.bottom)
            
            TextField("第n項", text: $inputText, prompt: Text("nの値を入力してください"))
                .onSubmit {
                     // 入力は自然数に限定
                    if let number = Int(inputText), number > 0 {
                        // 入力完了後にGETする
                        fibData.getFibonacciFromFibAPI(number: Int(inputText)!)
                    } else {
                        inputText = ""
                        message = "自然数を入力してください"
                        showInvalidInputAlert = true
                        
                    }
                    
                }
                .multilineTextAlignment(.center)
                .submitLabel(.continue)
                .padding()
            
            // fibData.resultはOptinoal型であるためアンラップして表示
            if let result = fibData.result {
                Text("計算結果 : \(result)")
                    .font(.title)
            } else {
                Text("結果がここに表示されます")
                    .font(.title)
            }
            
        }//VStack
        .alert("Invalid input error", isPresented: $showInvalidInputAlert) {
            Button("OK", role: .cancel){}
        } message: {
            Text(message)
        }
    }//view
}

#Preview {
    ContentView()
}
