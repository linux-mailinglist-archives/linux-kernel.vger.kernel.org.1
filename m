Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A4A2B0C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgKLSBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgKLR7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:18 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45890C0613D6;
        Thu, 12 Nov 2020 09:59:18 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsO-00070q-VI; Thu, 12 Nov 2020 18:59:17 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 14/26] docs: reporting-bugs: make users write notes, one for each issue
Date:   Thu, 12 Nov 2020 18:58:51 +0100
Message-Id: <d6b04b9f03272fdcc947fbab0ea941a237fd612a.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203958;24c9afe5;
X-HE-SMSGID: 1kdGsO-00070q-VI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tell users to write some rough notes how to reproduce the issue. They
will need those notes soon once they have to reproduce the issue with a
fresh kernel later in the process. At the same time the notes can serve
as basis for the report later.

While at it point out that each report should focus on one issue, as
that is a good time for it: it will make the notes more straight forward
if the reader deal with multiple issues at once.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 36 +++++++++++++++-----
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 234731cd0c78..981ddd5a0646 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -659,6 +659,33 @@ should minimize it:
    like a kernel regression.
 
 
+Document how to reproduce issue
+-------------------------------
+
+    *Write down coarsely how to reproduce the issue. If you deal with multiple
+    issues at once, create separate notes for each of them and make sure they
+    work independently on a freshly booted system. That's needed, as each issue
+    needs to get reported to the kernel developers separately, unless they are
+    strongly entangled.*
+
+If you deal with multiple issues at once, you'll have to report each of them
+separately, as they might be handled by different developers. Describing
+various issues in one report also makes it quite difficult for others to tear
+it apart. Hence, only combine issues in one report if they are very strongly
+entangled.
+
+Additionally, during the reporting process you will have to test if the issue
+happens with other kernel versions. Therefore, it will make your work easier if
+you know exactly how to reproduce an issue quickly on a freshly booted system.
+
+Note: it's often fruitless to report issues that only happened once, as they
+might be caused by a bit flip due to cosmic radiation. That's why you should
+try to rule that out by reproducing the issue before going further. Feel free
+to ignore this advice if you are experienced enough to tell a one-time error
+due to faulty hardware apart from a kernel issue that rarely happens and thus
+is hard to reproduce.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
@@ -681,15 +708,6 @@ How to report Linux kernel bugs
 ===============================
 
 
-Tips for reporting bugs
------------------------
-
-It's REALLY important to report bugs that seem unrelated as separate email
-threads or separate bugzilla entries.  If you report several unrelated
-bugs at once, it's difficult for maintainers to tease apart the relevant
-data.
-
-
 Gather information
 ------------------
 
-- 
2.28.0

