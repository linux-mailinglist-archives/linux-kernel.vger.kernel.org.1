Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4789A2B5C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgKQJxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:53:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:36370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727498AbgKQJxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:53:13 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ABEB222EC;
        Tue, 17 Nov 2020 09:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605606792;
        bh=lxR9ZUQuLOHPWmO5n3HrzB01mib+znympSQG2AxpF40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=znYXAGVdaCBCh0zxmw9JEwDzfsrU+hz0Xlbgs/UPboPRClqmKn3lGmLabYrOxJVl9
         9XS7EYJFIMhH+BRprcI01jliYm9/vuXMIsDWK8+vdVthfQYXE3DOeCFS0bwOEA4ubq
         UADxUq6ZudKOGN/xfzDaRed3J7Uz+71LTLIZTPeQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 2/3] tools/bootconfig: Align the bootconfig applied initrd image size to 4
Date:   Tue, 17 Nov 2020 18:53:08 +0900
Message-Id: <160560678852.144950.5641808076257288180.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160560676899.144950.4148778261999789656.stgit@devnote2>
References: <160560676899.144950.4148778261999789656.stgit@devnote2>
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
 Changes in v3:
  - Fix patch description
  - Fix a typo.
  - Consolidate several write()s to 1 time write to fix/simplify
    the error check.
 Changes in v2:
  - Fix to add the footer size.
---
 include/linux/bootconfig.h          |    1 +
 tools/bootconfig/main.c             |   48 ++++++++++++++++++++---------------
 tools/bootconfig/test-bootconfig.sh |    6 ++++
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 9903088891fa..461f621047f3 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -12,6 +12,7 @@
 
 #define BOOTCONFIG_MAGIC	"#BOOTCONFIG\n"
 #define BOOTCONFIG_MAGIC_LEN	12
+#define BOOTCONFIG_ALIGN	4
 
 /* XBC tree node */
 struct xbc_node {
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index f7b89a50404c..3991754c97e9 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -332,12 +332,13 @@ static int delete_xbc(const char *path)
 
 static int apply_xbc(const char *path, const char *xbc_path)
 {
+	size_t total_size;
 	struct stat stat;
 	u32 size, csum;
 	char *buf, *data;
 	int ret, fd;
 	const char *msg;
-	int pos;
+	int pos, pad;
 
 	ret = load_xbc_file(xbc_path, &buf);
 	if (ret < 0) {
@@ -347,13 +348,12 @@ static int apply_xbc(const char *path, const char *xbc_path)
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
@@ -393,24 +393,30 @@ static int apply_xbc(const char *path, const char *xbc_path)
 		pr_err("Failed to get the size of %s\n", path);
 		goto out;
 	}
-	ret = write(fd, data, size + 8);
-	if (ret < size + 8) {
+
+	/* To align up the total size to BOOTCONFIG_ALIGN, get padding size */
+	total_size = stat.st_size + size + sizeof(u32) * 2 + BOOTCONFIG_MAGIC_LEN;
+	pad = BOOTCONFIG_ALIGN - total_size % BOOTCONFIG_ALIGN;
+	if (pad == BOOTCONFIG_ALIGN)
+		pad = 0;
+	size += pad;
+
+	/* Add a footer */
+	*(u32 *)(data + size) = size;
+	*(u32 *)(data + size + sizeof(u32)) = csum;
+	memcpy(data + size + sizeof(u32) * 2, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
+	total_size = size + sizeof(u32) * 2 + BOOTCONFIG_MAGIC_LEN;
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
+		if (ret > 0)
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

