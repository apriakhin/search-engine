//
//  SearchEngine.swift
//  SearchEngine
//
//  Created by Anton Priakhin on 7/4/25.
//

import Foundation

func search(query: String, in documents: [Document]) -> [String] {
  let terms = getTerms(from: query)
  let invertedIndex = createInvertedIndex(by: documents)

  return terms
    .reduce(into: [Posting]()) { postings, term in
      invertedIndex[term]?.forEach { posting in
        if let postingIndex = postings.firstIndex(where: { $0.documentId == posting.documentId }) {
          postings[postingIndex] = Posting(
            documentId: posting.documentId,
            tfIdf: postings[postingIndex].tfIdf + posting.tfIdf
          )
        } else {
          postings.append(posting)
        }
      }
    }
    .sorted { $0.tfIdf > $1.tfIdf }
    .map { $0.documentId }
}
