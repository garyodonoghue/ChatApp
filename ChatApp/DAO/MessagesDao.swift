//
//  MessagesDao.swift
//
// All the classes in this file were taken from the Github project
// See - https://github.com/nathantannar4/InputBarAccessoryView/blob/f5e21ad31f7e747ae08eae91b6fc6d2348bb750d/Example/Example/Supporting%20Files/Random.swift
//
//  Created by Nathan Tannar on 2/6/18.
//  Copyright © 2018 Nathan Tannar. All rights reserved.
//
import UIKit

class MessagesDao {
    
    static var shared = MessagesDao()
    
    static let userGary = User(name: "Gary")
    static let userFriend = User(name: "Friend")
    let users = [userGary, userFriend]
    
    private init() {}
    
    func getConversation() -> Conversation {
        
        var messages = [Message]()
        var time = Date.now
        
        for i in 0..<30 {
            let user = users[i % users.count]
            
            var timeModified: Date!
            
            if i % 10 == 0 {
                timeModified = Calendar.current.date(byAdding: .second, value: -5, to: time)!
                let message = Message(user: user, text: Lorem.sentence(), sentDate: timeModified)
                messages.append(message)
                messages.append(message)
                
                timeModified = Calendar.current.date(byAdding: .second, value: -50, to: time)!
                let message1 = Message(user: user, text: Lorem.sentence(), sentDate: timeModified)
                messages.append(message1)
            } else if i % 4 == 0 {
                timeModified = Calendar.current.date(byAdding: .minute, value: -20*i, to: time)!
                let message = Message(user: user, text: Lorem.sentence(), sentDate: timeModified)
                messages.append(message)
                messages.append(message)
            } else {
                timeModified = Calendar.current.date(byAdding: .minute, value: -20*i, to: time)!
                let message = Message(user: user, text: Lorem.paragraph(), sentDate: timeModified)
                messages.append(message)
            }
            
            
        
            time = timeModified
        }
        let conversation = Conversation(users: users, messages: messages)
        return conversation
    }
}

//
//  Lorem.swift
//  InputBarAccessoryView Example
//
//  Copyright © 2017-2020 Nathan Tannar.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  Created by Nathan Tannar on 10/4/17.
//
import Foundation

class Lorem {
    private static let wordList = [
        "alias", "consequatur", "aut", "perferendis", "sit", "voluptatem",
        "accusantium", "doloremque", "aperiam", "eaque","ipsa", "quae", "ab",
        "illo", "inventore", "veritatis", "et", "quasi", "architecto",
        "beatae", "vitae", "dicta", "sunt", "explicabo", "aspernatur", "aut",
        "odit", "aut", "fugit", "sed", "quia", "consequuntur", "magni",
        "dolores", "eos", "qui", "ratione", "voluptatem", "sequi", "nesciunt",
        "neque", "dolorem", "ipsum", "quia", "dolor", "sit", "amet",
        "consectetur", "adipisci", "velit", "sed", "quia", "non", "numquam",
        "eius", "modi", "tempora", "incidunt", "ut", "labore", "et", "dolore",
        "magnam", "aliquam", "quaerat", "voluptatem", "ut", "enim", "ad",
        "minima", "veniam", "quis", "nostrum", "exercitationem", "ullam",
        "corporis", "nemo", "enim", "ipsam", "voluptatem", "quia", "voluptas",
        "sit", "suscipit", "laboriosam", "nisi", "ut", "aliquid", "ex", "ea",
        "commodi", "consequatur", "quis", "autem", "vel", "eum", "iure",
        "reprehenderit", "qui", "in", "ea", "voluptate", "velit", "esse",
        "quam", "nihil", "molestiae", "et", "iusto", "odio", "dignissimos",
        "ducimus", "qui", "blanditiis", "praesentium", "laudantium", "totam",
        "rem", "voluptatum", "deleniti", "atque", "corrupti", "quos",
        "dolores", "et", "quas", "molestias", "excepturi", "sint",
        "occaecati", "cupiditate", "non", "provident", "sed", "ut",
        "perspiciatis", "unde", "omnis", "iste", "natus", "error",
        "similique", "sunt", "in", "culpa", "qui", "officia", "deserunt",
        "mollitia", "animi", "id", "est", "laborum", "et", "dolorum", "fuga",
        "et", "harum", "quidem", "rerum", "facilis", "est", "et", "expedita",
        "distinctio", "nam", "libero", "tempore", "cum", "soluta", "nobis",
        "est", "eligendi", "optio", "cumque", "nihil", "impedit", "quo",
        "porro", "quisquam", "est", "qui", "minus", "id", "quod", "maxime",
        "placeat", "facere", "possimus", "omnis", "voluptas", "assumenda",
        "est", "omnis", "dolor", "repellendus", "temporibus", "autem",
        "quibusdam", "et", "aut", "consequatur", "vel", "illum", "qui",
        "dolorem", "eum", "fugiat", "quo", "voluptas", "nulla", "pariatur",
        "at", "vero", "eos", "et", "accusamus", "officiis", "debitis", "aut",
        "rerum", "necessitatibus", "saepe", "eveniet", "ut", "et",
        "voluptates", "repudiandae", "sint", "et", "molestiae", "non",
        "recusandae", "itaque", "earum", "rerum", "hic", "tenetur", "a",
        "sapiente", "delectus", "ut", "aut", "reiciendis", "voluptatibus",
        "maiores", "doloribus", "asperiores", "repellat"
    ]
    
