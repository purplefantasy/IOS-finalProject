//
//  LyricsView.swift
//  
//
//  Created by User11 on 2019/12/25.
//

import SwiftUI

struct LyricsView: View {
    @State private var show = false
    var body: some View {
        VStack{
            Text("""
            SwiftUI
            嘿 有些話我沒說清楚 是故意讓它變模糊
            也為了避免 過於理智的衝突
            嘿 有些事我沒有宣布 是無疑讓它更懸殊
            也為了減少 重覆彼此不舒服
            因為太有感觸 所以才會如此反撲
            任一時糊塗 違規的信徒 恍恍惚惚
            誰當眾地退出 主動地刪除 都視若無睹
            你才真的可惡 莫名傷得體無完膚
            為認真演出 結束得倉促 吞吞吐吐
            誰抱頭地痛哭 熱情地歡呼 都可有可無
            """).padding().background(Color.yellow)
            Spacer()
            Button("To Storyboard") {
                self.show = true
            }
            .sheet(isPresented: $show) {
                FirstView()
            }
        }
    }
}

struct LyricsView_Previews: PreviewProvider {
    static var previews: some View {
        LyricsView()
    }
}
