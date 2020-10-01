Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA4E27FBEC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbgJAIvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgJAIvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:51:42 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932CEC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 01:51:42 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kNu8e-0000gU-Dx; Thu, 01 Oct 2020 10:40:32 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 12/26] docs: reporting-bugs: tell users to disable DKMS et al.
Date:   Thu,  1 Oct 2020 10:39:33 +0200
Message-Id: <51574b968a9b78a5ce1056acdfa871d4a03d60c7.1601541165.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601541165.git.linux@leemhuis.info>
References: <cover.1601541165.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601542302;24105bda;
X-HE-SMSGID: 1kNu8e-0000gU-Dx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tell users to disable solutions like DKMS to make sure the mainline
kernel they have to install later remains vanilla. The old text did not
do that, but back when it was written these solutions were not that
widespread.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 05de4e0259cb..d96b21512c03 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -562,6 +562,27 @@ or reinstall the operating system as well as everything you need to restore the
 backup.
 
 
+Make sure your kernel doesn't get enhanced
+------------------------------------------
+
+    *Ensure your system does not enhance its kernels by building additional
+    kernel modules on-the-fly locally, which solutions like DKMS might be doing
+    without your knowledge.*
+
+Your kernel will stop being 'vanilla' as soon as it loads a kernel module not
+build from the sources used to compile the kernel image itself. That why you
+need to ensure your Linux kernel stays vanilla by removing or disabling
+mechanisms like akmods and DKMS: those might build additional kernel modules
+automatically, for example when your boot into a newly installed Linux kernel
+the first time. Reboot after removing them and any modules they installed.
+
+Note, you might not be aware that your system is using one of these solutions:
+they often get set up silently when you install Nvidias proprietary graphics
+driver, VirtualBox, or other Software that requires a some support from a module
+not part of the Linux kernel. Your package manager might thus force you to
+remove those, too.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.26.2

