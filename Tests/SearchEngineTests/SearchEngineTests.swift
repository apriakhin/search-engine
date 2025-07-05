//
//  SearchEngineTests.swift
//  SearchEngineTests
//
//  Created by Anton Priakhin on 7/4/25.
//

import Testing
@testable import SearchEngine

@Suite
struct SearchEngineTests {
  @Test
  func testSimpleSearch() {
    let searchText = "trash island"
    let documentIds = ["garbage_patch_NG", "garbage_patch_ocean_clean", "garbage_patch_wiki"]
    let documents = documentIds.map(loadDocument)

    #expect(search(query: searchText, in: documents) == documentIds)
  }

  @Test
  func searchWithSpamPretext() {
    let searchText = "the trash island is a"
    let documentIds = ["garbage_patch_NG", "garbage_patch_ocean_clean", "garbage_patch_wiki", "garbage_patch_spam"]
    let documents = documentIds.map(loadDocument)

    #expect(search(query: searchText, in: documents) == documentIds)
  }

  @Test
  func searchWithEmpty() {
    #expect(search(query: "", in: []) == [])
  }

  @Test
  func shortStrings() {
    let document1 = "I can't shoot shoot shoot  straight unless I've had a pint!"
    let document2 = "Don't shoot shoot shoot that thing at me."
    let document3 = "I'm your shooter."

    let documents = [
      Document(id: "doc1", text: document1),
      Document(id: "doc2", text: document2),
      Document(id: "doc3", text: document3)
    ]

    #expect(search(query: "shoot at me, nerd", in: documents) == ["doc2", "doc1"])
  }
}
