Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028442B0BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgKLR7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgKLR7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:10 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA013C061A48;
        Thu, 12 Nov 2020 09:59:07 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsD-0006ue-C8; Thu, 12 Nov 2020 18:59:05 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 08/26] docs: reporting-bugs: make readers check the taint flag
Date:   Thu, 12 Nov 2020 18:58:45 +0100
Message-Id: <d21b7ead04852d3de7dd6892fe5e27aca1f345ff.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203947;764f585d;
X-HE-SMSGID: 1kdGsD-0006ue-C8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tell users early in the process to check the taint flag, as that will
prevent them from investing time into a report that might be worthless.
That way users for example will notice that the issue they face is in
fact caused by an add-on kernel module or and Oops that happened
earlier.

This approach has a downside: users will later have to check the flag
again with the mainline kernel the guide tells them to install. But that
is an acceptable trade-off here, as checking only takes a few seconds
and can easily prevent wasting time in useless testing and debugging.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---

= RFC =

Should "disable DKMS" come before this step? But then the backup step
right before that one would need to be moved as well, as disabling DKMS
can easily mix things up.
---
 Documentation/admin-guide/reporting-bugs.rst  | 69 +++++++++++++++++++
 Documentation/admin-guide/tainted-kernels.rst |  2 +
 2 files changed, 71 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index fdd79d99c18f..8ac491419bde 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -319,6 +319,75 @@ fatal error where the kernel stop itself) with a 'Oops' (a recoverable error),
 as the kernel remains running after the latter.
 
 
+Check 'taint' flag
+------------------
+
+    *Check if your kernel was 'tainted' when the issue occurred, as the event
+    that made the kernel set this flag might be causing the issue you face.*
+
+The kernel marks itself with a 'taint' flag when something happens that might
+lead to follow-up errors that look totally unrelated. The issue you face might
+be such an error if your kernel is tainted. That's why it's in your interest to
+rule this out early before investing more time into this process. This is the
+only reason why this step is here, as this process later will tell you to
+install the latest mainline kernel; you will need to check the taint flag again
+then, as that's when it matters because it's the kernel the report will focus
+on.
+
+On a running system is easy to check if the kernel tainted itself: if ``cat
+/proc/sys/kernel/tainted`` returns '0' then the kernel is not tainted and
+everything is fine. Checking that file is impossible in some situations; that's
+why the kernel also mentions the taint status when it reports an internal
+problem (a 'kernel bug'), a recoverable error (a 'kernel Oops') or a
+non-recoverable error before halting operation (a 'kernel panic'). Look near
+the top of the error messages printed when one of these occurs and search for a
+line starting with 'CPU:'. It should end with 'Not tainted' if the kernel was
+not tainted when it noticed the problem; it was tainted if you see 'Tainted:'
+followed by a few spaces and some letters.
+
+If your kernel is tainted, study
+:ref:`Documentation/admin-guide/tainted-kernels.rst <taintedkernels>` to find
+out why. Try to eliminate the reason. Often it's caused by one these three
+things:
+
+ 1. A recoverable error (a 'kernel Oops') occurred and the kernel tainted
+    itself, as the kernel knows it might misbehave in strange ways after that
+    point. In that case check your kernel or system log and look for a section
+    that starts with this::
+
+       Oops: 0000 [#1] SMP
+
+    That's the first Oops since boot-up, as the '#1' between the brackets shows.
+    Every Oops and any other problem that happens after that point might be a
+    follow-up problem to that first Oops, even if both look totally unrelated.
+    Rule this out by getting rid of the cause for the first Oops and reproducing
+    the issue afterwards. Sometimes simply restarting will be enough, sometimes a
+    change to the configuration followed by a reboot can eliminate the Oops. But
+    don't invest too much time into this at this point of the process, as the
+    cause for the Oops might already be fixed in the newer Linux kernel version
+    you are going to install later in this process.
+
+ 2. Your system uses a software that installs its own kernel modules, for
+    example Nvidia's proprietary graphics driver or VirtualBox. The kernel
+    taints itself when it loads such module from external sources (even if
+    they are Open Source): they sometimes cause errors in unrelated kernel
+    areas and thus might be causing the issue you face. You therefore have to
+    prevent those modules from loading when you want to report an issue to the
+    Linux kernel developers. Most of the time the easiest way to do that is:
+    temporarily uninstall such software including any modules they might have
+    installed. Afterwards reboot.
+
+ 3. The kernel also taints itself when it's loading a module that resides in
+    the staging tree of the Linux kernel source. That's a special area for
+    code (mostly drivers) that does not yet fulfill the normal Linux kernel
+    quality standards. When you report an issue with such a module it's
+    obviously okay if the kernel is tainted; just make sure the module in
+    question is the only reason for the taint. If the issue happens in an
+    unrelated area reboot and temporarily block the module from being loaded
+    by specifying ``foo.blacklist=1`` as kernel parameter (replace 'foo' with
+    the name of the module in question).
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index f718a2eaf1f6..04d8da1fc080 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -1,3 +1,5 @@
+.. _taintedkernels:
+
 Tainted kernels
 ---------------
 
-- 
2.28.0