    /**
     Return a random word.
     
     - returns: Returns a random word.
     */
    class func word() -> String {
        return wordList.random()!
    }
    
    /**
     Return an array of `count` words.
     
     - parameter count: The number of words to return.
     
     - returns: Returns an array of `count` words.
     */
    class func words(nbWords: Int = 3) -> [String] {
        return wordList.random(nbWords)
    }
    
    /**
     Return a string of `count` words.
     
     - parameter count: The number of words the string should contain.
     
     - returns: Returns a string of `count` words.
     */
    class func words(nbWords : Int = 3) -> String {
        return words(nbWords: nbWords).joined(separator: " ")
    }
    
    /**
     Generate a sentence of `nbWords` words.
     - parameter nbWords:  The number of words the sentence should contain.
     - parameter variable: If `true`, the number of words will vary between
     +/- 40% of `nbWords`.
     - returns:
     */
    class func sentence(nbWords : Int = 6, variable : Bool = true) -> String {
        if nbWords <= 0 {
            return ""
        }
        
        let result : String = self.words(nbWords: variable ? nbWords.randomize(variation: 40) : nbWords)
        
        return result.firstCapitalized + "."
    }
    
    /**
     Generate an array of sentences.
     - parameter nbSentences: The number of sentences to generate.
     
     - returns: Returns an array of random sentences.
     */
    class func sentences(nbSentences: Int = 3) -> [String] {
        return (0..<nbSentences).map { _ in sentence() }
    }
    
    /**
     Generate a string of random sentences.
     - parameter nbSentences: The number of sentences to generate.
     - returns: Returns a string of random sentences.
     */
    class func sentences(nbSentences : Int = 3) -> String {
        return sentences(nbSentences: nbSentences).joined(separator: "")
    }
    
    /**
     Generate a paragraph with `nbSentences` random sentences.
     - parameter nbSentences: The number of sentences the paragraph should
     contain.
     - parameter variable:    If `true`, the number of sentences will vary
     between +/- 40% of `nbSentences`.
     - returns: Returns a paragraph with `nbSentences` random sentences.
     */
    class func paragraph(nbSentences : Int = 3, variable : Bool = true) -> String {
        if nbSentences <= 0 {
            return ""
        }
        
        return sentences(nbSentences: variable ? nbSentences.randomize(variation: 40) : nbSentences).joined(separator: " ")
    }
    
    /**
     Generate an array of random paragraphs.
     - parameter nbParagraphs: The number of paragraphs to generate.
     - returns: Returns an array of `nbParagraphs` paragraphs.
     */
    class func paragraphs(nbParagraphs : Int = 3) -> [String] {
        return (0..<nbParagraphs).map { _ in paragraph() }
    }
    
