Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2BE2207A2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 10:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbgGOIma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 04:42:30 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:5421 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730341AbgGOIm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:42:26 -0400
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Peter Enderborg <peter.enderborg@sony.com>
Subject: [PATCH 2/2] debugfs: Add access restriction option
Date:   Wed, 15 Jul 2020 10:42:07 +0200
Message-ID: <20200715084207.7639-3-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715084207.7639-1-peter.enderborg@sony.com>
References: <20200617133738.6631-1-peter.enderborg@sony.com>
 <20200715084207.7639-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
X-SEG-SpamProfiler-Analysis: v=2.3 cv=CszBjUwD c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=_RQrkK6FrEwA:10 a=z6gsHLkEAAAA:8 a=VrXpv0pnXvPFombwIUYA:9 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since debugfs include sensitive information it need to be treated
carefully. But it also has many very useful debug functions for userspace.
With this option we can have same configuration for system with
need of debugfs and a way to turn it off. This gives a extra protection
for exposure on systems where user-space services with system
access are attacked.

It is controlled by a configurable default value that can be override
with a kernel command line parameter. (debugfs=)

It can be on or off, but also internally on but not seen from user-space.
This no-fs mode do not register a debugfs as filesystem, but client can
register their parts in the internal structures. This data can be readed
with a debugger or saved with a crashkernel. When it is off clients
get EPERM error when accessing the functions for registering their
components.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 .../admin-guide/kernel-parameters.txt         | 14 +++++++
 fs/debugfs/inode.c                            | 37 +++++++++++++++++++
 fs/debugfs/internal.h                         | 14 +++++++
 lib/Kconfig.debug                             | 32 ++++++++++++++++
 4 files changed, 97 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad81c79..805aa2e58491 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -827,6 +827,20 @@
 			useful to also enable the page_owner functionality.
 			on: enable the feature
 
+	debugfs=    	[KNL] This parameter enables what is exposed to userspace
+			and debugfs internal clients.
+			Format: { on, no-fs, off }
+			on: 	All functions are enabled.
+			no-fs: 	Filesystem is not registered but kernel clients can
+			        access APIs and a crashkernel can be used to read
+				its content. There is nothing to mount.
+			off: 	Filesystem is not registered and clients
+			        get a -EPERM as result when trying to register files
+				or directories within debugfs.
+				This is equilivant of the runtime functionality if
+				debugfs was not enabled in the kernel at all.
+			Default value is set in build-time with a kernel configuration.
+
 	debugpat	[X86] Enable PAT debugging
 
 	decnet.addr=	[HW,NET]
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index b7f2e971ecbc..eee937c49a80 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -35,6 +35,7 @@
 static struct vfsmount *debugfs_mount;
 static int debugfs_mount_count;
 static bool debugfs_registered;
