Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40602B0C08
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgKLSAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgKLR7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:22 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72A1C0613D1;
        Thu, 12 Nov 2020 09:59:22 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsO-00070q-I1; Thu, 12 Nov 2020 18:59:16 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 12/26] docs: reporting-bugs: tell users to disable DKMS et al.
Date:   Thu, 12 Nov 2020 18:58:49 +0100
Message-Id: <294b3d14ecf72be6cff9a592919bae8650732cb1.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203962;f7834ea2;
X-HE-SMSGID: 1kdGsO-00070q-I1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tell users to disable solutions like DKMS to make sure the kernel they
install later remains vanilla. The old text did not do that, but such
solutions were not that widespread back when it was written.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 8633f0976b00..5f6d3b2b55f9 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -602,6 +602,28 @@ reinstall the operating system as well as everything you need to restore the
 backup.
 
 
+Make sure your kernel doesn't get enhanced
+------------------------------------------
+
+    *Ensure your system does not enhance its kernels by building additional
+    kernel modules on-the-fly, which solutions like DKMS might be doing locally
+    without your knowledge.*
+
+Your kernel must be 'vanilla' when reporting an issue, but stops being pure as
+soon as it loads a kernel module not built from the sources used to compile the
+kernel image itself. That's why you need to ensure your Linux kernel stays
+vanilla by removing or disabling mechanisms like akmods and DKMS: those might
+build additional kernel modules automatically, for example when your boot into
+a newly installed Linux kernel the first time. Reboot after removing them and
+any modules they installed.
+
+Note, you might not be aware that your system is using one of these solutions:
+they often get set up silently when you install Nvidia's proprietary graphics
+driver, VirtualBox, or other software that requires a some support from a
+module not part of the Linux kernel. That why your might need to uninstall the
+packages with such software to get rid of any 3rd party kernel module.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.28.0