    /**
     Generate a string of random paragrahs.
     - parameter nbParagraphs: The number of paragraphs to generate.
     - returns: Returns a string of random paragraphs.
     */
    class func paragraphs(nbParagraphs : Int = 3) -> String {
        return paragraphs(nbParagraphs: nbParagraphs).joined(separator: "\n\n")
    }
    
    /**
     Generate a string of at most `maxNbChars` characters.
     - parameter maxNbChars: The maximum number of characters the string
     should contain.
     - returns: Returns a string of at most `maxNbChars` characters.
     */
    class func text(maxNbChars : Int = 200) -> String {
        var result : [String] = []
        
        if maxNbChars < 5 {
            return ""
        } else if maxNbChars < 25 {
            while result.count == 0 {
                var size = 0
                
                while size < maxNbChars {
                    let w = (size != 0 ? " " : "") + word()
                    result.append(w)
                    size += w.count
                }
                
                _ = result.popLast()
            }
        } else if maxNbChars < 100 {
            while result.count == 0 {
                var size = 0
                
                while size < maxNbChars {
                    let s = (size != 0 ? " " : "") + sentence()
                    result.append(s)
                    size += s.count
                }
                
                _ = result.popLast()
            }
        } else {
            while result.count == 0 {
                var size = 0
                
                while size < maxNbChars {
                    let p = (size != 0 ? "\n" : "") + paragraph()
                    result.append(p)
                    size += p.count
                }
                
                _ = result.popLast()
            }
        }
        
        return result.joined(separator: "")
    }
}

extension String {
    var firstCapitalized: String {
        var string = self
        string.replaceSubrange(string.startIndex...string.startIndex, with: String(string[string.startIndex]).capitalized)
        return string
    }
}

extension Array {
    /**
     Shuffle the array in-place using the Fisher-Yates algorithm.
     */
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            if j != i {
                self.swapAt(i, j)
            }
        }
    }
    
    /**
     Return a shuffled version of the array using the Fisher-Yates
     algorithm.
     
     - returns: Returns a shuffled version of the array.
     */
    func shuffled() -> [Element] {
        var list = self
        list.shuffle()
        
        return list
    }
    
    /**
     Return a random element from the array.
     - returns: Returns a random element from the array or `nil` if the
     array is empty.
     */
    func random() -> Element? {
        return (count > 0) ? self.shuffled()[0] : nil
    }
    
    /**
     Return a random subset of `cnt` elements from the array.
     - returns: Returns a random subset of `cnt` elements from the array.
     */
    func random(_ count : Int = 1) -> [Element] {
        let result = shuffled()
        
        return (count > result.count) ? result : Array(result[0..<count])
    }
}

extension Int {
    /**
     Return a random number between `min` and `max`.
     - note: The maximum value cannot be more than `UInt32.max - 1`
     
     - parameter min: The minimum value of the random value (defaults to `0`).
     - parameter max: The maximum value of the random value (defaults to `UInt32.max - 1`)
     
     - returns: Returns a random value between `min` and `max`.
     */
    static func random(min : Int = 0, max : Int = Int.max) -> Int {
        precondition(min <= max, "attempt to call random() with min > max")
        
        let diff   = UInt(bitPattern: max &- min)
        let result = UInt.random(min: 0, max: diff)
        
        return min + Int(bitPattern: result)
    }
    
    func randomize(variation : Int) -> Int {
        let multiplier = Double(Int.random(min: 100 - variation, max: 100 + variation)) / 100
        let randomized = Double(self) * multiplier
        
        return Int(randomized) + 1
    }
}

private extension UInt {
    static func random(min : UInt, max : UInt) -> UInt {
        precondition(min <= max, "attempt to call random() with min > max")
        
        if min == UInt.min && max == UInt.max {
            var result : UInt = 0
            arc4random_buf(&result, MemoryLayout.size(ofValue: result))
            
            return result
        } else {
            let range         = max - min + 1
            let limit         = UInt.max - UInt.max % range
            var result : UInt = 0
            
            repeat {
                arc4random_buf(&result, MemoryLayout.size(ofValue: result))
            } while result >= limit
            
            result = result % range
            
            return min + result
        }
    }
}


