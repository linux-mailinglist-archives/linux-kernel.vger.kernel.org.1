Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8D2F070D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 13:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbhAJMLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 07:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbhAJMLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 07:11:21 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7AAC061786;
        Sun, 10 Jan 2021 04:10:40 -0800 (PST)
Received: from ip4d149f6e.dynamic.kabel-deutschland.de ([77.20.159.110] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kyZYI-0000V2-Jj; Sun, 10 Jan 2021 13:10:34 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 (RFC)] docs: discourage users from using bugzilla.kernel.org
Date:   Sun, 10 Jan 2021 13:10:33 +0100
Message-Id: <20210110121033.130504-1-linux@leemhuis.info>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1610280640;753466df;
X-HE-SMSGID: 1kyZYI-0000V2-Jj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bugtracker on kernel.org is not working very well and might be a
disservice to the community, as discussed on the maintainers summit 2017
and explained below in detail. For most of the kernel it was never the
preferred place to report issues anyway, as the MAINTAINERS file and the
recently added text Documentation/admin-guide/reporting-issues.rst show.

Hence, remove the two points in the kernel's English documentation that
suggest submitting all sorts of bugs in bugzilla.kernel.org. That gets
rid of known inconsistencies with
Documentation/admin-guide/reporting-issues.rst, which is the reason for
one 'this needs further discussion' warning in there. Hence, remove that
warning as well to make the approach it describes the official one. A
few files in the Documentation continue referring to bugzilla.kernel.org
and sometimes even suggest filing issues there, but those references are
fine for now (see below for details).

Why bugzilla.kernel.org isn't working well
==========================================

Find below the good, the bad and the ugly aspects of
bugzilla.kernel.org.

The good
--------

Bugzilla.kernel.org is useful tool sometimes:

* About 15 of the ~2225 section entries in Linux's MAINTAINERS file
  point to bugzilla.kernel.org as the official place to report bugs.
  from a brief look it seems the developers of those areas take care of
  issues filed in the bug tracker; sometimes they even file bugs there
  themselves to keep track of things.

* For a few other subsystems the bug tracker also works as intended: the
  maintainer gets reports and comments by mail. Some act upon those.
  Gregkh is one of those, who often replies with standard text like "you
  should report this to your distro" or "Please report this to the
  following mailing list instead".

* The bug tracker sometimes brings users together: someone files a bug
  which other users find and join; the users sometimes help each other
  and occasionally even manage to get the right developers involved,
  even in cases where those don't get a copy of the report by mail.

* It's a place where users can upload files they don't want or can't
  send to mailing lists.

The bad
-------

The list of products and components in bugzilla.kernel.org is widely
incomplete, outdated in sometimes plain wrong. The same is true for the
list of default assignees and the email addresses to which newly filed
reports get send to.

This leads to several problems. To see some of them one needs to look
closer at the products and components, for example by browsing the web
(https://bugzilla.kernel.org/describecomponents.cgi) or by using the
REST interface to get it as JSON
(https://bugzilla.kernel.org//rest/product?type=accessible [to get the
email addresses one needs to provide login credentials as well]).

That JSON output will list about 20 products with nearly 200 components.

* The majority of the ~2225 section entries and subsystems listed in
  the MAINTAINERS file have no corresponding entry in bugzilla, hence
  it's not a tool to contact the people users need to contact in case
  of problems.

* About 66 of those ~200 components will assign bugs to email addresses
  that look valid, but 125 of them end with @kernel-bugs.osdl.org or
  @kernel-bugs.kernel.org. Those domains do not exist anymore, mails
  sent there bounce ('Unrouteable address'). It's possible that the
  server might be rewriting those domain names and nevertheless
  delivers new reports and comments by mails to some human; but it
  seems more like they never get mailed to anyone and thus just linger
  in the database; no wonder quite a few of bugs filed against such
  components never get a single reply (see below).

The ugly
--------

Bugzilla.kernel.org might look like the official place to report all
sorts of kernel bugs, but it was never. That itself would be just bad,
what makes it ugly is this:

The front page doesn't make this aspect obvious and not even point to
Documentation/admin-guide/reporting-bugs.rst to help those that want to
properly report a bug. Only the FAQ mentions it, albeit only indirectly:
'The subsystem maintainers in kernel tracker are volunteers to help
track bugs in an area they are interested in. Sometimes they are the
same person as on kernel.org sometimes they are not. There are still
some categories with no maintainers so more volunteers are needed.'

It looks like those volunteers were never found; the outdated list of
components and products (see 'the bad' above) also shows that the
volunteers seem to not really take care of things.

In the end that's the reasons why quite a few (a lot?) reports never get
a reply from someone. During a randomly selected 2 week window at the
end of November 2020(¹) there were 60 public bugs and a bit more than
half of them by the end of the year never got a single comment by anyone
except maybe the reporter.

(¹) bugs created between 2020-11-21 and 2020-12-05 23:59:59; that's
about one week before the merge window of 5.11 started and 2 1/2 weeks
before Christmas

Who's not to blame
------------------

For the sake of this commit it's irrelevant at all who's to blame for
the state of bugzilla.kernel.org; it for sure was set up with good
intentions, it just didn't work out very well in the end. The situations
just needs to be improved, ideally quickly; blaming it on someone isn't
helping at all.

But there is one aspect that should be noted here: The situation can't
be blamed on the kernel.org admins. They are doing a good job at keeping
the bugzilla.kernel.org up and the bugzilla codebase up2date. But as
admins it's not their job to maintain the list of products and
components.

Why not fix it?
---------------

