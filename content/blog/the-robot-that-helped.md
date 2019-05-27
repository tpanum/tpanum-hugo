+++
date = "2017-04-03T20:00:00+02:00"
draft = false
title = "The Robot That Got Me a Home In Copenhagen"
keywords = [ "programming" ]
description = "Solution for automating apartment hunting in Copenhagen"
+++
Everyone knows the struggle of getting an apartment in Copenhagen.
It is a tough task, and a decent network is surely very valuable in that regard.
However, as many others, I had almost no network in Copenhagen prior to moving here for my job at [Ecsact](http://ecsact.dk/).
My journey began at [Boligportalen](https://www.boligportal.dk/), which is most used site for finding apartments for rent in Denmark.
One of the most notable features about boligportalen, is the fact that they have an absurdly expensive subscription for accessing contact for the landlords.
At the time of my apartment hunt, the price were approximately 300 DDK/month (~$50), with no guarantees or payback option.
They even had an option get a discount, if you were ready to pay your subscription in advance for several months.
Does anyone *expect* to be seeking an apartment for several months, and then just *donate* the remaining months to boligportalen? Absurd.

After spending some time on boligportalen, in a human-fashion, I found common two strategies that landlords used for finding a tenant.
The first one is the well-known ["first-come, first-served"](https://en.wikipedia.org/wiki/First-come,_first-served)-strategy.
This approach usually involved signing up for a display session through phone calls, until the *N*-spots for display session were filled.
Landlords using this strategy seems to heavily favor phone calls over messages sent through boligportalen.
This strategy requires a fast reaction from the *future* tenants, and leaves no hope for the lazy.

The second strategy were primarily used by landlords who did not want phone calls.
It involves pilling up a stack of messages from hopeful future tenants, and then picking *N* tenants for a display session based on recency of the messages at the time of checking the inbox.

I quickly realized that the second strategy were tough to deal with, due to its sporadic behaviour.
However, the interaction with the first strategy could definitely be improved.
The current interaction involve manually checking for new listings in a sporadic [hearbeat-fashion](https://en.wikipedia.org/wiki/Heartbeat_(computing)).
This process comes with a severe risk for insanity, and could ideally be turned into a [publish-subscribe](https://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern) pattern.
For the non-computer science reader: Instead of manually checking for new listings, it would be more ideal to receive notifications for when a new listings appear.

Doing this process transformation is relatively simple, and is accomplished by scraping the site with a relatively high interval (e.g. every 3s) and then publish changes as they occur.
From the get-go I knew I wanted to subscribe to the updates on my iPhone, and using the built-in notification system was a natural choice.
However, for hackish project like this one, it is not trivial to access that channel, as it requires a related app and approval of Apple in order to use their notification servers.
I first tried sending emails poorly hosted mail server, and realized that the iPhone mail-pulling had too low frequency for my use case.
I had a desire to notified of new listings within ten seconds of them appearing online, so I investigate other channels.
I knew my old university mail, which ran on a Microsoft Exchange server, had the ability to push mails directly to my phone, so I started to research for Exchange hosting.
Quickly did I realize that moving me private mail to an Exchange solution would be too expensive.
However, during my research I discovered that [Gmail](https://mail.google.com), in combination with the [Gmail App for iPhone](https://itunes.apple.com/us/app/gmail-email-by-google-secure-fast-organized/id422689480?mt=8), were able to accomplish the same push behaviour.
After I few tests, I realized that this would be suitable for use case.

Unleashing *the beast* (ie: the robot) quickly yielded some results.
The robot published listings to me while I were at work, which I contacted straight away, and within a few days I were invited to more than five display sessions.
During this time I recall a lot of funny phone conversations with landlords, they usually went something like this:

> **Me**: *Hello, my name is Thomas and call regarding the apartment you have listed on boligportalen*

> **Landlord**: *Uh... oh... eh?* 🤔

> **Me**: *Did I get the wrong number, or is it already unavailable?*

> **Landlord**: *Yes, it is still I available... it is just that I JUST put it up?*

> *... proceeds to get display session invitation* 🎉

During the time the robot were running boligportalen decided to create an iPhone App with an alike feature, but I never got it to work (and I would never trust its publishing delay).
I ended up with an apartment within two weeks after been invited to over twenty display sessions.

You can find the (old) source code for the robot [here](https://github.com/tpanum/boligcrawler). 🤖
