Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E488B27FC04
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbgJAI4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgJAI4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:56:24 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2990C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 01:56:23 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kNu7x-0006b9-LH; Thu, 01 Oct 2020 10:39:49 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 04/26] docs: reporting-bugs: step-by-step guide for issues in stable & longterm
Date:   Thu,  1 Oct 2020 10:39:25 +0200
Message-Id: <b81c54734a767f7da9ec68fae6b82ea0a8c96011.1601541165.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601541165.git.linux@leemhuis.info>
References: <cover.1601541165.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601542583;2224f1d1;
X-HE-SMSGID: 1kNu7x-0006b9-LH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle stable and longterm kernels in a subsection, as dealing with them
directly in the main part of the step-by-step guide turned out to make
it messy and hard to follow: it looked a bit like code with a large
amount of if-then-else section to handle special cases, which made the
default code-flow hard to understand.

Yet again each step will later be repeated in a reference section and
described in more detail.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 49 ++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 203df36af55f..e0a6f4328e87 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -156,6 +156,55 @@ After these preparations you'll now enter the main part:
    yourself, if you don't get any help or if it is unsatisfying.
 
 
+Reporting issues only occurring in older kernel version lines
+-------------------------------------------------------------
+
+This section is for you, if you tried the latest mainline kernel as outlined
+above, but failed to reproduce your issue there; at the same time you want to
+see the issue fixed in older version lines or a vendor kernel that's regularly
+rebased on new stable or longterm releases. If that case follow these steps:
+
+ * Prepare yourself for the possibility that going through the next few steps
+   might not get the issue solved in older releases: the fix might be too big or
+   risky to get backported there.
+
+ * Check if the kernel developers still maintain the Linux kernel version line
+   you care about: go to `the front-page of kernel.org <https://kernel.org>`_
+   and make sure it mentions the latest release of the particular version line
+   without an '[EOL]' tag.
+
+ * Check the `archives of the Linux stable mailing list
+   <https://lore.kernel.org/stable/>`_  for existing reports.
+
+ * Install the latest release from the particular version line as a vanilla
+   kernel. Ensure this kernel is not tainted and still shows the problem, as the
+   issue might have already been fixed there.
+
+ * Search the Linux kernel version control system for the change that fixed
+   the issue in mainline, as its commit message might tell you if the fix is
+   scheduled for backporting already. If you don't find anything that way,
+   search the appropriate mailing lists for posts that discuss such an issue or
+   peer-review possible fixes. That might lead you to the commit with the fix
+   or tell you if it's unsuitable for backporting. If backporting was not
+   considered at all, join the newest discussion, asking if its in the cards.
+
+ * Check if you're dealing with a regression that was never present in
+   mainline by installing the first release of the version line you care about.
+   If the issue doesn't show up with it, you basically need to report the issue
+   with this version like you would report a problem with mainline (see above).
+   This ideally includes a bisection followed by a search for existing reports
+   on the net; with the help of the subject and the two relevant commit-ids. If
+   that doesn't turn up anything, write the report; CC or forward the report to
+   the stable maintainers, the stable mailing list, and those that authored the
+   change. Include the shortened commit-id if you found the change that causes
+   it.
+
+ * One of the former steps should lead to a solution. If that doesn't work out,
+   ask the maintainers for the subsystem that seems to be causing the issue for
+   advice; CC the mailing list for the particular subsystem as well as the
+   stable mailing list.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.26.2