It's well known for years now that bugzilla.kernel.org is not working
that well, but nobody ever stepped up to improve the situation. Maybe
this commit gets something rolling. If that's the case this change can
be reverted. For now the change is an improvement that was agreed on
during the maintainers summit 2017 in a session discussion regression
tracking (https://lwn.net/Articles/738216/).

Apart from this change there is one more change planned to improve the
situation with bugzilla.kernel.org: discuss with the admins how to make
it more obvious to users when to use the bug tracker, and when to avoid
it; the text that does this will obviously link to
Documentation/admin-guide/reporting-issues.rst, which is one of the
reasons why it's designed to be understandable for newcomers.

Where bugzilla.kernel.org still gets mentioned
==============================================

After this commit, a few places in the kernel's documentation continue
to mention bugzilla.kernel.org:

* admin-guide/reporting-issues.rst -- it discourages people from filing
  issues there, but mention it's better to file a bug there than not
reporting it at all (that part is inspired from a similar section in
admin-guide/reporting-bugs.rst). The file also mentions the bug tracker
as a good place to upload big files which should be keep available for
years (dmesg output, config files, …).

* admin-guide/reporting-bugs.rst -- it still mentions bugzilla in a
  broader sense a few times. There is also one place where it suggests
  filing any sort of issues in bugzilla.kernel.org, which will be
  addresses by a different patch, as it touches another aspect that and
  thus better discussed separately. The whole file will vanish anyway
  once Documentation/admin-guide/reporting-issues.rst is considered
  fully ready.

* admin-guide/cifs/todo.rst -- just mentions it as a place to look for
  'known bugs', which seems fine, as the CIFS maintainers are among
  those that seem to keep an eye on bugzilla.kernel.org.

* bpf/bpf_devel_QA.rst -- discourages people from filing issues there.

* process/code-of-conduct-interpretation.rst -- just mentions it as an
  example for 'bug tracking tools' with isn't particular concerning.

* sound/alsa-configuration.rst and sound/hd-audio/notes.rst -- they
  mention it as a place to file bugs. Looks like at least some are
  looked at, thus leave this as it is for now.

* A few translations still mention the bug tracker; they hopefully
  notice this change and follow suit.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
v1 (RFC): 

- Just sent to a 'small' audience (linux-docs, Jon, Randy, LKML); once
  it got some comments the plan is to send this to a bigger audience,
  including Gregkh (who's listed as maintainer for
  Documentation/process/howto.rst) and ksummit-discuss (which is the
  best way to contact the core developers; and it's a follow up to a
  maintainer summit discussion anyway).

Ciao, Thorsten

---
 Documentation/admin-guide/reporting-bugs.rst  |  7 +++----
 .../admin-guide/reporting-issues.rst          | 20 -------------------
 Documentation/process/howto.rst               | 20 +++++++++----------
 3 files changed, 13 insertions(+), 34 deletions(-)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 409fa91d7495..284de0314b5d 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -48,11 +48,10 @@ Identify who to notify
 ----------------------
 
 Once you know the subsystem that is causing the issue, you should send a
-bug report.  Some maintainers prefer bugs to be reported via bugzilla
-(https://bugzilla.kernel.org), while others prefer that bugs be reported
-via the subsystem mailing list.
+bug report. Most of the maintainers prefer them to be reported by mail,
+but a few of them rely on bug trackers.
 
-To find out where to send an emailed bug report, find your subsystem or
+To find out where to send or file your bug report, find your subsystem or
 device driver in the MAINTAINERS file.  Search in the file for relevant
 entries, and send your bug report to the person(s) listed in the "M:"
 lines, making sure to Cc the mailing list(s) in the "L:" lines.  When the
diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 5cbb1b5f4a52..147b9bb7d320 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -526,26 +526,6 @@ example above does not have such a line. That is the case for most sections, as
 Linux kernel development is completely driven by mail. Very few subsystems use
 a bug tracker, and only some of those rely on bugzilla.kernel.org.
 
-
-.. note::
-
-   FIXME: The old text took a totally different approach to bugzilla.kernel.org,
-   as it mentions it as the place to file issue for people that don't known how
-   to contact the appropriate people. The new one mentions it rarely; and when
-   it does like here, it warns users that it's often the wrong place to go.
-
-   This approach was chosen as the main author of this document noticed quite a
-   few users (or even a lot?) get no reply to the bugs they file in bugzilla.
-   That's kind of expected, as quite a few (many? most?) of the maintainers
-   don't even get notified when reports for their subsystem get filed there. And
-   not getting a single reply to report is something that is just annoying for
-   users and might make them angry. Improving bugzilla.k.o would be an option,
-   but on the kernel and maintainers summit 2017 it was agreed on to first go
-   this route (sorry it took so long): it's easier to achieve and less
-   controversial, as putting additional burden on already overworked maintainers
-   is unlikely to get well received.
-
-
 In this and many other cases you thus have to look for lines starting with
 'Mail:' instead. Those mention the name and the email addresses for the
 maintainers of the particular code. Also look for a line starting with 'Mailing
diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index 7a5c105e34d4..5fd695a0b363 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -342,16 +342,10 @@ Adventurous testers are very welcome to runtime-test the linux-next.
 Bug Reporting
 -------------
 
-https://bugzilla.kernel.org is where the Linux kernel developers track kernel
-bugs.  Users are encouraged to report all bugs that they find in this
-tool.  For details on how to use the kernel bugzilla, please see:
-
-	https://bugzilla.kernel.org/page.cgi?id=faq.html
-
 The file 'Documentation/admin-guide/reporting-issues.rst' in the main kernel
-source directory has a good template for how to report a possible kernel bug,
-and details what kind of information is needed by the kernel developers to help
-track down the problem.
+source directory describes how to report a possible kernel bug, and details
+what kind of information is needed by the kernel developers to help track
+down the problem.
 
 
 Managing bug reports
@@ -364,7 +358,13 @@ improve your skills, and other developers will be aware of your presence.
 Fixing bugs is one of the best ways to get merits among other developers,
 because not many people like wasting time fixing other people's bugs.
 
-To work in the already reported bug reports, go to https://bugzilla.kernel.org.
+To work on already reported bug reports, find a subsystem you are interested in
+and check existing reports for one where you want to help. You find such
+reports in the archives of the place where reports for the particular subsystem
+need to be sent to, which is listed in the MAINTAINERS file; often it will be a
+mailing list, rarely a bugtracker. You may also consider checking
+https://bugzilla.kernel.org. Only a handful of kernel subsystems actually use it
+actively, but bugs for other subsystems get filed there nevertheless.
 
 
 Mailing lists
-- 
2.29.2

