//
//  GitCommitModel.swift
//  SchrodersApp
//
//  Created by Jonathan Aguele on 03/02/2021.
//

import Foundation

struct GitCommitModel {

    let authorName: String
    let avatarURL: String?
    let commitDate: Date
    let commitMessage: String
}

extension GitCommitModel: Decodable {

    private enum TopLevelCodingKeys: String, CodingKey {
        case commit
        case author
    }

    private enum CommitCodingKeys: String, CodingKey {
        case author
        case message
    }

    private enum AuthorCodingKeys: String, CodingKey {
        case name
        case date
    }

    private enum AuthorDetailsCodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }

    init(from decoder: Decoder) throws {
        let topLevelVContainerValues = try decoder.container(keyedBy: TopLevelCodingKeys.self)
        let commitContainerValues = try topLevelVContainerValues.nestedContainer(keyedBy: CommitCodingKeys.self, forKey: .commit)
        let authorContainerValues = try commitContainerValues.nestedContainer(keyedBy: AuthorCodingKeys.self, forKey: .author)
        let authorDetailsValues = try? topLevelVContainerValues.nestedContainer(keyedBy: AuthorDetailsCodingKeys.self, forKey: .author)
        self.commitMessage = try commitContainerValues.decode(String.self, forKey: .message)
        self.authorName = try authorContainerValues.decode(String.self, forKey: .name)
        self.commitDate = try authorContainerValues.decode(Date.self, forKey: .date)
        self.avatarURL = try authorDetailsValues?.decodeIfPresent(String.self, forKey: .avatarUrl)
    }
}
