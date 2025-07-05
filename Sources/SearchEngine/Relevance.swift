//
//  Relevance.swift
//  SearchEngine
//
//  Created by Anton Priakhin on 7/5/25.
//

import Foundation

func tf(countOfAllTerms: Int, countOfTerm: Int) -> Double {
  Double(countOfTerm) / Double(countOfAllTerms)
}

func idf(countOfDocuments: Int, countOfPosting: Int) -> Double {
  log2(Double(countOfDocuments + 1) / (Double(countOfPosting) + 0.5))
}
