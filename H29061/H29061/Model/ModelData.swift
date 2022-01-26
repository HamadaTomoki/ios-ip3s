import Foundation

/*
 Decodable and Encodable Protocols

 SwiftにはJSONの操作をsimpleかつ簡単にする、Decodable、Encodable、および Codable の3つの protocolがあります。
 Codableは、Swiftのprotocol構成を通じて行われるDecodableおよびEncodableのtype aliasです。
 一部の人は、名前を明示し、EncodableとDecodableにすることを好むかもしれませんが、特に明記されていない限り、Codableを使用します。
 */

/*
 Coding Keys

 Swiftのpropertyの命名規則はcamelCaseです。programmingにおける一般的な命名規則の例をいくつか示します。
  - camelCase
  - snake_case
  - Pascal_Case
 一部のAPIには、camelcase以外の形式のkeyがあります。codeをcleanに保ち、Swiftの規則に従うために、
 SwiftはCodingKey protocolを提供しています。この protocolは、camelcaseの規則を維持しながら
 custom keyを使用するようにprogramに指示します。規則は、型内にCodingKeysという名前の列挙型を作成することです。
 */


// Arrayは参照型ではなく、値型。var, letの使い分けで変数,定数を使い分ける
struct SnackInfo: Codable, Hashable {
    var item: [Snack]

    struct Snack: Codable, Hashable {
        var name: String
        var marker: String
        var regist: String
        var url: String
        var image: String
    }


    enum SnackInfoCodingKeys: String, CodingKey {
        case item
    }

    enum SnackCodingKeys: String, CodingKey {
        case name
        case marker
        case regist
        case url
        case image
    }
}


extension SnackInfo {
    init(from decoder: Decoder) throws {
        // CodingKeysを指定し、JSON直下の属性（"user_name"と"scores"にあたる部分）に対するコンテナを取得
        let rootContainer = try decoder.container(keyedBy: SnackInfoCodingKeys.self)

        // の配列部分（配列なので中身の各要素にはキーがない）のコンテナを取得
        var arrayContainer = try rootContainer.nestedUnkeyedContainer(forKey: .item)

        var items: [Snack] = []

        // 配列の要素の最後になるまで繰り返し
        while !arrayContainer.isAtEnd {

            // JSON keyにあたる部分の値を取得
            let scoreContainer = try arrayContainer.nestedContainer(keyedBy: SnackCodingKeys.self)
            let name = try? scoreContainer.decode(String.self, forKey: .name)
            let marker = try? scoreContainer.decode(String.self, forKey: .marker)
            let regist = try? scoreContainer.decode(String.self, forKey: .regist)
            let url = try? scoreContainer.decode(String.self, forKey: .url)
            let image = try? scoreContainer.decode(String.self, forKey: .image)

            items.append(Snack(name: name ?? "", marker: marker ?? "", regist: regist ?? "", url: url ?? "", image: image ?? ""))
        }

        // 取得した値をメンバワイズイニシャライザに渡して初期化
        self.init(item: items)
    }
}