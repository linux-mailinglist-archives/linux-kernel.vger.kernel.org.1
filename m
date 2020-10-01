Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A594027FBDF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbgJAIuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgJAIuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:50:17 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A1BC0613D0;
        Thu,  1 Oct 2020 01:50:17 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kNuI3-0004NZ-Kr; Thu, 01 Oct 2020 10:50:15 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 22/26] docs: reporting-bugs: explain what users should do once the report got out
Date:   Thu,  1 Oct 2020 10:50:14 +0200
Message-Id: <60aeaadf670271ee69a47f5eff3f6bf7b530ac5a.1601541165.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601541165.git.linux@leemhuis.info>
References: <cover.1601541165.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601542217;67c2e41d;
X-HE-SMSGID: 1kNuI3-0004NZ-Kr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users should know that sending the report is not the end of this
process: if want to see the issue fixed, they will need to keep the ball
rolling sometimes. Hence, explain why it's in their interest to send a
reminder occasionally. Als point out that it's a really good idea to
retest shortly after the rc1 of a new mainline release came out.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---

= RFC =

This commit removes a section from the old text that kinda tells maintainers
what users can expect from them. Should this be made more explicit in the Kernel
Maintainer Handbook? Maybe something along the lines of "Try to answer each
issue report at least once, ideally within 1 to 5 business days"?
---
 Documentation/admin-guide/reporting-bugs.rst | 222 +++++++++++++++----
 1 file changed, 180 insertions(+), 42 deletions(-)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index b06935cad880..b8bc6c4e2340 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -1043,6 +1043,186 @@ High priority issues need special handling when sending the report:
    information.
 
 
