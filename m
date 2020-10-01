Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D9C27FBF0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbgJAIvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731673AbgJAIvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:51:47 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5640AC0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 01:51:47 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kNu8e-0000gU-Ju; Thu, 01 Oct 2020 10:40:32 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 13/26] docs: reporting-bugs: point out the environment might be causing issue
Date:   Thu,  1 Oct 2020 10:39:34 +0200
Message-Id: <6dab906efb915c6cd6733df525b1f3da3753c4b4.1601541165.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601541165.git.linux@leemhuis.info>
References: <cover.1601541165.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601542307;80bb04dc;
X-HE-SMSGID: 1kNu8e-0000gU-Ju
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Help users to avoid a few pitfalls, as they might be the real reason why
the kernel is acting up somehow.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index d96b21512c03..2292b79cf462 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -583,6 +583,40 @@ not part of the Linux kernel. Your package manager might thus force you to
 remove those, too.
 
 
+Ensure a healthy environment
+----------------------------
+
+    *Make sure it's not the kernels surroundings that are causing the issue you
+    face.*
+
+Problems that look a lot like a kernel issue are sometimes caused by build
+or runtime environment. It's hard to rule out that problem completely, but you
+should minimize it:
+
+ * Use proven tools when building your kernel, as bugs in the compiler or the
+   binutils can cause the resulting kernel to misbehave.
+
+ * Ensure your computer components runs within their design specifications;
+   that's especially important for the main processor, the main memory, and the
+   motherboard. Therefore, stop overclocking when facing a potential kernel
+   issue.
+
+ * Try to make sure it's not faulty hardware that is causing your issue. Bad
+   main memory for example can result in a multitude of issues that will
+   manifest itself in problems looking like kernel issues.
+
+ * If you're dealing with a filesystem issue, you might want to check the file
+   system in question with ``fsck`` before trying to reproduce it again.
+
+ * When dealing with a regression, make sure it's not something else that
+   changed in parallel to updating the kernel. The problem for example might be
+   caused by another software that was updated at the same time. It can also
+   happen that a hardware component coincidentally just broke when you rebooted
+   into a new kernel for the first time. Updating the systems BIOS or changing
+   something in the BIOS Setup can also lead to problems that on the first sight
+   look like a regression.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.26.2

