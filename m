Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3225326CC3D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgIPUlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:41:11 -0400
Received: from smtprelay0054.hostedemail.com ([216.40.44.54]:52130 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726763AbgIPUk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 16:40:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4777718224D8A;
        Wed, 16 Sep 2020 20:40:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1437:1515:1535:1544:1605:1711:1730:1747:1777:1792:1801:1981:2194:2199:2393:2559:2562:2693:2914:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:6119:6261:7875:8603:8660:9010:10004:10848:11026:11232:11473:11658:11914:12043:12291:12296:12297:12438:12555:12895:12986:13148:13230:13894:14096:14181:14394:14721:21080:21451:21627:21795:21939:21990:30034:30051:30054:30069,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: quiet73_15119672711c
X-Filterd-Recvd-Size: 5476
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 16 Sep 2020 20:40:52 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH V3 1/8] sysfs: Add sysfs_emit and sysfs_emit_at to format sysfs output
Date:   Wed, 16 Sep 2020 13:40:38 -0700
Message-Id: <884235202216d464d61ee975f7465332c86f76b2.1600285923.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1600285923.git.joe@perches.com>
References: <cover.1600285923.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Output defects can exist in sysfs content using sprintf and snprintf.

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Add a generic sysfs_emit function that knows that the size of the
temporary buffer and ensures that no overrun is done.

Add a generic sysfs_emit_at function that can be used in multiple
call situations that also ensures that no overrun is done.

Validate the output buffer argument to be page aligned.
Validate the offset len argument to be within the PAGE_SIZE buf.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/filesystems/sysfs.rst |  8 ++---
 fs/sysfs/file.c                     | 55 +++++++++++++++++++++++++++++
 include/linux/sysfs.h               | 15 ++++++++
 3 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
index 5a3209a4cebf..004d490179f3 100644
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -241,12 +241,10 @@ Other notes:
   is 4096.
 
 - show() methods should return the number of bytes printed into the
-  buffer. This is the return value of scnprintf().
+  buffer.
 
-- show() must not use snprintf() when formatting the value to be
-  returned to user space. If you can guarantee that an overflow
-  will never happen you can use sprintf() otherwise you must use
-  scnprintf().
+- show() should only use sysfs_emit() or sysfs_emit_at() when formatting
+  the value to be returned to user space.
 
 - store() should return the number of bytes used from the buffer. If the
   entire buffer has been used, just return the count argument.
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index eb6897ab78e7..96d0da65e088 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/seq_file.h>
+#include <linux/mm.h>
 
 #include "sysfs.h"
 
@@ -707,3 +708,57 @@ int sysfs_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t kgid)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sysfs_change_owner);
+
+/**
+ *	sysfs_emit - scnprintf equivalent, aware of PAGE_SIZE buffer.
+ *	@buf:	start of PAGE_SIZE buffer.
+ *	@fmt:	format
+ *	@...:	optional arguments to @format
+ *
+ *
+ * Returns number of characters written to @buf.
+ */
+int sysfs_emit(char *buf, const char *fmt, ...)
+{
+	va_list args;
+	int len;
+
+	if (WARN(!buf || offset_in_page(buf),
+		 "invalid sysfs_emit: buf:%p\n", buf))
+		return 0;
+
+	va_start(args, fmt);
+	len = vscnprintf(buf, PAGE_SIZE, fmt, args);
+	va_end(args);
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(sysfs_emit);
+
+/**
+ *	sysfs_emit_at - scnprintf equivalent, aware of PAGE_SIZE buffer.
+ *	@buf:	start of PAGE_SIZE buffer.
+ *	@at:	offset in @buf to start write in bytes
+ *		@at must be >= 0 && < PAGE_SIZE
+ *	@fmt:	format
+ *	@...:	optional arguments to @fmt
+ *
+ *
+ * Returns number of characters written starting at &@buf[@at].
+ */
+int sysfs_emit_at(char *buf, int at, const char *fmt, ...)
+{
+	va_list args;
+	int len;
+
+	if (WARN(!buf || offset_in_page(buf) || at < 0 || at >= PAGE_SIZE,
+		 "invalid sysfs_emit_at: buf:%p at:%d\n", buf, at))
+		return 0;
+
+	va_start(args, fmt);
+	len = vscnprintf(buf + at, PAGE_SIZE - at, fmt, args);
+	va_end(args);
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(sysfs_emit_at);
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 34e84122f635..2caa34c1ca1a 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -329,6 +329,10 @@ int sysfs_groups_change_owner(struct kobject *kobj,
 int sysfs_group_change_owner(struct kobject *kobj,
 			     const struct attribute_group *groups, kuid_t kuid,
 			     kgid_t kgid);
+__printf(2, 3)
+int sysfs_emit(char *buf, const char *fmt, ...);
+__printf(3, 4)
+int sysfs_emit_at(char *buf, int at, const char *fmt, ...);
 
 #else /* CONFIG_SYSFS */
 
@@ -576,6 +580,17 @@ static inline int sysfs_group_change_owner(struct kobject *kobj,
 	return 0;
 }
 
+__printf(2, 3)
+static inline int sysfs_emit(char *buf, const char *fmt, ...)
+{
+	return 0;
+}
+
+__printf(3, 4)
+static inline int sysfs_emit_at(char *buf, int at, const char *fmt, ...)
+{
+	return 0;
+}
 #endif /* CONFIG_SYSFS */
 
 static inline int __must_check sysfs_create_file(struct kobject *kobj,
-- 
2.26.0