+Duties after the report went out
+--------------------------------
+
+    *Wait for reactions and keep the thing rolling until you can accept the
+    outcome in one way or the other. Thus react publicly and in a timely manner
+    to any inquiries. Test proposed fixes. Do proactive testing when a new rc1
+    gets released. Sent friendly reminders if things stall. And try to help
+    yourself, if you don't get any help or if it is unsatisfying.*
+
+If your report was good and you are really lucky then one of the developers
+might immediately spot what's causing the issue; then he might write a patch to
+fix it, test it, and sends it straight for integration in mainline while
+tagging it for later backport to stable and longterm kernels that need it. Then
+all you need to do is reply with a 'Thank you very much' and switch to a
+version with the fix once it gets released.
+
+But this ideal scenario rarely happens, that's why the job is only starting once
+you got the report out. What you'll have to do depends on the issue, but often
+it will be the things listed below. But before digging into the details a few
+important things you need to keep in mind for this part of the process.
+
+General advice for further interactions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+*Always reply in public*: When the issue was filed in a bug tracker always
+reply there and do not contact any of the developer privately about it. For
+mailed reports always use the 'Reply-all' function when replying to any mails
+you receive. That includes mails with any additional data you might want to add
+to your report: go to your mail applications 'Sent' folder and use 'reply-all'
+on your mail with the report. This approach will make sure the public mailing
+list(s) and everyone else that gets involved over time always stays in the
+loop; it also keeps the mail thread intact, which among others is really
+important for mailing list to group all related mails together.
+
+There are just two situations where a comment in a bug tracker or a 'Reply-all'
+is unsuitable:
+
+ * Someone tells you to send something privately.
+
+ * You were told to sent something, but noticed it contains sensitive
+   information that really needs to be kept private. In that case it's okay to
+   sent it in private to the developer that asked for it. But point in the
+   ticket or a mail that you did that, so everyone else knows the request was
+   honored.
+
+*Do research before asking for clarifications or help*: In this part of the
+process someone might tell you to do something that requires a skill you might
+not have mastered yet. For example, you might get ask to use some test tools
+you never have heard of yet; or you might get asked to apply a patch to the
+Linux kernel sources to test if it helps. In some cases it will be fine sending
+a reply asking for instructions how to do that. But before going that route try
+to find the answer own your own by searching the internet; alternatively
+consider asking a friend or in some chatroom/forum you normally hang out for
+advice.
+
+*Be patient*: If you are really lucky you might get a reply to your report
+within a few hours. But most of the time it will take longer, as maintainers
+are scattered around the globe and thus might be in a different time zone – one
+where they already enjoy their evening away from keyboard.
+
+In general, kernel developers will take one to five business days to respond to
+reports. Sometimes it will take longer, as they might be busy with other work,
+visiting developer conferences, or simply enjoying a long summer holiday.
+
+The 'issues of high priority' (see above for an explanation) are an exception
+here: maintainer should address them as soon as possible, that's why you should
+wait a week at maximum (or just two days if it's something urgent) before
+sending a friendly reminder. If the maintainer is not responding in a timely
+manner or not handing it appropriately, mention that you are considering to
+escalate the issue to a higher authority and do so if there is in the end
+there seems to be no way around this. In case of Wi-Fi driver code you for
+example would escalate it to the wireless maintainers; if there are no higher
+level maintainers or all else fails it might be one of those situations where
+it's okay to get Linus Torvalds involved directly.
+
+*Proactive testing*: Every time the first pre-release (the 'rc1') of a new
+mainline kernel version gets released, go and check if the issue is fixed there
+or if anything of importance changed. Mention the outcome in the ticket or in a
+reply to the report (make sure it has all those in the CC that up to that point
+participated in the discussion). This will show your commitment and that you
+are willing to help. It also tells developers if the issue persists and makes
+sure they do not forget about it. A few other occasional retests (for example
+with rc3, rc6 and the final) are also a good idea, but only report your results
+if something relevant changed or if you are writing something anyway.
+
+With all these general things off the table let's get into the details how to
+help to get issues resolved once they were reported.
+
+Inquires and testing request
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Here are your duties in case you got replies to your report:
+
+ *Check who you deal with*: Most of the time it will be the maintainer or a
+ developer of the particular code area that will respond to your report. But as
+ issues are normally reported in public it could be anyone that's replying —
+ including people that want to help, but in the end might guide you totally off
+ track with their questions or requests. That rarely happens, but it's one of
+ many reasons why it's wise to quickly run an internet search to see who you're
+ interacting with. You also get aware if your report was heard by the right
+ people, as a reminder to the maintainer (see below) might be in order later if
+ discussion fades out and does not lead to a fix.
+
+ *Inquires for data*: Often you will be asked to test something or provide
+ additional details. Try to provide the information requested soon, as you have
+ the attention of someone that might help and risk losing it the longer you
+ wait; that outcome is even likely if you do not provide the information within
+ a few business days.
+
+ *Requests for testing*: When you get asked to test a diagnostic patch or a
+ possible fix try to test it in timely manner, too. Do it properly and make
+ sure to not rush it: mixing things up can happen easily and lead to a lot
+ of confusion for everyone involved. A common mistake for example is thinking a
+ kernel patch that might fix the issue was applied, but in fact wasn't – even
+ experienced testers make such mistakes occasionally and only notice when the
+ kernel built from those sources behaves just as before.
+
+What to do when nothing of substance happens
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Some report will not get any reaction from the responsible Linux kernel
+developers; or a discussion around the issue evolved, but it faded out and
+nothing of substance came out of it.
+
+In these cases wait two (better: three) weeks before sending a friendly
+reminder: maybe the maintainer was just away from keyboard for a while when
+your report arrived or had something more important to take care of. When
+writing the reminder, kindly ask if anything else from your side is needed to
+get the ball running somehow. If the report got out by mail do that in the first
+lines of a mail that is a reply to your initial mail (see above) which includes
+a full quote of the original report below: that's on of those few situations
+where such a 'TOFU' (Text Over, Fullquote Under) is the right approach, as then
+all the recipients will have the details at hand immediately in the proper
+order.
+
+After the reminder wait three more weeks for replies. If you still don't get a
+proper reaction, you first should reconsider your approach. Did you maybe try
+to reach out to the wrong people? Was the report maybe offensive or so
+confusing that people decided to completely stay away from it? The best way to
+rule out such factors: show the report to one or two people familiar with FLOSS
+issue reporting and ask for their option. Also ask them for their advice how to
+move forward. That might mean: prepare a better report and make those people
+review it before you sent it out. Such an approach it totally fine, just
+mentions that this is the second and improved report on the issue and include a
+link to the first report.
+
+If the report was proper you can send a second reminder; in it ask for advice
+why the report did not get any replies. A good moment for this second reminder
+mail is shortly after the first pre-release (the 'rc1') of a new Linux kernel
+version got published, as you should retest at that point anyway (see above).
+
+If the second reminder again results in no reaction within a week, try to
+contact a higher-level maintainer asking for advice: even busy maintainers by
+then should at least have sent some kind of acknowledgment.
+
+Remember to prepare yourself for a disappointment: maintainers ideally should
+react somehow to every issue report, but they are only obliged to fix those
+'issues of high priority' outlined earlier. So don't be too devastating if you
+get a  reply along the lines of 'thanks for the report, I have more important
+issues to deal with currently and won't have time to look into this for the
+foreseeable future'.
+
+It's also possible that after some discussion in the bug tracker or one a list
+nothing happens anymore and reminders don't help to motivate anyone to work out
+a fix. Such situations can be devastating, but is within the cards when if
+comes to Linux kernel development. This and sore other reasons for not getting
+help are explained in 'Why some issues won't get any reaction or remain unfixed
+after being reported' near the end of this document.
+
+Don't get devastated if you don't get any help or if the issue in the end does
+not get solved: as this the Linux kernel is FLOSS and thus you can still help
+yourself. Find others that are affected and try to team up with them to get the
+issue resolved. You for example can prepare a fresh report together that
+mentions how many you are and why this is something that in your option should
+get fixed. Maybe together you can also narrow down the root cause or the change
+that introduced a regression, which often makes developing a fix easier. And
+with a bit of luck there might be someone in the team that knows a bit about
+programming and might be able to write a fix.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
@@ -1064,48 +1244,6 @@ backported to it.
 How to report Linux kernel bugs
 ===============================
 
-
-Follow up
-=========
-
-Expectations for bug reporters
-------------------------------
-
-Linux kernel maintainers expect bug reporters to be able to follow up on
-bug reports.  That may include running new tests, applying patches,
-recompiling your kernel, and/or re-triggering your bug.  The most
-frustrating thing for maintainers is for someone to report a bug, and then
-never follow up on a request to try out a fix.
-
-That said, it's still useful for a kernel maintainer to know a bug exists
-on a supported kernel, even if you can't follow up with retests.  Follow
-up reports, such as replying to the email thread with "I tried the latest
-kernel and I can't reproduce my bug anymore" are also helpful, because
-maintainers have to assume silence means things are still broken.
-
-Expectations for kernel maintainers
------------------------------------
-
-Linux kernel maintainers are busy, overworked human beings.  Some times
-they may not be able to address your bug in a day, a week, or two weeks.
-If they don't answer your email, they may be on vacation, or at a Linux
-conference.  Check the conference schedule at https://LWN.net for more info:
-
-	https://lwn.net/Calendar/
-
-In general, kernel maintainers take 1 to 5 business days to respond to
-bugs.  The majority of kernel maintainers are employed to work on the
-kernel, and they may not work on the weekends.  Maintainers are scattered
-around the world, and they may not work in your time zone.  Unless you
-have a high priority bug, please wait at least a week after the first bug
-report before sending the maintainer a reminder email.
-
-The exceptions to this rule are regressions, kernel crashes, security holes,
-or userspace breakage caused by new kernel behavior.  Those bugs should be
-addressed by the maintainers ASAP.  If you suspect a maintainer is not
-responding to these types of bugs in a timely manner (especially during a
-merge window), escalate the bug to LKML and Linus Torvalds.
-
 Thank you!
 
 [Some of this is taken from Frohwalt Egerer's original linux-kernel FAQ]
-- 
2.26.2

