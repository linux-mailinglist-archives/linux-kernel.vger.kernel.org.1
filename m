Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BC92B0BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgKLR72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgKLR7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:18 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395BCC0613D4;
        Thu, 12 Nov 2020 09:59:18 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsN-00070q-Us; Thu, 12 Nov 2020 18:59:16 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 09/26] docs: reporting-bugs: help users find the proper place for their report
Date:   Thu, 12 Nov 2020 18:58:46 +0100
Message-Id: <a5d67f2ac5ecdbcf855c3f6816ab1f254078a87d.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203958;24c9afe5;
X-HE-SMSGID: 1kdGsN-00070q-Us
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
v2:
- partly rewritten after some comments from Randy

= RFC =

I think we should create mailing list like
'linux-issues@vger.kernel.org' and tell users here to always CC it when
reporting issues. Then they'd have one place they can search in case
they want to check for existing reports (at least for issues reported by
mail).

Note, this section tells users to always CC LKML. These days it's a kind
of "catch-all" list anyway (which nearly nobody reads). So it IMHO makes
sense to go "all in" and make people send their reports here, too, as
everything (reports, fixes, ...) then can be found in one place (at
least for all reports sent by mail and all subsystems that CC LKML).
---
 Documentation/admin-guide/reporting-bugs.rst | 187 ++++++++++++++-----
 1 file changed, 142 insertions(+), 45 deletions(-)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 8ac491419bde..9e0e9b2ba27b 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -388,6 +388,148 @@ things:
     the name of the module in question).
 
 
