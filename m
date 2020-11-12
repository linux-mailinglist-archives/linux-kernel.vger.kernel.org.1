Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AE82B0C05
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgKLR7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgKLR7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:18 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10252C0613D1;
        Thu, 12 Nov 2020 09:59:18 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsO-00070q-Od; Thu, 12 Nov 2020 18:59:16 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 13/26] docs: reporting-bugs: point out the environment might be causing issue
Date:   Thu, 12 Nov 2020 18:58:50 +0100
Message-Id: <f4512b613b341b14f25814b6c9e5937955c266ff.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203958;24c9afe5;
X-HE-SMSGID: 1kdGsO-00070q-Od
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Help users to avoid a few pitfalls, as they might be the real reason why
the kernel is acting up somehow.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 35 ++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 5f6d3b2b55f9..234731cd0c78 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -624,6 +624,41 @@ module not part of the Linux kernel. That why your might need to uninstall the
 packages with such software to get rid of any 3rd party kernel module.
 
 
+Ensure a healthy environment
+----------------------------
+
+    *Make sure it's not the kernel's surroundings that are causing the issue
+    you face.*
+
+Problems that look a lot like a kernel issue are sometimes caused by build or
+runtime environment. It's hard to rule out that problem completely, but you
+should minimize it:
+
+ * Use proven tools when building your kernel, as bugs in the compiler or the
+   binutils can cause the resulting kernel to misbehave.
+
+ * Ensure your computer components run within their design specifications;
+   that's especially important for the main processor, the main memory, and the
+   motherboard. Therefore, stop undervolting or overclocking when facing a
+   potential kernel issue.
+
+ * Try to make sure it's not faulty hardware that is causing your issue. Bad
+   main memory for example can result in a multitude of issues that will
+   manifest itself in problems looking like kernel issues.
+
+ * If you're dealing with a filesystem issue, you might want to check the file
+   system in question with ``fsck``, as it might be damaged in a way that leads
+   to unexpected kernel behavior.
+
+ * When dealing with a regression, make sure it's not something else that
+   changed in parallel to updating the kernel. The problem for example might be
+   caused by other software that was updated at the same time. It can also
+   happen that a hardware component coincidentally just broke when you rebooted
+   into a new kernel for the first time. Updating the systems BIOS or changing
+   something in the BIOS Setup can also lead to problems that on look a lot
+   like a kernel regression.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.28.0

