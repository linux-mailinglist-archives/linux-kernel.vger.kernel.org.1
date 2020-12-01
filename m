Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7409E2CA7A0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403909AbgLAQAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:00:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389229AbgLAQAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:00:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AF78208C3;
        Tue,  1 Dec 2020 16:00:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kk84T-002R4X-9o; Tue, 01 Dec 2020 11:00:05 -0500
Message-ID: <20201201160005.179059473@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Dec 2020 10:58:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 01/12] tools/bootconfig: Fix errno reference after printf()
References: <20201201155835.647858317@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Fix not to refer the errno variable as the result of previous libc
functions after printf() because printf() can change the errno.

Link: https://lkml.kernel.org/r/160576520243.320071.51093664672431249.stgit@devnote2

Fixes: 85c46b78da58 ("bootconfig: Add bootconfig magic word for indicating bootconfig explicitly")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/main.c | 52 +++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index eb92027817a7..52eb2bbe8966 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -147,6 +147,12 @@ static int load_xbc_file(const char *path, char **buf)
 	return ret;
 }
 
+static int pr_errno(const char *msg, int err)
+{
+	pr_err("%s: %d\n", msg, err);
+	return err;
+}
+
 static int load_xbc_from_initrd(int fd, char **buf)
 {
 	struct stat stat;
@@ -162,26 +168,24 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	if (stat.st_size < 8 + BOOTCONFIG_MAGIC_LEN)
 		return 0;
 
-	if (lseek(fd, -BOOTCONFIG_MAGIC_LEN, SEEK_END) < 0) {
-		pr_err("Failed to lseek: %d\n", -errno);
-		return -errno;
-	}
+	if (lseek(fd, -BOOTCONFIG_MAGIC_LEN, SEEK_END) < 0)
+		return pr_errno("Failed to lseek for magic", -errno);
+
 	if (read(fd, magic, BOOTCONFIG_MAGIC_LEN) < 0)
-		return -errno;
+		return pr_errno("Failed to read", -errno);
+
 	/* Check the bootconfig magic bytes */
 	if (memcmp(magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN) != 0)
 		return 0;
 
-	if (lseek(fd, -(8 + BOOTCONFIG_MAGIC_LEN), SEEK_END) < 0) {
-		pr_err("Failed to lseek: %d\n", -errno);
-		return -errno;
-	}
+	if (lseek(fd, -(8 + BOOTCONFIG_MAGIC_LEN), SEEK_END) < 0)
+		return pr_errno("Failed to lseek for size", -errno);
 
 	if (read(fd, &size, sizeof(u32)) < 0)
-		return -errno;
+		return pr_errno("Failed to read size", -errno);
 
 	if (read(fd, &csum, sizeof(u32)) < 0)
-		return -errno;
+		return pr_errno("Failed to read checksum", -errno);
 
 	/* Wrong size error  */
 	if (stat.st_size < size + 8 + BOOTCONFIG_MAGIC_LEN) {
@@ -190,10 +194,8 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	}
 
 	if (lseek(fd, stat.st_size - (size + 8 + BOOTCONFIG_MAGIC_LEN),
-		  SEEK_SET) < 0) {
-		pr_err("Failed to lseek: %d\n", -errno);
-		return -errno;
-	}
+		  SEEK_SET) < 0)
+		return pr_errno("Failed to lseek", -errno);
 
 	ret = load_xbc_fd(fd, buf, size);
 	if (ret < 0)
@@ -262,14 +264,16 @@ static int show_xbc(const char *path, bool list)
 
 	ret = stat(path, &st);
 	if (ret < 0) {
-		pr_err("Failed to stat %s: %d\n", path, -errno);
-		return -errno;
+		ret = -errno;
+		pr_err("Failed to stat %s: %d\n", path, ret);
+		return ret;
 	}
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		pr_err("Failed to open initrd %s: %d\n", path, fd);
-		return -errno;
+		ret = -errno;
+		pr_err("Failed to open initrd %s: %d\n", path, ret);
+		return ret;
 	}
 
 	ret = load_xbc_from_initrd(fd, &buf);
@@ -307,8 +311,9 @@ static int delete_xbc(const char *path)
 
 	fd = open(path, O_RDWR);
 	if (fd < 0) {
-		pr_err("Failed to open initrd %s: %d\n", path, fd);
-		return -errno;
+		ret = -errno;
+		pr_err("Failed to open initrd %s: %d\n", path, ret);
+		return ret;
 	}
 
 	size = load_xbc_from_initrd(fd, &buf);
@@ -383,9 +388,10 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	/* Apply new one */
 	fd = open(path, O_RDWR | O_APPEND);
 	if (fd < 0) {
-		pr_err("Failed to open %s: %d\n", path, fd);
+		ret = -errno;
+		pr_err("Failed to open %s: %d\n", path, ret);
 		free(data);
-		return fd;
+		return ret;
 	}
 	/* TODO: Ensure the @path is initramfs/initrd image */
 	ret = write(fd, data, size + 8);
-- 
2.28.0


