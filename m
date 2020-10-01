Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD39827FBEA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbgJAIvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgJAIvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:51:38 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49FAC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 01:51:38 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kNu8J-0000Ew-Cq; Thu, 01 Oct 2020 10:40:11 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 09/26] docs: reporting-bugs: help users find the proper place for their report
Date:   Thu,  1 Oct 2020 10:39:30 +0200
Message-Id: <d612f512f2e4eb00e1e80674783c1ffb5e463f82.1601541165.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601541165.git.linux@leemhuis.info>
References: <cover.1601541165.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601542298;6e8d511c;
X-HE-SMSGID: 1kNu8J-0000Ew-Cq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it obvious that bugzilla.kernel.org most of the time is the wrong
place to file a report, as it's not working well. Instead, tell users
how to read the MAINTAINERS file to find the proper place for their
report. Also mention ./scripts/get_maintainer.pl. Sadly this is only
available for users that have the sourced at hand; in an ideal world
somebody would build a web-service around of this.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---

= RFC =

This section tells users to always CC LKML. I placed this in the text here for
now as a way to force a general discussion about this, as it would be way easier
if users had one place where they could search for existing reports; maybe it
should be the same place where fixes are sent to, as then the single search
would find those, too.

That might mean "LKML", which these days afaics is a kind of "catch-all" ml
anyway (which nearly nobody reads). So it might make sense to go "all in" and
make people send their reports here, too. But TBH I'm a bit unsure myself if
that's the right approach. Maybe creating a mailing list like
'linux-issues@vger.kernel.org' would be best (and while at it maybe also
linux-regressions@vger.kernel.org).
---
 Documentation/admin-guide/reporting-bugs.rst | 166 ++++++++++++++-----
 1 file changed, 121 insertions(+), 45 deletions(-)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 61b6592ddf74..3e9923c9650e 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -370,6 +370,127 @@ from being loaded by specifying ``foo.blacklist=1`` as kernel parameter (replace
 'foo' with the name of the module in question).
 
 
