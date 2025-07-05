//
//  Utils.swift
//  SearchEngineTests
//
//  Created by Anton Priakhin on 7/5/25.
//

import Foundation
@testable import SearchEngine

func loadDocument(id: String) -> Document {
  let url = Bundle.module.url(forResource: id, withExtension: "")!
  let text = try! String(contentsOf: url)
  
  return Document(id: id, text: text)
}
