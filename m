Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D1B2CA7A1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403932AbgLAQAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:00:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391853AbgLAQAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:00:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEEB320857;
        Tue,  1 Dec 2020 16:00:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kk84T-002R5W-J9; Tue, 01 Dec 2020 11:00:05 -0500
Message-ID: <20201201160005.473464239@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Dec 2020 10:58:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 03/12] tools/bootconfig: Align the bootconfig applied initrd image size to 4
References: <20201201155835.647858317@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Align the bootconfig applied initrd image size to 4. To fill the gap,
the bootconfig command uses null characters in between the bootconfig
data and the footer. This will expands the footer size but don't change
the checksum.
Thus the block image of the initrd file with bootconfig is as follows.

[initrd][bootconfig][(pad)][size][csum]["#BOOTCONFIG\n"]

Link: https://lkml.kernel.org/r/160576522046.320071.8550680670010950634.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/bootconfig.h          |  3 ++
 tools/bootconfig/main.c             | 57 +++++++++++++++++------------
 tools/bootconfig/test-bootconfig.sh |  6 ++-
 3 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 9903088891fa..2696eb0fc149 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -12,6 +12,9 @@
 
 #define BOOTCONFIG_MAGIC	"#BOOTCONFIG\n"
 #define BOOTCONFIG_MAGIC_LEN	12
+#define BOOTCONFIG_ALIGN_SHIFT	2
+#define BOOTCONFIG_ALIGN	(1 << BOOTCONFIG_ALIGN_SHIFT)
+#define BOOTCONFIG_ALIGN_MASK	(BOOTCONFIG_ALIGN - 1)
 
 /* XBC tree node */
 struct xbc_node {
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index a0733cbb3c49..4a445b6304bb 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -337,12 +337,13 @@ static int delete_xbc(const char *path)
 
 static int apply_xbc(const char *path, const char *xbc_path)
 {
+	char *buf, *data, *p;
+	size_t total_size;
 	struct stat stat;
+	const char *msg;
 	u32 size, csum;
-	char *buf, *data;
+	int pos, pad;
 	int ret, fd;
-	const char *msg;
-	int pos;
 
 	ret = load_xbc_file(xbc_path, &buf);
 	if (ret < 0) {
@@ -352,13 +353,12 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	size = strlen(buf) + 1;
 	csum = checksum((unsigned char *)buf, size);
 
-	/* Prepare xbc_path data */
-	data = malloc(size + 8);
+	/* Backup the bootconfig data */
+	data = calloc(size + BOOTCONFIG_ALIGN +
+		      sizeof(u32) + sizeof(u32) + BOOTCONFIG_MAGIC_LEN, 1);
 	if (!data)
 		return -ENOMEM;
-	strcpy(data, buf);
-	*(u32 *)(data + size) = size;
-	*(u32 *)(data + size + 4) = csum;
+	memcpy(data, buf, size);
 
 	/* Check the data format */
 	ret = xbc_init(buf, &msg, &pos);
@@ -399,24 +399,35 @@ static int apply_xbc(const char *path, const char *xbc_path)
 		pr_err("Failed to get the size of %s\n", path);
 		goto out;
 	}
-	ret = write(fd, data, size + 8);
-	if (ret < size + 8) {
+
+	/* To align up the total size to BOOTCONFIG_ALIGN, get padding size */
+	total_size = stat.st_size + size + sizeof(u32) * 2 + BOOTCONFIG_MAGIC_LEN;
+	pad = ((total_size + BOOTCONFIG_ALIGN - 1) & (~BOOTCONFIG_ALIGN_MASK)) - total_size;
+	size += pad;
+
+	/* Add a footer */
+	p = data + size;
+	*(u32 *)p = size;
+	p += sizeof(u32);
+
+	*(u32 *)p = csum;
+	p += sizeof(u32);
+
+	memcpy(p, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
+	p += BOOTCONFIG_MAGIC_LEN;
+
+	total_size = p - data;
+
+	ret = write(fd, data, total_size);
+	if (ret < total_size) {
 		if (ret < 0)
 			ret = -errno;
 		pr_err("Failed to apply a boot config: %d\n", ret);
-		if (ret < 0)
-			goto out;
-		goto out_rollback;
-	}
-	/* Write a magic word of the bootconfig */
-	ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
-	if (ret < BOOTCONFIG_MAGIC_LEN) {
-		if (ret < 0)
-			ret = -errno;
-		pr_err("Failed to apply a boot config magic: %d\n", ret);
-		goto out_rollback;
-	}
-	ret = 0;
+		if (ret >= 0)
+			goto out_rollback;
+	} else
+		ret = 0;
+
 out:
 	close(fd);
 	free(data);
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index d295e406a756..baed891d0ba4 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -9,6 +9,7 @@ else
   TESTDIR=.
 fi
 BOOTCONF=${TESTDIR}/bootconfig
+ALIGN=4
 
 INITRD=`mktemp ${TESTDIR}/initrd-XXXX`
 TEMPCONF=`mktemp ${TESTDIR}/temp-XXXX.bconf`
@@ -59,7 +60,10 @@ echo "Show command test"
 xpass $BOOTCONF $INITRD
 
 echo "File size check"
-xpass test $new_size -eq $(expr $bconf_size + $initrd_size + 9 + 12)
+total_size=$(expr $bconf_size + $initrd_size + 9 + 12 + $ALIGN - 1 )
+total_size=$(expr $total_size / $ALIGN)
+total_size=$(expr $total_size \* $ALIGN)
+xpass test $new_size -eq $total_size
 
 echo "Apply command repeat test"
 xpass $BOOTCONF -a $TEMPCONF $INITRD
-- 
2.28.0