+Locate kernel area that causes the issue
+----------------------------------------
+
+    *Locate the driver or kernel subsystem that seems to be causing the issue.
+    Find out how and where its developers expect reports. Note: most of the time
+    this won't be bugzilla.kernel.org, as issues typically need to be sent by
+    mail to a maintainer and a public mailing list.*
+
+It's crucial to send your report to the right people, as the Linux kernel is big
+project and most of its developers are only familiar with a very small part of
+it. Quite a few developers only care for just one driver; some of them also look
+after the various infrastructure building blocks the driver is building upon,
+but sometimes other maintainers take care of those. These people talk with each
+other, but work mostly separately from each other. But most of them don't care
+about file systems or memory management, which yet other people take care of.
+
+Problem is: the Linux kernel lacks a central bug tracker that all maintainers
+use, so you have to find the right way and place to report issues yourself. One
+way to do that: look at the `MAINTAINERS file in the Linux kernel sources
+<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/MAINTAINERS>`_,
+which lists the points of contact for the various parts of the kernel. The file
+contains a long text with sections that among others will mention who maintains
+the various parts of the kernel and the development mailing list for that code.
+
+How to decode the maintainers file
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+To illustrate how to use the file lets assume the Wi-Fi in your Laptop suddenly
+misbehaves after updating the kernel. In that case it's likely an issue in the
+Wi-Fi driver; it could also be some code it builds upon: the Wi-Fi subsystem,
+the TCP/IP stack, which are all part of the Network subsystem. But unless you
+suspect the culprit lies there stick to the driver. Thus run the command
+``lspci -k`` to tell which kernel driver manages a particular hardware::
+
+       [user@something ~]$ lspci -k
+       [...]
+       3a:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter (rev 32)
+         Subsystem: Bigfoot Networks, Inc. Device 1535
+         Kernel driver in use: ath10k_pci
+         Kernel modules: ath10k_pci
+       [...]
+
+The line starting with 'Kernel modules:' tells us the hardware is driven by a
+module called ´´ath10k_pci´´. If you now search for 'ath10k' in the MAINTAINER
+file you will find something like this::
+
+       QUALCOMM ATHEROS ATH10K WIRELESS DRIVER
+       M:      Some Human <shuman@example.com>
+       L:      ath10k@lists.infradead.org
+       W:      http://wireless.kernel.org/en/users/Drivers/ath10k
+       T:      git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
+       S:      Supported
+       F:      drivers/net/wireless/ath/ath10k/
+
+First look out for line starting with 'S:', to make sure the code is
+'Supported', 'Maintained', or at least has someone that provides 'Odd Fixes' if
+the person has a spare minute. If it states 'Obsolete' then you are using some
+outdated code and should switch to the newer approach the kernel offers. If it
+says 'Orphan' you are out of luck: nobody takes care of the code anymore, hence
+there is nobody to send a report to. You need to fix this yourself or look
+somewhere else to find someone that is willing to help.
+
+Now look for a line starting with 'B:', as that will tell you where to find a
+bug tracker to file your issue. The example does not have such a line; that
+is the case for most sections, as Linux kernel development is completely driven
+by mail and only a few developers use a bug tracker.
+
+Thus, if there is no 'B:' look for lines staring with 'M:'. Those mention the
+name and the email addresses for the maintainers of the particular code. Also
+look for one starting with 'L:', which tells you the public mailing list where
+the code is developed. Your report later needs to go by mail to those addresses.
+Don't omit the mailing list when sending your issue report by mail! Maintainers
+are busy people and might leave some work for other developers on the list.
+
+Additionally, for all issue report send by mail make sure to also CC the Linux
+Kernel Mailing List <linux-kernel@vger.kernel.org>, commonly known as LKML. That
+won't increase visibility, as almost no kernel developer reads that list anymore
+due to its high traffic. But it will ensure the report can be found with a
+search in the LKML archives.
+
+If your curious what the other letters stand for search the MAINTAINER file
+near the top for a section 'Descriptions of section entries and preferred
+order'.
+
+Finding the maintainers with the help of a script
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For people that have the Linux sources at hand there is an even better way to
+find the proper place to report, as it contains a script that tries to find all
+people to contact. This script will need a path to the source code in question.
+For drivers if often can be found with a command like this::
+
+       $ modinfo ath10k_pci | grep filename | sed 's!/lib/modules/.*/kernel/!!; s!filename:!!; s!\.ko\(\|\.xz\)!!'
+       drivers/net/wireless/ath/ath10k/ath10k_pci
+
+Pass that part to the script::
+
+       $ ./scripts/get_maintainer.pl -f drivers/net/wireless/ath/ath10k*
+       Some Human <shuman@example.com> (supporter:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER)
+       Another S. Human <asomehuman@example.com> (odd fixer:NETWORKING DRIVERS)
+       ath10k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER)
+       linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS))
+       netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
+       linux-kernel@vger.kernel.org (open list)
+
+Don't sent the initial report to all of them, stick to the maintainer and the
+mailing list initially ('Some Human <shuman@example.com>' and
+'ath10k@lists.infradead.org'). But you might want to contact the others later
+in case the maintainer is not reacting appropriately, as outlined in a later
+section of this document.
+
+A note for developer and experts: in case you cloned the Linux sources with git
+you might want to add ``--git`` when calling ``get_maintainer.pl``. The script
+then will look at the git commit history to find which people recently worked
+on the code in question. That sometimes gives a better result, but sometimes
+sends people in a wrong direction. The latter for example happens with code
+that is changed rarely (like old or unmaintained drivers), as such code is
+sometimes modified during tree-wide cleanups by developers that do not care
+about the particular code at all. Hence, use this option with care.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
@@ -392,51 +513,6 @@ How to report Linux kernel bugs
 ===============================
 
 
-Identify the problematic subsystem
-----------------------------------
-
-Identifying which part of the Linux kernel might be causing your issue
-increases your chances of getting your bug fixed. Simply posting to the
-generic linux-kernel mailing list (LKML) may cause your bug report to be
-lost in the noise of a mailing list that gets 1000+ emails a day.
-
-Instead, try to figure out which kernel subsystem is causing the issue,
-and email that subsystem's maintainer and mailing list.  If the subsystem
-maintainer doesn't answer, then expand your scope to mailing lists like
-LKML.
-
-
-Identify who to notify
-----------------------
-
-Once you know the subsystem that is causing the issue, you should send a
-bug report.  Some maintainers prefer bugs to be reported via bugzilla
-(https://bugzilla.kernel.org), while others prefer that bugs be reported
-via the subsystem mailing list.
-
-To find out where to send an emailed bug report, find your subsystem or
-device driver in the MAINTAINERS file.  Search in the file for relevant
-entries, and send your bug report to the person(s) listed in the "M:"
-lines, making sure to Cc the mailing list(s) in the "L:" lines.  When the
-maintainer replies to you, make sure to 'Reply-all' in order to keep the
-public mailing list(s) in the email thread.
-
-If you know which driver is causing issues, you can pass one of the driver
-files to the get_maintainer.pl script::
-
-     perl scripts/get_maintainer.pl -f <filename>
-
-If it is a security bug, please copy the Security Contact listed in the
-MAINTAINERS file.  They can help coordinate bugfix and disclosure.  See
-:ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>` for more information.
-
-If you can't figure out which subsystem caused the issue, you should file
-a bug in kernel.org bugzilla and send email to
-linux-kernel@vger.kernel.org, referencing the bugzilla URL.  (For more
-information on the linux-kernel mailing list see
-http://vger.kernel.org/lkml/).
-
-
 Tips for reporting bugs
 -----------------------
 
-- 
2.26.2

