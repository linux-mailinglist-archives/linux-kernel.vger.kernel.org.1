Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D3927FBB7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbgJAIlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731641AbgJAIlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:41:22 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C28AC0613D0;
        Thu,  1 Oct 2020 01:41:21 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kNu9P-0000un-VR; Thu, 01 Oct 2020 10:41:20 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 20/26] docs: reporting-bugs: instructions for handling regressions
Date:   Thu,  1 Oct 2020 10:39:41 +0200
Message-Id: <7071ace5086f39ceaa2b1ffcc3bc774f362b4aa7.1601541165.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601541165.git.linux@leemhuis.info>
References: <cover.1601541165.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601541682;1781a039;
X-HE-SMSGID: 1kNu9P-0000un-VR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe what users will have to do if they deal with a regression.
Point out that bisection is really important.

While at it explicitly mention the .config files for the newer kernel
needs to be similar to the old kernel, as that's an important detail
quite a few people seem to miss sometimes.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/bug-bisect.rst     |  2 +
 Documentation/admin-guide/reporting-bugs.rst | 53 ++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/admin-guide/bug-bisect.rst b/Documentation/admin-guide/bug-bisect.rst
index 59567da344e8..38d9dbe7177d 100644
--- a/Documentation/admin-guide/bug-bisect.rst
+++ b/Documentation/admin-guide/bug-bisect.rst
@@ -1,3 +1,5 @@
+.. _bugbisect:
+
 Bisecting a bug
 +++++++++++++++
 
diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index e1219e56979f..71c49347c544 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -792,6 +792,59 @@ sometimes needs to get decoded to be readable, which is explained in
 admin-guide/bug-hunting.rst.
 
 
+Special care for regressions
+----------------------------
+
+    *If your problem is a regression, try to narrow down when the issue was
+    introduced as much as possible.*
+
+Linux lead developer Linus Torvalds insists that the Linux kernel never
+worsens, that's why he deems regressions as unacceptable and wants to see them
+fixed quickly. That's why changes that introduced a regression are often
+promptly reverted if the issue they cause can't get solved quickly any other
+way. Reporting a regression is thus a bit like playing a kind of trump card to
+get something quickly fixed. But for that to happen the culprit needs to be
+known. Normally it's up to the reporter to track down the change that's causing
+the regression, as maintainers often won't have the time or setup at hand to
+reproduce it themselves.
+
+To find the culprit there is a process called 'bisection' which the document
+:ref:`Documentation/admin-guide/bug-bisect.rst <bugbisect>` describes in detail.
+That process will often require you to build about ten to twenty kernel images
+and test each of them for the issue. Yes, that takes some time, but 't worry,
+it works a lot quicker than most people assume. Thanks to a 'binary search' this
+will lead you to the one commit in the source code management system that's
+causing the regression. Once you found it, serch the net for the subject of the
+change, its commit id and the shortened commit id (the first 12 characters of
+the commit id). This will lead you to exisiting reports about it, if there are
+any.
+
+Note, a bisection needs a bit of know-how, which not everyone has, and quite a
+bit of effort, which not everyone is willing to invest. Nevertheless, it's
+highly recommended performing a bisection yourself. If you really can't or don't
+want to go down that route at least find out which mainline kernel introduced
+the regression. If something for example breaks when switching from 5.5.15 to
+5.8.4, then try at least all the mainline releases in that area (5.6, 5.7 and
+5.8) to check when it first showed up. Unless you're trying to find a regression
+in a stable or longterm kernel, avoid testing versions which number has three
+sections (5.6.12, 5.7.8), as that can lead to confusion and might make your
+testing useless. Then feel free to go further in the reporting process. But
+keep in mind: if the developers will be able to help depend on the issue at
+hand. Sometimes the developers from the report will be able to recognize want
+went wrong and fix it; other times they might be unable to help unless the
+reporter performs a bisection.
+
+When dealing with regressions make sure the issue you face is really caused by
+the kernel and not by something else, as outlined above already.
+
+In the whole process keep in mind: an issue only qualifies as regression if the
+older and the newer kernel got build with a similar configuration. The best way
+to archive this: copy the configuration file (``.config``) from the old kernel
+freshly to each newer kernel version you try. Afterwards run
+``make oldnoconfig`` to adjust it for the needs of the new version without
+enabling any new feature, as those are allowed to cause regressions.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.26.2

