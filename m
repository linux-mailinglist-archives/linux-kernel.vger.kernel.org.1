Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5612B94AA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgKSOb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:31:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbgKSOb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:31:56 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE54824655;
        Thu, 19 Nov 2020 14:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605796315;
        bh=NyEHUo7vvd5Jv//2zWViwF0WdKTgAYi2JS+Hryju1z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RoxUn7/jx9cBkDlhQm3F4lPq0Tm5Y2c1ROM7DcxBGNah0MPG00xIndslFLqEH4+a+
         IBCs8s0zoe5zxmoQ28xKYA8EagqD2kVTSnZ10YFpJMqGl1I2GKlCecTSPjWi1Fldc6
         EQHKof/WK6RJH5S051uXI/seIrI4Ltm9gAat7FHA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [RFC PATCH 2/3] tools/bootconfig: Use hexadecimal ASCII string for size and checksum
Date:   Thu, 19 Nov 2020 23:31:51 +0900
Message-Id: <160579631164.503380.17889801017052432263.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160579629161.503380.9118263439060046721.stgit@devnote2>
References: <160579629161.503380.9118263439060046721.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the bootconfig format more platform independent, use
8-bytes hexadecimal ASCII string for size and checksum field
in the footer. This will allow us to apply bootconfig to the
cross build initrd without caring the endianness.

This commit updates bootconfig and its test so that it can handle
new format.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/main.c             |   43 ++++++++++++++++++++++-------------
 tools/bootconfig/test-bootconfig.sh |    2 +-
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 4a445b6304bb..16eb5d4b9947 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -155,11 +155,12 @@ static int pr_errno(const char *msg, int err)
 
 static int load_xbc_from_initrd(int fd, char **buf)
 {
-	struct stat stat;
-	int ret;
-	u32 size = 0, csum = 0, rcsum;
 	char magic[BOOTCONFIG_MAGIC_LEN];
+	u32 size = 0, csum = 0, rcsum;
+	struct stat stat;
 	const char *msg;
+	char sbuf[9], *p;
+	int ret;
 
 	ret = fstat(fd, &stat);
 	if (ret < 0)
@@ -178,22 +179,33 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	if (memcmp(magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN) != 0)
 		return 0;
 
-	if (lseek(fd, -(8 + BOOTCONFIG_MAGIC_LEN), SEEK_END) < 0)
+	if (lseek(fd, -(16 + BOOTCONFIG_MAGIC_LEN), SEEK_END) < 0)
 		return pr_errno("Failed to lseek for size", -errno);
 
-	if (read(fd, &size, sizeof(u32)) < 0)
+	sbuf[8] = '\0';
+	if (read(fd, sbuf, 8) < 0)
 		return pr_errno("Failed to read size", -errno);
+	size = strtoul(sbuf, &p, 16);
+	if (p != sbuf + 8) {
+		pr_err("Found invalid size field\n");
+		return -EINVAL;
+	}
 
-	if (read(fd, &csum, sizeof(u32)) < 0)
+	if (read(fd, sbuf, 8) < 0)
 		return pr_errno("Failed to read checksum", -errno);
+	csum = strtoul(sbuf, &p, 16);
+	if (p != sbuf + 8) {
+		pr_err("Found invalid checksum field\n");
+		return -EINVAL;
+	}
 
 	/* Wrong size error  */
-	if (stat.st_size < size + 8 + BOOTCONFIG_MAGIC_LEN) {
+	if (stat.st_size < size + 16 + BOOTCONFIG_MAGIC_LEN) {
 		pr_err("bootconfig size is too big\n");
 		return -E2BIG;
 	}
 
-	if (lseek(fd, stat.st_size - (size + 8 + BOOTCONFIG_MAGIC_LEN),
+	if (lseek(fd, stat.st_size - (size + 16 + BOOTCONFIG_MAGIC_LEN),
 		  SEEK_SET) < 0)
 		return pr_errno("Failed to lseek", -errno);
 
@@ -324,7 +336,7 @@ static int delete_xbc(const char *path)
 		ret = fstat(fd, &stat);
 		if (!ret)
 			ret = ftruncate(fd, stat.st_size
-					- size - 8 - BOOTCONFIG_MAGIC_LEN);
+					- size - 16 - BOOTCONFIG_MAGIC_LEN);
 		if (ret)
 			ret = -errno;
 	} /* Ignore if there is no boot config in initrd */
@@ -354,8 +366,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	csum = checksum((unsigned char *)buf, size);
 
 	/* Backup the bootconfig data */
-	data = calloc(size + BOOTCONFIG_ALIGN +
-		      sizeof(u32) + sizeof(u32) + BOOTCONFIG_MAGIC_LEN, 1);
+	data = calloc(size + BOOTCONFIG_ALIGN + 16 + BOOTCONFIG_MAGIC_LEN, 1);
 	if (!data)
 		return -ENOMEM;
 	memcpy(data, buf, size);
@@ -401,17 +412,17 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	}
 
 	/* To align up the total size to BOOTCONFIG_ALIGN, get padding size */
-	total_size = stat.st_size + size + sizeof(u32) * 2 + BOOTCONFIG_MAGIC_LEN;
+	total_size = stat.st_size + size + 16 + BOOTCONFIG_MAGIC_LEN;
 	pad = ((total_size + BOOTCONFIG_ALIGN - 1) & (~BOOTCONFIG_ALIGN_MASK)) - total_size;
 	size += pad;
 
 	/* Add a footer */
 	p = data + size;
-	*(u32 *)p = size;
-	p += sizeof(u32);
+	sprintf(p, "%08x", size);
+	p += 8;
 
-	*(u32 *)p = csum;
-	p += sizeof(u32);
+	sprintf(p, "%08x", csum);
+	p += 8;
 
 	memcpy(p, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
 	p += BOOTCONFIG_MAGIC_LEN;
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index baed891d0ba4..a40926b8927c 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -60,7 +60,7 @@ echo "Show command test"
 xpass $BOOTCONF $INITRD
 
 echo "File size check"
-total_size=$(expr $bconf_size + $initrd_size + 9 + 12 + $ALIGN - 1 )
+total_size=$(expr $bconf_size + $initrd_size + 17 + 12 + $ALIGN - 1 )
 total_size=$(expr $total_size / $ALIGN)
 total_size=$(expr $total_size \* $ALIGN)
 xpass test $new_size -eq $total_size