//
//  Random.swift
//  InputBarAccessoryView Example
//
//  Copyright © 2017-2020 Nathan Tannar.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  Created by Nathan Tannar on 10/4/17.
//
import UIKit
import Foundation

// each type has its own random
extension Bool {
    /// SwiftRandom extension
    static func random() -> Bool {
        return Int.random() % 2 == 0
    }
}

extension Int {
    /// SwiftRandom extension
    static func random() -> Int {
        return random(Int.min, Int.max)
    }
    static func random(_ range: Range<Int>) -> Int {
#if swift(>=3)
        return random(range.lowerBound, range.upperBound - 1)
#else
        return random(range.upperBound, range.lowerBound)
#endif
    }
    
    /// SwiftRandom extension
    static func random(_ range: ClosedRange<Int>) -> Int {
        return random(range.lowerBound, range.upperBound)
    }
    
    /// SwiftRandom extension
    static func random(_ lower: Int = 0, _ upper: Int = 100) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
}

extension Int32 {
    /// SwiftRandom extension
    static func random(_ range: Range<Int>) -> Int32 {
        return random(range.upperBound, range.lowerBound)
    }
    
    /// SwiftRandom extension
    ///
    /// - note: Using `Int` as parameter type as we usually just want to write `Int32.random(13, 37)` and not `Int32.random(Int32(13), Int32(37))`
    static func random(_ lower: Int = 0, _ upper: Int = 100) -> Int32 {
        let r = arc4random_uniform(UInt32(Int64(upper) - Int64(lower)))
        return Int32(Int64(r) + Int64(lower))
    }
}

extension String {
    /// SwiftRandom extension
    static func random(ofLength length: Int) -> String {
        return random(minimumLength: length, maximumLength: length)
    }
    
    /// SwiftRandom extension
    static func random(minimumLength min: Int, maximumLength max: Int) -> String {
        return random(
            withCharactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",
            minimumLength: min,
            maximumLength: max
        )
    }
    
    /// SwiftRandom extension
    static func random(withCharactersInString string: String, ofLength length: Int) -> String {
        return random(
            withCharactersInString: string,
            minimumLength: length,
            maximumLength: length
        )
    }
    
    /// SwiftRandom extension
    static func random(withCharactersInString string: String, minimumLength min: Int, maximumLength max: Int) -> String {
        guard min > 0 && max >= min else {
            return ""
        }
        
        let length: Int = (min < max) ? .random(min...max) : max
        var randomString = ""
        
        (1...length).forEach { _ in
            let randomIndex: Int = .random(0..<string.count)
            let c = string.index(string.startIndex, offsetBy: randomIndex)
            randomString += String(string[c])
        }
        
        return randomString
    }
}

extension Double {
    /// SwiftRandom extension
    static func random(_ lower: Double = 0, _ upper: Double = 100) -> Double {
        return (Double(arc4random()) / Double.greatestFiniteMagnitude) * (upper - lower) + lower
    }
}

extension Float {
    /// SwiftRandom extension
    static func random(_ lower: Float = 0, _ upper: Float = 100) -> Float {
        return (Float(arc4random()) / Float.greatestFiniteMagnitude) * (upper - lower) + lower
    }
}

extension CGFloat {
    /// SwiftRandom extension
    static func random(_ lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }
}

extension Date {
    /// SwiftRandom extension
    static func randomWithinDaysBeforeToday(_ days: Int) -> Date {
        let today = Date()
        let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
        
        let r1 = arc4random_uniform(UInt32(days))
        let r2 = arc4random_uniform(UInt32(23))
        let r3 = arc4random_uniform(UInt32(59))
        let r4 = arc4random_uniform(UInt32(59))
        
        var offsetComponents = DateComponents()
        offsetComponents.day = Int(r1) * -1
        offsetComponents.hour = Int(r2)
        offsetComponents.minute = Int(r3)
        offsetComponents.second = Int(r4)
        
        guard let rndDate1 = gregorian.date(byAdding: offsetComponents, to: today) else {
            print("randoming failed")
            return today
        }
        return rndDate1
    }
    