+Locate kernel area that causes the issue
+----------------------------------------
+
+    *Locate the driver or kernel subsystem that seems to be causing the issue.
+    Find out how and where its developers expect reports. Note: most of the
+    time this won't be bugzilla.kernel.org, as issues typically need to be sent
+    by mail to a maintainer and a public mailing list.*
+
+It's crucial to send your report to the right people, as the Linux kernel is a
+big project and most of its developers are only familiar with a small subset of
+it. Quite a few programmers for example only care for just one driver, for
+example one for a WiFi chip; its developer likely will only have small or no
+knowledge about the internals of remote or unrelated "subsystems", like the TCP
+stack, the PCIe/PCI subsystem, memory management or file systems.
+
+Problem is: the Linux kernel lacks a central bug tracker where you can simply
+file your issue and make it reach the developers that need to know about it.
+That's why you have to find the right place and way to report issues yourself.
+You can do that with the help of a script (see below), but it mainly targets
+kernel developers and experts. For everybody else the MAINTAINERS file is the
+better place.
+
+How to read the MAINTAINERS file
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+To illustrate how to use the :ref:`MAINTAINERS <maintainers>` file, lets assume
+the WiFi in your Laptop suddenly misbehaves after updating the kernel. In that
+case it's likely an issue in the WiFi driver. Obviously it could also be some
+code it builds upon, but unless you suspect something like that stick to the
+driver. If it's really something else, the driver's developers will get the
+right people involved.
+
+Sadly, there is no way to check which code is driving a particular hardware
+component that is both universal and easy.
+
+In case of a problem with the WiFi driver you for example might want to look at
+the output of ``lspci -k``, as it lists devices on the PCI/PCIe bus and the
+kernel module driving it::
+
+       [user@something ~]$ lspci -k
+       [...]
+       3a:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter (rev 32)
+         Subsystem: Bigfoot Networks, Inc. Device 1535
+         Kernel driver in use: ath10k_pci
+         Kernel modules: ath10k_pci
+       [...]
+
+But this approach won't work if your WiFi chip is connected over USB or some
+other internal bus. In those cases you might want to check your WiFi manager or
+the output of ``ip link``. Look for the name of the problematic network
+interface, which might be something like 'wlp58s0'. This name can be used like
+this to find the module driving it::
+
+       [user@something ~]$ realpath --relative-to=/sys/module/ /sys/class/net/wlp58s0/device/driver/module
+       ath10k_pci
+
+In case tricks like these don't bring you any further, try to search the
+internet on how to narrow down the driver or subsystem in question. And if you
+are unsure which it is: just try your best guess, somebody will help you if you
+guessed poorly.
+
+Once you know the driver or subsystem, you want to search for it in the
+MAINTAINERS file. In the case of 'ath10k_pci' you won't find anything, as the
+name is too specific. Sometimes you will need to search on the net for help;
+but before doing so, try a somewhat shorted or modified name when searching the
+MAINTAINERS file, as then you might find something like this::
+
+       QUALCOMM ATHEROS ATH10K WIRELESS DRIVER
+       Mail:          A. Some Human <shuman@example.com>
+       Mailing list:  ath10k@lists.infradead.org
+       Status:        Supported
+       Web-page:      https://wireless.wiki.kernel.org/en/users/Drivers/ath10k
+       SCM:           git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
+       Files:         drivers/net/wireless/ath/ath10k/
+
+Note: the line description will be abbreviations, if you read the plain
+MAINTAINERS file found in the root of the Linux source tree. 'Mail:' for
+example will be 'M:', 'Mailing list:' will be 'L', and 'Status:' will be 'S:'.
+A section near the top of the file explains these and other abbreviations.
+
+First look at the line 'Status'. Ideally it should be 'Supported' or
+'Maintained'. If it states 'Obsolete' then you are using some outdated approach
+that was replaced by a newer solution you need to switch to. Sometimes the code
+only has someone who provides 'Odd Fixes' when feeling motivated. And with
+'Orphan' you are totally out of luck, as nobody takes care of the code anymore.
+That only leaves these options: arrange yourself to live with the issue, fix it
+yourself, or find a programmer somewhere willing to fix it.
+
+After checking the status, look for a line starting with 'bugs:': it will tell
+you where to find a subsystem specific bug tracker to file your issue. The
+example above does not have such a line. That is the case for most sections, as
+Linux kernel development is completely driven by mail. Very few subsystems use
+a bug tracker, and only some of those rely on bugzilla.kernel.org.
+
+In this and many other cases you thus have to look for lines starting with
+'Mail:' instead. Those mention the name and the email addresses for the
+maintainers of the particular code. Also look for a line starting with 'Mailing
+list:', which tells you the public mailing list where the code is developed.
+Your report later needs to go by mail to those addresses. Additionally, for all
+issue reports sent by email, make sure to add the Linux Kernel Mailing List
+(LKML) <linux-kernel@vger.kernel.org> to CC. Don't omit either of the mailing
+lists when sending your issue report by mail later! Maintainers are busy people
+and might leave some work for other developers on the subsystem specific list;
+and LKML is important to have one place where all issue reports can be found.
+
+Finding the maintainers with the help of a script
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For people that have the Linux sources at hand there is a second option to find
+the proper place to report: the script 'scripts/get_maintainer.pl' which tries
+to find all people to contact. It queries the MAINTAINERS file and needs to be
+called with a path to the source code in question. For drivers compiled as
+module if often can be found with a command like this::
+
+       $ modinfo ath10k_pci | grep filename | sed 's!/lib/modules/.*/kernel/!!; s!filename:!!; s!\.ko\(\|\.xz\)!!'
+       drivers/net/wireless/ath/ath10k/ath10k_pci.ko
+
+Pass parts of this to the script::
+
+       $ ./scripts/get_maintainer.pl -f drivers/net/wireless/ath/ath10k*
+       Some Human <shuman@example.com> (supporter:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER)
+       Another S. Human <asomehuman@example.com> (maintainer:NETWORKING DRIVERS)
+       ath10k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER)
+       linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS))
+       netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
+       linux-kernel@vger.kernel.org (open list)
+
+Don't sent your report to all of them. Send it to the maintainers, which the
+script calls "supporter:"; additionally CC the most specific mailing list for
+the code as well as the Linux Kernel Mailing List (LKML). In this case you thus
+would need to send the report to 'Some Human <shuman@example.com>' with
+'ath10k@lists.infradead.org' and 'linux-kernel@vger.kernel.org' in CC.
+
+Note: in case you cloned the Linux sources with git you might want to call
+``get_maintainer.pl`` a second time with ``--git``. The script then will look
+at the commit history to find which people recently worked on the code in
+question, as they might be able to help. But use these results with care, as it
+can easily send you in a wrong direction. That for example happens quickly in
+areas rarely changed (like old or unmaintained drivers): sometimes such code is
+modified during tree-wide cleanups by developers that do not care about the
+particular driver at all.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
@@ -410,51 +552,6 @@ How to report Linux kernel bugs
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
2.28.0

