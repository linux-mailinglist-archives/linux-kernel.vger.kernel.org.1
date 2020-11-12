Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5596D2B0BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgKLR7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgKLR7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:32 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F1FC061A04;
        Thu, 12 Nov 2020 09:59:30 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsb-00076N-0q; Thu, 12 Nov 2020 18:59:29 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 23/26] docs: reporting-bugs: details for issues specific to stable and longterm
Date:   Thu, 12 Nov 2020 18:59:00 +0100
Message-Id: <0bb6bf554ac1f0c2a75631e6969a50dcd34c6b51.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203970;46a1d46b;
X-HE-SMSGID: 1kdGsb-00076N-0q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe what users have to do if they can't reproduce a problem with
mainline they want to see fixed in stable and longterm kernels. This is
separated from the main flow, as integrating it there would make it a
lot harder to follow.

Note users will only enter this section in two cases: (1) the issue was
fixed in mainline (on purpose or accidentally); (2) it's a regression
that never was present in mainline (for example due to a broken
backport).

Help users to differentiate between the two and explain how each of them
needs to be handled.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 187 +++++++++++++++++--
 1 file changed, 175 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index f455329063eb..ad9a5d896728 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -1292,24 +1292,187 @@ easier. And with a bit of luck there might be someone in the team that knows a
 bit about programming and might be able to write a fix.
 
 
