Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04B42B8B20
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 06:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgKSFx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 00:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgKSFx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 00:53:27 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AE5122240;
        Thu, 19 Nov 2020 05:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605765206;
        bh=zhC/SjhIK3y4LQ4Jurhgn6zs8VU2fvYRCH0muvwPXxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dioGgFuYxd/ThkUWxE+/Ih0KHu23dncM0Z6u21MrywtHF7y8Wqpg+7w7TmNuDq1ye
         oEFOdlq7GMbYtqLph8ByzqtxykX6lITHeu4eNyNF+NCka8eZCEaG0ZkLaDJGr9z+mB
         P4+4vBM8l3uq/nCsZBAm0qu8WPpwW/W5LtMR/UqY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 1/4] tools/bootconfig: Fix errno reference after printf()
Date:   Thu, 19 Nov 2020 14:53:22 +0900
Message-Id: <160576520243.320071.51093664672431249.stgit@devnote2>
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

Fix not to refer the errno variable as the result of previous libc
functions after printf() because printf() can change the errno.

Fixes: 85c46b78da58 ("bootconfig: Add bootconfig magic word for indicating bootconfig explicitly")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/main.c |   52 ++++++++++++++++++++++++++---------------------
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

