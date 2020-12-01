Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EF32CA79E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391981AbgLAQAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:00:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388374AbgLAQAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:00:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 873A422210;
        Tue,  1 Dec 2020 16:00:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kk84T-002R52-EO; Tue, 01 Dec 2020 11:00:05 -0500
Message-ID: <20201201160005.328200500@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Dec 2020 10:58:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 02/12] tools/bootconfig: Fix to check the write failure correctly
References: <20201201155835.647858317@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Fix to check the write(2) failure including partial write
correctly and try to rollback the partial write, because
if there is no BOOTCONFIG_MAGIC string, we can not remove it.

Link: https://lkml.kernel.org/r/160576521135.320071.3883101436675969998.stgit@devnote2

Fixes: 85c46b78da58 ("bootconfig: Add bootconfig magic word for indicating bootconfig explicitly")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/main.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 52eb2bbe8966..a0733cbb3c49 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -337,6 +337,7 @@ static int delete_xbc(const char *path)
 
 static int apply_xbc(const char *path, const char *xbc_path)
 {
+	struct stat stat;
 	u32 size, csum;
 	char *buf, *data;
 	int ret, fd;
@@ -394,16 +395,26 @@ static int apply_xbc(const char *path, const char *xbc_path)
 		return ret;
 	}
 	/* TODO: Ensure the @path is initramfs/initrd image */
+	if (fstat(fd, &stat) < 0) {
+		pr_err("Failed to get the size of %s\n", path);
+		goto out;
+	}
 	ret = write(fd, data, size + 8);
-	if (ret < 0) {
+	if (ret < size + 8) {
+		if (ret < 0)
+			ret = -errno;
 		pr_err("Failed to apply a boot config: %d\n", ret);
-		goto out;
+		if (ret < 0)
+			goto out;
+		goto out_rollback;
 	}
 	/* Write a magic word of the bootconfig */
 	ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
-	if (ret < 0) {
+	if (ret < BOOTCONFIG_MAGIC_LEN) {
+		if (ret < 0)
+			ret = -errno;
 		pr_err("Failed to apply a boot config magic: %d\n", ret);
-		goto out;
+		goto out_rollback;
 	}
 	ret = 0;
 out:
@@ -411,6 +422,17 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	free(data);
 
 	return ret;
+
+out_rollback:
+	/* Map the partial write to -ENOSPC */
+	if (ret >= 0)
+		ret = -ENOSPC;
+	if (ftruncate(fd, stat.st_size) < 0) {
+		ret = -errno;
+		pr_err("Failed to rollback the write error: %d\n", ret);
+		pr_err("The initrd %s may be corrupted. Recommend to rebuild.\n", path);
+	}
+	goto out;
 }
 
 static int usage(void)
-- 
2.28.0


