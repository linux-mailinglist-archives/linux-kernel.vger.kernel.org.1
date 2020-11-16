Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2392B4AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbgKPQWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:22:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731859AbgKPQWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:22:51 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B99692222C;
        Mon, 16 Nov 2020 16:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605543770;
        bh=WrGTkDJ+Rhf+9I3EJi9/f1bb7N9eaAycc2ewX+tM0lI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZHgTNsVhEPTEXp1vuf9FcR5PyMp9YuD8NzSLLhw1twwmoy1QXO3ZrNJD6OSyRkWw
         3R84TMM8OnQmwcTDGrbZnkffzyX9YIUu28CGzjTm5KRQl+xt6EH++nqLodT2UAjU6o
         PKr2ON/Y4lLDSyarQ8Az5vP9V1fKkrWIMWZEgsBQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 1/2] tools/bootconfig: Align the bootconfig applied initrd image size to 4
Date:   Tue, 17 Nov 2020 01:22:47 +0900
Message-Id: <160554376709.96595.14400301252651907015.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160554375807.96595.16142008590130221699.stgit@devnote2>
References: <160554375807.96595.16142008590130221699.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the bootconfig applied initrd image size to 4. To pad the data,
bootconfig will use space (0x20) in front of the bootconfig data,
and expands its size and update checksum.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - Fix to add the footer size.
---
 tools/bootconfig/main.c             |   36 ++++++++++++++++++++++++++++++-----
 tools/bootconfig/test-bootconfig.sh |    6 +++++-
 2 files changed, 36 insertions(+), 6 deletions(-)

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
index eb92027817a7..ab6a043bbd4c 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -332,11 +332,14 @@ static int delete_xbc(const char *path)
 
 static int apply_xbc(const char *path, const char *xbc_path)
 {
+	const char padbuf[BOOTCONFIG_ALIGN] = { 0 };
+	size_t total_size;
 	u32 size, csum;
 	char *buf, *data;
 	int ret, fd;
 	const char *msg;
-	int pos;
+	struct stat st;
+	int pos, pad;
 
 	ret = load_xbc_file(xbc_path, &buf);
 	if (ret < 0) {
@@ -347,12 +350,10 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	csum = checksum((unsigned char *)buf, size);
 
 	/* Prepare xbc_path data */
-	data = malloc(size + 8);
+	data = malloc(size);
 	if (!data)
 		return -ENOMEM;
 	strcpy(data, buf);
-	*(u32 *)(data + size) = size;
-	*(u32 *)(data + size + 4) = csum;
 
 	/* Check the data format */
 	ret = xbc_init(buf, &msg, &pos);
@@ -387,12 +388,37 @@ static int apply_xbc(const char *path, const char *xbc_path)
 		free(data);
 		return fd;
 	}
+
+	/* To algin up the total size to BOOTCONFIG_ALIGN, get padding size */
+	ret = fstat(fd, &st);
+	if (ret < 0) {
+		pr_err("Failed to get the stat of %s\n", path);
+		free(data);
+		return ret;
+	}
+	total_size = st.st_size + size + sizeof(u32) + sizeof(u32)
+		     + BOOTCONFIG_MAGIC_LEN;
+	pad = BOOTCONFIG_ALIGN - total_size % BOOTCONFIG_ALIGN;
+
 	/* TODO: Ensure the @path is initramfs/initrd image */
-	ret = write(fd, data, size + 8);
+	ret = write(fd, data, size);
 	if (ret < 0) {
 		pr_err("Failed to apply a boot config: %d\n", ret);
 		goto out;
 	}
+
+	if (pad != BOOTCONFIG_ALIGN) {
+		/* Write padding null characters */
+		ret = write(fd, padbuf, pad);
+		if (ret < 0) {
+			pr_err("Failed to write padding: %d\n", ret);
+			goto out;
+		}
+		size += pad;
+	}
+	ret = write(fd, &size, sizeof(u32));
+	ret = write(fd, &csum, sizeof(u32));
+
 	/* Write a magic word of the bootconfig */
 	ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
 	if (ret < 0) {
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

