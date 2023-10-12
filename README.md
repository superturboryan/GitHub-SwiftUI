## Build tools & versions used
Xcode 15.0 (15A240d) 🔨    
Swift 5 🦜    
iOS 17.0 minimum deployment 📲  

## Steps to run the app
- Open `GitHub.xcodeproj` with Xcode
- Add Config.xcconfig file to GitHub/GitHub/Config group
    - This file cannot be committed to GH, it contains a key that is invalidated if uploaded
- Select iOS run destination
- Run! 🏃‍♂️💨

## Screenshots
<p float="left">
    <img src="" width=400 />
    <img src="" width=400 />
</p>

## Areas of focus
- Business logic, data flow
- Minimizing dependencies
- Reuseable, modular UI

## What problems was I trying to solve?
- Given that we're not asked to implement a complicated UI, I wanted to focus on keeping the business logic separated from the UI and network API to achieve separation of concerns and high testability.
- I implemented [UserStore](GitHub/GitHub/User/UserStore.swift) to act as the single source of truth for [UserListView](GitHub/GitHub/UI/UserListView.swift), keeping all the logic for loading, sorting, and searching for users inside the store. UserStore could also be re-used by other views.
- UserStore only knows about its service for fetching users through a protocol **UserAccessing**, making it easy to inject different concrete implementations for tests + previews, and making the network API also adapt to this protocol (dependency inversion).
- The **UserAccessing** protocol requires that its implementations output a **DisplayableUser**. This forces models from the network API to depend on the protocol's type, and not make our app depend on the network models.
- UserStore has full test coverage with easy-to-follow tests, allowing us to continue modifying the app without worrying about business logic breaking. 
- UserListView uses a standard SwiftUI list, so we get native pull-to-refresh and searching behaviour. 
- The base API url is stored in [Config.xcconfig](GitHub/GitHub/Config/Config.xcconfig). We can use different config files for different build configurations (Debug, Release, ...) to configure the target app. The config file is also a more secure place to put secret API keys rather than having them directly in the info.plist or hardcoded elsewhere, since it is typically ignored by source control.

### Dependency Graph
<img src="" />

## Time spent

~3 hours

## Trade-offs? What would I do if I spent more time...

- I would try to make the commits easier to review by making them smaller, more atomic
- Add utilities like **SwiftGen** for referencing assets, **SwiftLint** for consistent formatting
- Localize strings
- Ensure accessibility features work (dynamic type, voiceover, color contrasting, ...)
