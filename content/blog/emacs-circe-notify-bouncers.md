+++
date = "2018-08-10T12:00:00+02:00"
draft = false
title = "Disable Bouncer Playback Spam for Emacs Circe Notifications"
description = "Code snippet for disabling playback spam in Emacs IRC client"
keywords = [ "emacs" ]
+++
I recently changed to using [circe](https://github.com/jorgenschaefer/circe) as my everyday IRC client.
Despite the [circe-notifications](https://github.com/eqyiel/circe-notifications) being featureful, the suggested way to reduce notification spam from your irc bouncer is a bit of a hack.
As stated in the readme, simply delay the activation hook by *x* seconds and pray it is large enough for missing all notifcations during playback.

<p align="center">
<img style="margin: 50px auto; display: block; width: 70%" src="/img/team_chat.png">
</p>

From my experience it works reasonably well, however, when you work on a laptop (with `circe-lagmon-mode` for reconnection after suspend) the issue persist as you reconnect to your bouncer in the same emacs session.
I am using ZNC as my bouncer, and it conviently prefixes all messages with a timestamp.
Knowing this, I customized `circe-notifications-notify` to ignore messages with such a prefix.

```lisp
(defun circe-notifications-notify (nick body channel)
  (unless (string-match "^\[[0-9]+:[0-9]+\]" body)
      (alert
       body
       :severity circe-notifications-alert-severity
       :title nick
       :style circe-notifications-alert-style)))
```
