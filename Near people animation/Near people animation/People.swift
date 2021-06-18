//
//  People.swift
//  Near people animation
//
//  Created by Nerimene on 14/6/2021.
//

import SwiftUI

struct People: Identifiable {
    
    var id = UUID().uuidString
    var img: String
    var name: String
    var offset: CGSize = CGSize(width: 0, height: 0)
}

var peoples = [People(img: "img1", name: "Bill Gates"),
               People(img: "img2", name: "Steve Jobs"),
               People(img: "img3", name: "Mark Zuckerberg"),
               People(img: "img4", name: "Jeff Bezos"),
               People(img: "img5", name: "Elon Musk"),
               People(img: "img6", name: "Marissa Mayer")]


var firstFiveOffsets: [CGSize] = [CGSize(width: 100, height: 100),
                                  CGSize(width: -100, height: -100),
                                  CGSize(width: -50, height: 130),
                                  CGSize(width: 50, height: -130),
                                  CGSize(width: -140, height: 40),
                                  CGSize(width: 140, height: -20)]

extension View {
    
    func getSafeArea() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
