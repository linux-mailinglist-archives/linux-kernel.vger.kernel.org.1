Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DA42B8B22
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 06:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgKSFxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 00:53:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgKSFxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 00:53:44 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 622FC22363;
        Thu, 19 Nov 2020 05:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605765223;
        bh=39mvky1pjBMpRWaWTJznnEEk0T7AH5exQgXhvYbXGCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lH2FyZHl1mcNITllo2UrqFpRnsaMOewsIi/AeOLv1kfZM4bKd2zEBb1BZ+Alm2dds
         pM1LeYfiqpJSAwMyuK4CQ3+IVCtIQt1MN9QSpSVX/vpZ5M1IFj/ZKVk7BS3gN8j1Sp
         oL5h8fUj3e1MaLwr8sNzVmksGr7oI7BlWmVMR0ZY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 3/4] tools/bootconfig: Align the bootconfig applied initrd image size to 4
Date:   Thu, 19 Nov 2020 14:53:40 +0900
Message-Id: <160576522046.320071.8550680670010950634.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160576519277.320071.14260402851742732108.stgit@devnote2>
References: <160576519277.320071.14260402851742732108.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the bootconfig applied initrd image size to 4. To fill the gap,
the bootconfig command uses null characters in between the bootconfig
data and the footer. This will expands the footer size but don't change
the checksum.
Thus the block image of the initrd file with bootconfig is as follows.

[initrd][bootconfig][(pad)][size][csum]["#BOOTCONFIG\n"]

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v5:
  - Sort the local variables by length.
  - Remove if from padding size calculation (alignment should be power of two)
  - Cleanup footer setup code.
  - Fix a bug if write() == 0 case.
 Changes in v3:
  - Fix patch description
  - Fix a typo.
  - Consolidate several write()s to 1 time write to fix/simplify
    the error check.
 Changes in v2:
  - Fix to add the footer size.
---
 tools/bootconfig/main.c             |   57 +++++++++++++++++++++--------------
 tools/bootconfig/test-bootconfig.sh |    6 +++-
 2 files changed, 39 insertions(+), 24 deletions(-)

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

