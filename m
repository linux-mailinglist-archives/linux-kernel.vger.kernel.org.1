Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BFF1E5A22
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 10:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgE1IAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 04:00:50 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:3526 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbgE1IAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:00:49 -0400
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Peter Enderborg <peter.enderborg@sony.com>
Subject: [PATCH] debugfs: Add mount restriction option
Date:   Thu, 28 May 2020 10:00:31 +0200
Message-ID: <20200528080031.24149-1-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEG-SpamProfiler-Analysis: v=2.3 cv=VdGJw2h9 c=1 sm=1 tr=0 a=Jtaq2Av1iV2Yg7i8w6AGMw==:117 a=sTwFKg_x9MkA:10 a=z6gsHLkEAAAA:8 a=Cn-iF0jY07eQLtR_xsEA:9 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since debugfs include sensitive information it need to be treated
carefully. But it also has many very useful debug functions for userspace.
With this option we can have same configuration for system with
need of debugfs and a way to turn it off. It is needed new
kernel command line parameter to be activated.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 fs/debugfs/inode.c | 17 ++++++++++++++++-
 lib/Kconfig.debug  | 10 ++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index b7f2e971ecbc..bde37dab77e0 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -786,10 +786,25 @@ bool debugfs_initialized(void)
 }
 EXPORT_SYMBOL_GPL(debugfs_initialized);
 
+static int allow_debugfs;
+
+static int __init debugfs_kernel(char *str)
+{
+	if (str && !strcmp(str, "true"))
+		allow_debugfs = true;
+
+	return 0;
+
+}
+early_param("debugfs", debugfs_kernel);
+
 static int __init debugfs_init(void)
 {
 	int retval;
-
+#ifdef CONFIG_DEBUG_FS_MOUNT_RESTRICTED
+	if (!allow_debugfs)
+		return -EPERM;
+#endif
 	retval = sysfs_create_mount_point(kernel_kobj, "debug");
 	if (retval)
 		return retval;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 21d9c5f6e7ec..d3a3338740d2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -443,6 +443,16 @@ config DEBUG_FS
 
 	  If unsure, say N.
 
+config DEBUG_FS_MOUNT_RESTRICTED
+	bool "Debug Filesystem mount restricted"
+	depends on DEBUG_FS
+	help
+	  This is an additional restriction for mounting debugfs. It allows
+	  the kernel to have debugfs compiled, but requires that kernel command
+	  line has a debugfs parameter to register as a filesystem.
+
+	  If unsure, say N.
+
 source "lib/Kconfig.kgdb"
 
 source "lib/Kconfig.ubsan"
-- 
2.26.2

