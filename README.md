# BalancesCard

### Environment

Xcode 12.5, deployment target 14.5, written in Swift

### Overview
The initial sreen is `AccountListViewController` which shows a list of accounts. Tapping the row in `AccountListViewController` will transit to `TransactionListViewController`, which shows the details of transactions for the selected account. Both ViewControllers use tableView section header to display data.

### Thoughts
1. Since this is a light-version app and no API is connected, third-party libraries are not used for simplicity(For example,  `Alamofire` and `RxSwift`). 
2. `AccountListViewController` renders its UI based on `AccountViewModel`. And `TransactionListViewController` renders its UI based on `TransactionViewModel`. In the `Model` folder, we create models based on Json response. And based on what we need to display in view controllers, we create view models from models, including variables such as `totalIn` and `totalOut`. We use dictionary to implement the grouping function and sort the dictionary keys to make the corresponding arrays to order as expected. 
3. Functions used multiple times are implemented as extension in `Utility` folder. Since all the amount is applied to the same currency format, `CurrencyFormatter` is implemented as a singleton class. 

### Future Improvement
1. Account's nickname is sorted by default string comparison. It's OK for English nickname, but for Japanese we need to consider Kanji, Hiragana and Katakana. The sorting algorithm should be improved in real-life situation.
2. In `CurrencyFormatter`, we convert a `Double` to String and apply a currency format to it, which causes precision problem. 
3. UI layout is implemented as simple as possible. Dark mode, rotation is not considered. 