+Details about reporting issues only occurring in older kernel version lines
+---------------------------------------------------------------------------
+
+This subsection provides details for steps you need to take if you could not
+reproduce your issue with a mainline kernel, but want to see it fixed in older
+version lines (aka stable and longterm kernels).
+
+Some fixes are too complex
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+    *Prepare yourself for the possibility that going through the next few steps
+    might not get the issue solved in older releases: the fix might be too big
+    or risky to get backported there.*
+
+Even small and seemingly obvious code-changes sometimes introduce new and
+totally unexpected problems. The maintainers of the stable and longterm kernels
+are very aware of that and thus only apply changes to these kernels that are
+:ref:`within rules outlined in Documentation/process/stable-kernel-rules.rst
+<stable_kernel_rules>`.
+
+Complex or risky changes for example do not qualify and thus only get applied
+to mainline. Other fixes are easy to get backported to the newest stable and
+longterm kernels, but too risky to integrate into older ones. So be aware the
+fix you are hoping for might be one of those that won be backported to the
+version line your care about. In that case you'll have no other choice then to
+live with the issue or switch to a newer Linux version, unless you want to
+patch the fix into your kernels yourself.
+
+Make sure the particular version line still gets support
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+    *Check if the kernel developers still maintain the Linux kernel version
+    line you care about: go to the front page of kernel.org and make sure it
+    mentions the latest release of the particular version line without an
+    '[EOL]' tag.*
+
+Most kernel version lines only get supported for about three months, as
+maintaining them longer is quite a lot of work. Hence, only one per year is
+chosen and gets supported for at least two years (often six). That's why you
+need to check if the kernel developers still support the version line you care
+for.
+
+Note, if kernel.org lists two 'stable' version lines on the front page, you
+should consider switching to the newer one and forget about the older one:
+support for it is likely to be abandoned soon. Then it will get a "end-of-life"
+(EOL) stamp. Version lines that reached that point still get mentioned on the
+kernel.org front page for a week or two, but are unsuitable for testing and
+reporting.
+
+Search stable mailing list
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+    *Check the archives of the Linux stable mailing list for existing reports.*
+
+Maybe the issue you face is already known and was fixed or is about to. Hence,
+`search the archives of the Linux stable mailing list
+<https://lore.kernel.org/stable/>`_ for reports about an issue like yours. If
+you find any matches, consider joining the discussion, unless the fix is
+already finished and scheduled to get applied soon.
+
+Reproduce issue with the newest release
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+    *Install the latest release from the particular version line as a vanilla
+    kernel. Ensure this kernel is not tainted and still shows the problem, as
+    the issue might have already been fixed there.*
+
+Before investing any more time in this process you want to check if the issue
+was already fixed in the latest release of version line you're interested in.
+This kernel needs to be vanilla and shouldn't be tainted before the issue
+happens, as detailed outlined already above in the process of testing mainline.
+
+Check code history and search for existing discussions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+    *Search the Linux kernel version control system for the change that fixed
+    the issue in mainline, as its commit message might tell you if the fix is
+    scheduled for backporting already. If you don't find anything that way,
+    search the appropriate mailing lists for posts that discuss such an issue
+    or peer-review possible fixes; then check the discussions if the fix was
+    deemed unsuitable for backporting. If backporting was not considered at
+    all, join the newest discussion, asking if it's in the cards.*
+
+In a lot of cases the issue you deal with will have happened with mainline, but
+got fixed there. The commit that fixed it would need to get backported as well
+to get the issue solved. That's why you want to search for it or any
+discussions abound it.
+
+ * First try to find the fix in the Git repository that holds the Linux kernel
+   sources. You can do this with the web interfaces `on kernel.org
+   <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/>`_
+   or its mirror `on GitHub <https://github.com/torvalds/linux>`_; if you have
+   a local clone you alternatively can search on the command line with ``git
+   log --grep=<pattern>``.
+
+   If you find the fix, look if the commit message near the end contains a
+   'stable tag' that looks like this:
+
+          Cc: <stable@vger.kernel.org> # 5.4+
+
+   If that's case the developer marked the fix safe for backporting to version
+   line 5.4 and later. Most of the time it's getting applied there within two
+   weeks, but sometimes it takes a bit longer.
+
+ * If the commit doesn't tell you anything or if you can't find the fix, look
+   again for discussions about the issue. Search the net with your favorite
+   internet search engine as well as the archives for the `Linux kernel
+   developers mailing list <https://lore.kernel.org/lkml/>`_. Also read the
+   section `Locate kernel area that causes the issue` above and follow the
+   instructions to find the subsystem in question: its bug tracker or mailing
+   list archive might have the answer you are looking for.
+
+ * If you see a proposed fix, search for it in the version control system as
+   outlined above, as the commit might tell you if a backport can be expected.
+
+   * Check the discussions for any indicators the fix might be too risky to get
+     backported to the version line you care about. If that's the case you have
+     to live with the issue or switch to the kernel version line where the fix
+     got applied.
+
+   * If the fix doesn't contain a stable tag and backporting was not discussed,
+     join the discussion: mention the version where you face the issue and that
+     you would like to see it fixed, if suitable.
+
+Check if it's a regression specific to stable or longterm kernels
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+    *Check if you're dealing with a regression that was never present in
+    mainline by installing the first release of the version line you care
+    about. If the issue doesn't show up with it, you basically need to report
+    the issue with this version like you would report a problem with mainline
+    (see above). This ideally includes a bisection followed by a search for
+    existing reports on the net; with the help of the subject and the two
+    relevant commit-ids. If that doesn't turn up anything, write the report; CC
+    or forward the report to the stable maintainers, the stable mailing list,
+    and those who authored the change. Include the shortened commit-id if you
+    found the change that causes it.*
+
+Sometimes you won't find anything in the previous step: the issue you face
+might have never occurred in mainline, as it is caused by some change that is
+incomplete or not correctly applied. To check this, install the first release
+from version line you care about, e.g., if you care about 5.4.x, install 5.4.
+
+If the issue doesn't show itself there, it's a regression specific to the
+particular version line. In that case you need to report it like an issue
+happening in mainline, like the last few steps in the main section in the above
+outline.
+
+One of them suggests doing a bisection, which you are strongly advised to do in
+this case. After finding the culprit, search the net for existing reports
+again: not only search for the exact subject and the commit-id (proper and
+shortened to twelve characters) of the change, but also for the commit-id
+(proper and shortened) mentioned as 'Upstream commit' in the commit message.
+
+Write the report; just keep a few specialties in mind: CC or forward the report
+to the stable maintainers, the stable mailing list, which the :ref:`MAINTAINERS
+<maintainers>` file mentions in the section "STABLE BRANCH". If you performed a
+successful bisection, CC the author of the change and include its subject and
+the shortened commit-id.
+
+Ask for advice
+~~~~~~~~~~~~~~
+
+    *One of the former steps should lead to a solution. If that doesn't work
+    out, ask the maintainers for the subsystem that seems to be causing the
+    issue for advice; CC the mailing list for the particular subsystem as well
+    as the stable mailing list.*
+
+If the previous three steps didn't get you closer to a solution there is only
+one option left: ask for advice. Do that in a mail you sent to the maintainers
+for the subsystem where the issue seems to have its roots; CC the mailing list
+for the subsystem as well as the stable mailing list the :ref:`MAINTAINERS
+<maintainers>` file mention in the section "STABLE BRANCH".
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
 .. Both sections are incomplete as of now and thus sometimes inconsistent.
 .. ###########################################################################
 
-Background
-==========
-
-The upstream Linux kernel maintainers only fix bugs for specific kernel
-versions.  Those versions include the current "release candidate" (or -rc)
-kernel, any "stable" kernel versions, and any "long term" kernels.
-
-Please see https://www.kernel.org/ for a list of supported kernels.  Any
-kernel marked with [EOL] is "end of life" and will not have any fixes
-backported to it.
-
-
 How to report Linux kernel bugs
 ===============================
 
-- 
2.28.0

