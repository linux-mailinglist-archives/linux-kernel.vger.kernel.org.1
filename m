Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04AA27FC09
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbgJAI4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731783AbgJAI4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:56:34 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80024C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 01:56:34 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kNu8I-0000Ew-Of; Thu, 01 Oct 2020 10:40:11 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 08/26] docs: reporting-bugs: make readers check the taint flag
Date:   Thu,  1 Oct 2020 10:39:29 +0200
Message-Id: <eed27c4faa31d98bd37db18ba2ae90f1767c7102.1601541165.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601541165.git.linux@leemhuis.info>
References: <cover.1601541165.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601542594;d14af6ef;
X-HE-SMSGID: 1kNu8I-0000Ew-Of
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

Should "disable DKMS" come before this step? But then the backup step right
before that one would need to be moved as well, as disabling DKMS can mix things
up.
---
 Documentation/admin-guide/reporting-bugs.rst  | 59 +++++++++++++++++++
 Documentation/admin-guide/tainted-kernels.rst |  2 +
 2 files changed, 61 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 430a0c3ee0ad..61b6592ddf74 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -311,6 +311,65 @@ fatal error where the kernels stop itself) with a 'Oops' (a recoverable error),
 as the kernel remains running after an 'Oops'.
 
 
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
+install the latest mainline kernel and check its taint flag, as that's the
+kernel the report will be mainly about.
+
+On a running system is easy to check if the kernel tainted itself: it's not
+tainted if ``cat /proc/sys/kernel/tainted`` returns '0'. Checking that file is
+impossible in some situations, that's why the kernel also mentions the taint
+status when it reports an internal problem (a 'kernel bug'), a recoverable
+error (a 'kernel Oops') or a non-recoverable error before halting operation (a
+'kernel panic'). Look near the top of the error messages printed when one of
+these occurs and search for a line starting with 'CPU:'. It should end with
+'Not tainted' if the kernel was not tainted beforehand; it was tainted if you
+see 'Tainted:' followed by a few spaces and some letters.
+
+If your kernel is tainted study
+:ref:`Documentation/admin-guide/tainted-kernels.rst <taintedkernels>` to find
+out why and try to eliminate the reason. Often it's because a recoverable error
+(a 'kernel Oops') occurred and the kernel tainted itself, as the kernel knows
+it might misbehave in strange ways after that point. In that case check your
+kernel or system log and look for a section that starts with this::
+
+       Oops: 0000 [#1] SMP
+
+That's the first Oops since boot-up, as the '#1' between the brackets shows.
+Every Oops and any other problem that happen after that point might be a
+follow-up problem to that first Oops, even if they look totally unrelated. Try
+to rule this out by getting rid of that Oops and reproducing the issue
+afterwards. Sometimes simply restarting will be enough, sometimes a change to
+the configuration followed by a reboot can eliminate the Oops. But don't invest
+too much time into this at this point of the process, as the cause for the Oops
+might already be fixed in the newer Linux kernel version you are going to
+install later in this process.
+
+Quite a few kernels are also tainted because an unsuitable kernel modules was
+loaded. This for example is the case if you use Nvidias proprietary graphics
+driver, VirtualBox, or other software that installs its own kernel modules: you
+will have to remove these modules and reboot the system, as they might in fact
+be causing the issue you face.
+
+The kernel also taints itself when it's loading a module that resists in the
+staging tree of the Linux kernel source. That's a special area for code (mostly
+drivers) that does not yet fulfill the normal Linux kernel quality standards.
+When you report an issue with such a module it's obviously okay if the kernel is
+tainted, just make sure the module in question is the only reason for the taint.
+If the issue happens in an unrelated area reboot and temporary block the module
+from being loaded by specifying ``foo.blacklist=1`` as kernel parameter (replace
+'foo' with the name of the module in question).
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index abf804719890..2900f477f42f 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -1,3 +1,5 @@
+.. _taintedkernels:
+
 Tainted kernels
 ---------------
 
-- 
2.26.2

