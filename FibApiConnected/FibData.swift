//
//  FibData.swift
//  FibApiConnected
//
//  Created by 木越湧太 on 2025/01/08.
//

import SwiftUI
@Observable class FibData {
    var result : String?
    
    // レスポンスとして受け取るJSON形式を定義
    // Codableでデコード可能に
    struct ResultJson: Codable {
        var result: String = ""
    }
    
    // フィボナッチ数をfib_apiから取得する関数
    func getFibonacciFromFibAPI(number: Int) {
        // GETリクエストを非同期で行う
        Task {
            await get(number: number)
        }
    }//getFibonacciFromFibAPI
    
    // WebAPIに対して行うGETリクエストを生成, 送信するメソッド
    private func get(number: Int) async {
        // URLの組み立て
        // クエリパラメータnを引数numberに指定 URLはherokuでデプロイして生成したものを使用
        guard let req_url = URL(string:  "https://fib-api-361b3b900438.herokuapp.com/fib?n=\(number)") else { return }
        
        do {
            // URLSessionをリクエストURLからダウンロード
            // URLSession.shared.dataは「リクエストしてデータの取得」を行う（処理が完了するまで待つ）
            let (data, _) = try await URLSession.shared.data(from: req_url)
            // JSONDecoderのインスタンス
            let decoder = JSONDecoder()
            // 受け取ったJSONデータをパース
            let json = try decoder.decode(ResultJson.self, from: data)
            
            //print(json)
            
            // 受け取ったjsonのresultを取り出し, ローカル変数resultへ格納 → ContentView表示に使用
            result = json.result
            
        } catch {
            print("Error when responce recieved")
        }//do-catch
    }//get
    
}//FibData
