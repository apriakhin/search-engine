//
//  InvertedIndex.swift
//  SearchEngine
//
//  Created by Anton Priakhin on 7/5/25.
//

import Foundation

func createInvertedIndex(by documents: [Document]) -> [String: [Posting]] {
  var invertedIndex = [String: [Posting]]()
  var countOfAllTermsInDocuments: [String: Int] = [:]
  var countOfTermInDocuments: [String: [String: Int]] = [:]

  for document in documents {
    let terms = getTerms(from: document.text)
    countOfAllTermsInDocuments[document.id] = terms.count
    countOfTermInDocuments[document.id] = [:]

    for term in terms {
      if invertedIndex[term, default: []].contains(where: { $0.documentId == document.id }) {
        countOfTermInDocuments[document.id]?[term]? += 1

      } else {
        countOfTermInDocuments[document.id]?[term] = 1
        invertedIndex[term, default: []].append(Posting(documentId: document.id))
      }
    }
  }

  for term in invertedIndex.keys {
    let countOfPosting = invertedIndex[term]?.count ?? 0

    for indexOfPosting in 0..<countOfPosting {
      if let posting = invertedIndex[term]?[indexOfPosting],
         let countOfAllTermsInDocument = countOfAllTermsInDocuments[posting.documentId],
         let countOfTermInDocument = countOfTermInDocuments[posting.documentId]?[term]
      {
        let tf = tf(countOfAllTerms: countOfAllTermsInDocument, countOfTerm: countOfTermInDocument)
        let idf = idf(countOfDocuments: documents.count, countOfPosting: countOfPosting)

        invertedIndex[term]?[indexOfPosting] = Posting(
          documentId: posting.documentId,
          tfIdf: tf * idf
        )
      }
    }
  }

  return invertedIndex
}
