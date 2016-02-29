# Project 4 - TwitterClient

**Name of your app** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: 11 hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign in using OAuth login flow
- [x] User can view last 20 tweets from their home timeline
- [x] The current signed in user will be persisted across restarts
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [x] Retweeting and favoriting should increment the retweet and favorite count.

The following **optional** features are implemented:

- [x] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [x] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [x] User can pull to refresh.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Search function
2. Custom skins to cells

## Video Walkthrough 

Here's a walkthrough of implemented user stories:
http://imgur.com/5nRIV3e
<img src='http://i.imgur.com/5nRIV3e.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

## License

    Copyright 2016  Douglas Li

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

Time spent: **X** hours spent in total

## User Stories

The following **required** functionality is completed:

- [ ] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [ ] Profile page:
   - [ ] Contains the user header view
   - [ ] Contains a section with the users basic stats: # tweets, # following, # followers
- [ ] Home Timeline: Tapping on a user image should bring up that user's profile page
- [ ] Compose Page: User can compose a new tweet by tapping on a compose button.

The following **optional** features are implemented:

- [ ] When composing, you should have a countdown in the upper right for the tweet limit.
- [ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [ ] Profile Page
   - [ ] Implement the paging view for the user description.
   - [ ] As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
   - [ ] Pulling down the profile page should blur and resize the header image.
- [ ] Account switching
   - [ ] Long press on tab bar to bring up Account view with animation
   - [ ] Tap account to switch to
   - [ ] Include a plus button to Add an Account
   - [ ] Swipe to delete an account

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!
- [ ] In compose view controller, something that keeps track of how much text has been entered. [Use delegate to increment text count] Max of 140.


Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. 
2. 

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/link/to/your/gif/file.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.
- Denoted my MARK515 in the DetailedViewController. Unwrapped nils while trying to assign values to storyboard under a didSet (forgot the actual term for this atm will edit this back in if i remember) , this is caused because im trying to set values while still in a previous view controller (in prepareforsegue) before buttons and labels are instantied so it makes sense for xcode to unwrap nils since it is prepareforsegue and segue hasnt been initiated nor completed. tl;dr im dumb
