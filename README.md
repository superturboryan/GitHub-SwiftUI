## Build tools & versions used
Xcode 15.0 (15A240d) 🔨    
Swift 5.9 🦜    
iOS 17.0 minimum deployment 📲  

## Steps to run the app
- Open `GitHub.xcodeproj` with Xcode
- Add `Config.xcconfig` file to `GitHub/Config` group
    - This file cannot be committed to GH, it contains a key that is invalidated if uploaded
- Select iOS run destination
- Run! 🏃‍♂️💨

### Note
`Config.xcconfig` should contain:
```c
// /$()/ -> workaround for encoding //
GH_API_URL = https:/$()/api.github.com
GH_ACCESS_TOKEN = ...
```

## Screenshots
<p float="left">
    <img src="Screenshots/User%20List%20-%20Dark.png" width=400 />
    <img src="Screenshots/User%20List%20-%20Light.png" width=400 />
</p>

## Dependency Graph
<img src="https://github.com/superturboryan/GitHub-SwiftUI/blob/d87dd534a378aee6ffef4a34d320bde00b058b53/Dependency%20Graph.png" />

## Areas of focus
- Business logic, data flow
- Minimizing dependencies
- Reuseable, modular UI

## What problems was I trying to solve?
- Given that we're not asked to implement a complicated UI, I wanted to focus on keeping the business logic separated from the UI and network API to achieve separation of concerns and high testability.
- I implemented [UserStore](GitHub/User/UserStore.swift) to act as the single source of truth for [UserListView](GitHub/UI/UserListView.swift), keeping all the logic for loading, sorting, and searching for users inside the store. UserStore could also be re-used by other views.
- UserStore only knows about its service for fetching users through a protocol **UserAccessing**, making it easy to inject different concrete implementations for tests + previews, and making the network API also adapt to this protocol (dependency inversion).
- The **UserAccessing** protocol requires that its implementations output a **DisplayableUser**. This forces models from the network API to depend on the protocol's type, and not make our app depend on the network models.
- UserStore has **100%** test coverage with easy-to-follow tests, allowing us to continue modifying the app without worrying about business logic breaking. 
- UserListView uses a standard SwiftUI list, so we get native pull-to-refresh and searching behaviour. 
- The base API url is stored in an `.xcconfig`. We can use different config files for different build configurations (Debug, Release, ...) to configure the target app. The config file is also a more secure place to put secret API keys rather than having them directly in the info.plist or hardcoded elsewhere, since it is typically ignored by source control.
- Dependencies are managed by a lightweight enum [CompositionRoot](GitHub/CompositionRoot.swift) with all the app's private dependencies inside.

## Time spent

~3 hours

## Trade-offs? What would I do if I spent more time...

- I would try to make the commits easier to review by making them smaller, more atomic
- Add utilities like **SwiftGen** for referencing assets, **SwiftLint** for consistent formatting
- Localize strings
- Ensure accessibility features work (dynamic type, voiceover, color contrasting, ...)
- Build more screens (user detail view, show user followers)