+static unsigned int debugfs_allow = DEFAULT_DEBUGFS_ACCESS_BITS;
 
 /*
  * Don't allow access attributes to be changed whilst the kernel is locked down
@@ -266,6 +267,9 @@ static struct dentry *debug_mount(struct file_system_type *fs_type,
 			int flags, const char *dev_name,
 			void *data)
 {
+	if (!(debugfs_allow & DEBUGFS_ALLOW_API))
+		return ERR_PTR(-EPERM);
+
 	return mount_single(fs_type, flags, data, debug_fill_super);
 }
 
@@ -311,6 +315,9 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	struct dentry *dentry;
 	int error;
 
+	if (!(debugfs_allow & DEBUGFS_ALLOW_API))
+		return ERR_PTR(-EPERM);
+
 	pr_debug("creating file '%s'\n", name);
 
 	if (IS_ERR(parent))
@@ -385,6 +392,11 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	if (IS_ERR(dentry))
 		return dentry;
 
+	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
+		failed_creating(dentry);
+		return ERR_PTR(-EPERM);
+	}
+
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create file '%s'\n",
@@ -541,6 +553,11 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	if (IS_ERR(dentry))
 		return dentry;
 
+	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
+		failed_creating(dentry);
+		return ERR_PTR(-EPERM);
+	}
+
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create directory '%s'\n",
@@ -583,6 +600,11 @@ struct dentry *debugfs_create_automount(const char *name,
 	if (IS_ERR(dentry))
 		return dentry;
 
+	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
+		failed_creating(dentry);
+		return ERR_PTR(-EPERM);
+	}
+
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create automount '%s'\n",
@@ -786,10 +808,25 @@ bool debugfs_initialized(void)
 }
 EXPORT_SYMBOL_GPL(debugfs_initialized);
 
+static int __init debugfs_kernel(char *str)
+{
+	if (str && !strcmp(str, "on"))
+		debugfs_allow = DEBUGFS_ALLOW_API | DEBUGFS_ALLOW_FS;
+	if (str && !strcmp(str, "no-fs"))
+		debugfs_allow = DEBUGFS_ALLOW_API;
+	if (str && !strcmp(str, "off"))
+		debugfs_allow = 0;
+
+	return 0;
+}
+early_param("debugfs", debugfs_kernel);
 static int __init debugfs_init(void)
 {
 	int retval;
 
+	if (!(debugfs_allow & DEBUGFS_ALLOW_FS))
+		return -EPERM;
+
 	retval = sysfs_create_mount_point(kernel_kobj, "debug");
 	if (retval)
 		return retval;
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index 034e6973cead..9cd3be76359a 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -29,4 +29,18 @@ struct debugfs_fsdata {
  */
 #define DEBUGFS_FSDATA_IS_REAL_FOPS_BIT BIT(0)
 
+/* Access BITS */
+#define DEBUGFS_ALLOW_API	BIT(0)
+#define DEBUGFS_ALLOW_FS	BIT(1)
+
+#ifdef CONFIG_DEBUG_FS_ACCESS_ALL
+#define DEFAULT_DEBUGFS_ACCESS_BITS (DEBUGFS_ALLOW_FS | DEBUGFS_ALLOW_API)
+#endif
+#ifdef CONFIG_DEBUG_FS_ACCESS_NO_FS
+#define DEFAULT_DEBUGFS_ACCESS_BITS (DEBUGFS_ALLOW_API)
+#endif
+#ifdef CONFIG_DEBUG_FS_ACCESS_NONE
+#define DEFAULT_DEBUGFS_ACCESS_BITS (0)
+#endif
+
 #endif /* _DEBUGFS_INTERNAL_H_ */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210d70a1..b609ad7c1343 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -476,6 +476,38 @@ config DEBUG_FS
 
 	  If unsure, say N.
 
+choice
+	prompt "Debugfs default access"
+	depends on DEBUG_FS
+	default DEBUG_FS_ACCESS_ALL
+	help
+	  This select the default access restricions for debugfs.
+	  It can be overridden with kernel command line option
+	  debugfs=[on,no-fs,off] The restrictions apply for API access
+	  and filesystem registration. .
+
+config DEBUG_FS_ACCESS_ALL
+       bool "Access normal"
+       help
+	  No restrictions applies. Both API and filesystem registration
+	  is on. This is the normal default operation.
+
+config DEBUG_FS_ACCESS_NO_FS
+       bool "Do not register debugfs as filesystem"
+       help
+	 The API is open but filesystem not loaded. Client can still do
+	 their work and readed with debug tools that does not need
+	 debugfs filesystem.
+
+config DEBUG_FS_ACCESS_NONE
+       bool "No access"
+       help
+	  Access is off. Clients get EPERM when trying to create nodes in
+	  debugfs tree and debugfs is not registred as an filesystem.
+	  Client can then back-off or continue without debugfs access.
+
+endchoice
+
 source "lib/Kconfig.kgdb"
 
 source "lib/Kconfig.ubsan"
-- 
2.17.1

