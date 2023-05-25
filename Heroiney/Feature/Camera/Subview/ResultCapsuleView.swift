//
//  ResultCapsuleView.swift
//  Heroiney
//
//  Created by Alfine on 23/05/23.
//

import SwiftUI

struct ResultCapsuleView: View {
    
    @Binding var result: String
    var body: some View {
        Text(result)
            .font(.system(size: 13))
            .padding(.vertical, 5)
            .padding(.horizontal, 9)
            .foregroundColor(Color(red: 233/255, green: 255/255, blue: 219/255).opacity(0.8))
            .background(.black.opacity(0.3))
            .cornerRadius(4)
    }
}

struct ResultCapsuleView_Previews: PreviewProvider {
    static var previews: some View {
        ResultCapsuleView(result: .constant("Bring money into view"))
    }
}
