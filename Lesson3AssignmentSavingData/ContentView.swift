//
//  ContentView.swift
//  Lesson3AssignmentSavingData
//
//  Created by Sandra Gomez on 4/19/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var faceID = false
    @State private var usernameMessage = ""
    @State private var passwordMessage = ""
    
    func doSomething() {
        let url = Bundle.main.url(forResource: "signIn", withExtension: "json")
        guard let jsonData = url else {
            print("Data not found")
            return
        }
        guard let data = try? Data(contentsOf:jsonData) else {return}
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {return}
        
        if let dictionary = json as? [String: Any] {
            if let username = dictionary["username"] as? String {
                usernameMessage = "\(username) is your username"
            }
            if let password = dictionary["password"] as? String {
                passwordMessage = " \(password) is your password "
            }
        }
    }
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
            TextField("Password", text: $password)
                .padding()
            Toggle(isOn: $faceID, label: {
                Text("Automatic Sign-in with FaceID")
            })
            .padding()
            Button {
                UserDefaults.standard.set(username, forKey: "Username")
                UserDefaults.standard.set(password, forKey: "Password")
                UserDefaults.standard.set(faceID, forKey: "FaceID")
            } label: {
                Text("Save data")
            }
            Button {
                username = ""
                password = ""
                faceID = false
            } label: {
                Text("Clear data")
            }
            Button {
                username = UserDefaults.standard.string(forKey: "Username") ?? "Default Text"
                password = UserDefaults.standard.string(forKey: "Password") ?? ("Default Text")
                faceID = UserDefaults.standard.bool(forKey: "FaceID")
            } label: {
                Text("Retrieve data")
            }
            Spacer()
            
            Text("\(usernameMessage)")
            Text("\(passwordMessage)")
            Button(action: doSomething) {
                Text ("Get JSON data")
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
