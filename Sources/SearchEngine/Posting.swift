//
//  Posting.swift
//  SearchEngine
//
//  Created by Anton Priakhin on 7/5/25.
//

import Foundation

struct Posting {
  let documentId: String
  let tfIdf: Double

  init(documentId: String, tfIdf: Double = 0.0) {
    self.documentId = documentId
    self.tfIdf = tfIdf
  }
}