    /// SwiftRandom extension
    static func random() -> Date {
        let randomTime = TimeInterval(arc4random_uniform(UInt32.max))
        return Date(timeIntervalSince1970: randomTime)
    }
    
}

extension UIColor {
    /// SwiftRandom extension
    static func random(_ randomAlpha: Bool = false) -> UIColor {
        let randomRed = CGFloat.random()
        let randomGreen = CGFloat.random()
        let randomBlue = CGFloat.random()
        let alpha = randomAlpha ? CGFloat.random() : 1.0
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }
}

extension Array {
    /// SwiftRandom extension
    func randomItem() -> Element? {
        guard self.count > 0 else {
            return nil
        }
        
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

extension ArraySlice {
    /// SwiftRandom extension
    func randomItem() -> Element? {
        guard self.count > 0 else {
            return nil
        }
        
#if swift(>=3)
        let index = Int.random(self.startIndex, self.count - 1)
#else
        let index = Int.random(self.startIndex, self.endIndex)
#endif
        
        return self[index]
    }
}

extension URL {
    /// SwiftRandom extension
    static func random() -> URL {
        let urlList = ["http://www.google.com", "http://leagueoflegends.com/", "https://github.com/", "http://stackoverflow.com/", "https://medium.com/", "http://9gag.com/gag/6715049", "http://imgur.com/gallery/s9zoqs9", "https://www.youtube.com/watch?v=uelHwf8o7_U"]
        return URL(string: urlList.randomItem()!)!
    }
}


struct Randoms {
    
    //==========================================================================================================
    // MARK: - Object randoms
    //==========================================================================================================
    static func randomBool() -> Bool {
        return Bool.random()
    }
    
    static func randomInt(_ range: Range<Int>) -> Int {
        return Int.random(range)
    }
    
    static func randomInt(_ lower: Int = 0, _ upper: Int = 100) -> Int {
        return Int.random(lower, upper)
    }
    
    static func randomInt32(_ range: Range<Int>) -> Int32 {
        return Int32.random(range)
    }
    
    static func randomInt32(_ lower: Int = 0, _ upper: Int = 100) -> Int32 {
        return Int32.random(lower, upper)
    }
    
    static func randomString(ofLength length: Int) -> String {
        return String.random(ofLength: length)
    }
    
    static func randomString(minimumLength min: Int, maximumLength max: Int) -> String {
        return String.random(minimumLength: min, maximumLength: max)
    }
    
    static func randomString(withCharactersInString string: String, ofLength length: Int) -> String {
        return String.random(withCharactersInString: string, ofLength: length)
    }
    
    static func randomString(withCharactersInString string: String, minimumLength min: Int, maximumLength max: Int) -> String {
        return String.random(withCharactersInString: string, minimumLength: min, maximumLength: max)
    }
    
    static func randomPercentageisOver(_ percentage: Int) -> Bool {
        return Int.random() >= percentage
    }
    
    static func randomDouble(_ lower: Double = 0, _ upper: Double = 100) -> Double {
        return Double.random(lower, upper)
    }
    
    static func randomFloat(_ lower: Float = 0, _ upper: Float = 100) -> Float {
        return Float.random(lower, upper)
    }
    
    static func randomCGFloat(_ lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat.random(lower, upper)
    }
    
    static func randomDateWithinDaysBeforeToday(_ days: Int) -> Date {
        return Date.randomWithinDaysBeforeToday(days)
    }
    
    static func randomDate() -> Date {
        return Date.random()
    }
    
    static func randomColor(_ randomAlpha: Bool = false) -> UIColor {
        return UIColor.random(randomAlpha)
    }
    
    static func randomNSURL() -> URL {
        return URL.random()
    }
    
    //==========================================================================================================
    // MARK: - Fake random data generators
    //==========================================================================================================
    static func randomFakeName() -> String {
        let firstNameList = ["Henry", "William", "Geoffrey", "Jim", "Yvonne", "Jamie", "Leticia", "Priscilla", "Sidney", "Nancy", "Edmund", "Bill", "Megan"]
        let lastNameList = ["Pearson", "Adams", "Cole", "Francis", "Andrews", "Casey", "Gross", "Lane", "Thomas", "Patrick", "Strickland", "Nicolas", "Freeman"]
        return firstNameList.randomItem()! + " " + lastNameList.randomItem()!
    }
    
    static func randomFakeGender() -> String {
        return Bool.random() ? "Male" : "Female"
    }
    
    static func randomFakeConversation() -> String {
        let convoList = ["You embarrassed me this evening.", "You don't think that was just lemonade in your glass, do you?", "Do you ever think we should just stop doing this?", "Why didn't he come and talk to me himself?", "Promise me you'll look after your mother.", "If you get me his phone, I might reconsider.", "I think the room is bugged.", "No! I'm tired of doing what you say.", "For some reason, I'm attracted to you."]
        return convoList.randomItem()!
    }
    
    static func randomFakeTitle() -> String {
        let titleList = ["CEO of Google", "CEO of Facebook", "VP of Marketing @Uber", "Business Developer at IBM", "Jungler @ Fanatic", "B2 Pilot @ USAF", "Student at Stanford", "Student at Harvard", "Mayor of Raccoon City", "CTO @ Umbrella Corporation", "Professor at Pallet Town University"]
        return titleList.randomItem()!
    }
    
    static func randomFakeTag() -> String {
        let tagList = ["meta", "forum", "troll", "meme", "question", "important", "like4like", "f4f"]
        return tagList.randomItem()!
    }
    
    fileprivate static func randomEnglishHonorific() -> String {
        let englishHonorificsList = ["Mr.", "Ms.", "Dr.", "Mrs.", "Mz.", "Mx.", "Prof."]
        return englishHonorificsList.randomItem()!
    }
    
    static func randomFakeNameAndEnglishHonorific() -> String {
        let englishHonorific = randomEnglishHonorific()
        let name = randomFakeName()
        return englishHonorific + " " + name
    }
    
    static func randomFakeCity() -> String {
        let cityPrefixes = ["North", "East", "West", "South", "New", "Lake", "Port"]
        let citySuffixes = ["town", "ton", "land", "ville", "berg", "burgh", "borough", "bury", "view", "port", "mouth", "stad", "furt", "chester", "mouth", "fort", "haven", "side", "shire"]
        return cityPrefixes.randomItem()! + citySuffixes.randomItem()!
    }
    
    static func randomCurrency() -> String {
        let currencyList = ["USD", "EUR", "GBP", "JPY", "AUD", "CAD", "ZAR", "NZD", "INR", "BRP", "CNY", "EGP", "KRW", "MXN", "SAR", "SGD",]
        
        return currencyList.randomItem()!
    }
    
    enum GravatarStyle: String {
        case Standard
        case MM
        case Identicon
        case MonsterID
        case Wavatar
        case Retro
        
        static let allValues = [Standard, MM, Identicon, MonsterID, Wavatar, Retro]
    }
    
    static func createGravatar(_ style: Randoms.GravatarStyle = .Standard, size: Int = 80, completion: ((_ image: UIImage?, _ error: Error?) -> Void)?) {
        var url = "https://secure.gravatar.com/avatar/thisimagewillnotbefound?s=\(size)"
        if style != .Standard {
            url += "&d=\(style.rawValue.lowercased())"
        }
        
        let request = URLRequest(url: URL(string: url)! as URL, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        let session = URLSession.shared
        
        session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if error == nil {
                    completion?(UIImage(data: data!), nil)
                } else {
                    completion?(nil, error)
                }
            }
        }).resume()
    }
    
    static func randomGravatar(_ size: Int = 80, completion: ((_ image: UIImage?, _ error: Error?) -> Void)?) {
        let options = Randoms.GravatarStyle.allValues
        Randoms.createGravatar(options.randomItem()!, size: size, completion: completion)
    }
}
