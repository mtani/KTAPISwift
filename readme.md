## Kuveyt Turk API Banking Platform Swift SDK
This iOS SDK helps iOS developers build iOS mobile applications that integrate with Kuveyt Turk API Banking Platform.

*Note: This sample does not necessarily demonstrate the best use but rather features of using Kuveyt Turk API Banking iOS SDK. Always remember to handle exceptions.*

KuveytTurkAPISwift framework for   **iOS**  written in Swift 4.0.

- [⤵️ Installation](#installation)
- [🛠 Usage](#usage)
- [📱 Sample iOS app](https://github.com/link/example) (using CocoaPods)

Installation
------------
Add a `Podfile` that contains at least the following information to the root of your app project, then do `pod install`.
If you're unfamiliar with CocoaPods, read [using CocoaPods](http://guides.cocoapods.org/using/using-cocoapods.html).

```ruby
platform :ios, '10.0'
use_frameworks!

target 'YourProject' do
pod 'p2.OAuth2', :git => 'https://github.com/kuveytturk/OAuth2', :submodules => true
pod  'KuveytTurkAPISwift', :git => 'https://github.com/mtani/KTAPISwift', :submodules => true
end
```

Usage
-----

To use KuveytTurkAPISwift in your own code, start with `import KuveytTurkAPISwift`  in your source files.


### 1. Client Information For Request
To consume the APIs, you have to register to [Kuveyt Turk API Market](https://developer.kuveytturk.com.tr/#/). Upon, you can get client id and client secret after creating an application on the API Market.
For more information, you can see [authorization guide document](https://developer.kuveytturk.com.tr/#/documentation/general/Authorization%20Guide).

### 2. Create signature
You need pem file for private and public keys at your projects main path.

### 3. Instantiate OAuth2 with a Settings Dictionary

```swift
static let oauth2 = OAuthCodeGrant(settings: [
"client_id": "f68b52e80a61404c9588a3f87006bd1e",
"client_secret": "ht86Q7nZLhwdThKsDMnF5Bqqfg2z6cqzezSIh0BTnZAccrn+4WTHoQ==",
"authorize_uri": ConnectionOptions.authorizeUri,
"token_uri": ConnectionOptions.tokenUri,
"scope": "accounts transfers loans offline_access public",
"redirect_uris": ["ppoauthapp://oauth/callback"],     // register your own "myapp" scheme in Info.plist
"secret_in_body": true,
] as OAuth2JSON)
```
See those `redirect_uris`?
You can use the scheme you want, but you must **a)** declare the scheme you use in your `Info.plist` and **b)** register the very same URI on the authorization server you connect to.

### 4. Let the Data Loader and  Execute Request

There is an `DataLoader` class that you can use to retrieve data from an API.
It will automatically start authorization if needed and will ensure that this works even if you have multiple calls going on.

```swift
oauth2.authConfig.authorizeEmbedded = true
oauth2.authConfig.authorizeContext = self
let loader = DataLoader(oauth2: oauth2)
self.loader = loader

let parameters: [String: String]? = ["onlyHasAvailableBalance":"1", "onlyOpen":"0","onlyWithNoBalance":"0","onlyCurrent":"0","sharedWithMultiSignature":"0"]


let requestEndPoint: URLRequest = loader.createMethodRequest(enpoint: .MoneyTransferExecute, oauth2: oauth2, parameters: parameters)
loader.perform(request: requestEndPoint) { response in
do {
let json = try response.responseJSON()
self.didGetUserdata(dict: json, loader: loader)
}
catch let error {
self.didCancelOrFail(error)
}
}
```

### 5. Make Sure You Intercept the Callback

When using the OS browser or the iOS 9+ Safari view controller, you will need to **intercept the callback** in your app delegate and let the OAuth2 instance handle the full URL:

```swift
func application(_ app: UIApplication, open url: URL,
options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
// you should probably first check if this is the callback being opened
if <# check #> {
// if your oauth2 instance lives somewhere else, adapt accordingly
oauth2.handleRedirectURL(url)
}
}
```

### 6. Endpoint Information For Request

You have to set just endpoint name for a request. The query and header parameters are optional. You can find more information on  [Kuveyt Turk API Market documantation page](https://developer.kuveytturk.com.tr/#/documentation)
```swift
auth2.authConfig.authorizeEmbedded = true
oauth2.authConfig.authorizeContext = self
let loader = DataLoader(oauth2: oauth2)
self.loader = loader

let parameters: [String: String]? = ["onlyHasAvailableBalance":"1", "onlyOpen":"0","onlyWithNoBalance":"0","onlyCurrent":"0","sharedWithMultiSignature":"0"]


let requestEndPoint: URLRequest = loader.createMethodRequest(enpoint: .Accounts,
oauth2: oauth2, parameters: parameters)
loader.perform(request: requestEndPoint) { response in
do {
let json = try response.responseJSON()
self.didGetUserdata(dict: json, loader: loader)
}
catch let error {
self.didCancelOrFail(error)
}
}
```

### 7. Endpoint Name List in SDK

In below example, In order to call Accounts method, we used `.Accounts` type. Other endpoints are

 `Accounts, UserOTPSend, UserOTPVerify, MoneyTransferExecute, MoneyTransferToIBAN, MoneyTransferToAccount, MoneyTransferToName, CashWithdrawalFromATMviaQRCode, MoneyTransferToGSM, MoneyTransferToGSMTransactions, MoneyTransferToGSMCanceling, LoanFinanceList, KuveytTurkXTMList, KuveytTurkATMList, BankList, FXCurrencyRates ,FxCurrencyList, LoanFinanceCalculation, LoanFinanceCalculationParameter, TestCustomerList, KuveytTurkBranchList`

```swift
let requestEndPoint: URLRequest = loader.createMethodRequest(enpoint: .Accounts,
oauth2: oauth2, parameters: parameters)
```
### 8. Endpoints with path in SDK

In below example, In order to call Accounts Transactions method, we used `.AccountsTransactions` type and created path according to account suffix. Other endpoints with path are

 `AccountTransactions, LoanFinanceInstallments, LoanFinanceInfo, BankBranchList, Receipt`


```swift
let queryParameters: [String: String]? = ["beginDate":"2017-08-01", "endDate":"2017-10-01","minAmount":"1","maxAmount":"10000"]
            requestURL = loader.createMethodRequestWith(path: "/prep/v1/accounts/3/transactions", enpoint: .AccountTransactions, oauth2: oauth2, parameters: queryParameters)
```



Used Frameworks
------------
For Oauth 2.0 transactions, we embedded  [P2 Oauth Swift Framework](https://github.com/p2/OAuth2) into our KuveytTurkAPISwift Framework.
And for signing with a private key we embedded [SwiftyRSA Framework](https://github.com/TakeScoop/SwiftyRSA).
[P2 Oauth Swift](https://github.com/p2/OAuth2)
[SwiftyRSA](https://github.com/TakeScoop/SwiftyRSA)
