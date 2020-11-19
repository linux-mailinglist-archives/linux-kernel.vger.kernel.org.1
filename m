Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394332B8B21
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 06:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgKSFxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 00:53:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgKSFxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 00:53:35 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A9852225E;
        Thu, 19 Nov 2020 05:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605765215;
        bh=cxSZESpT7+HJLeepwvQ8tCLet8gD+3Fq53Rp55xOa3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2h6PinNVyjMuh+eOrjocZN0Pl8MDf84Y4prxUvYzdT8665TUJf/xYVo7LpLqWK5X
         s6oiD8KedO7EVgpSgzBjl6oL+Yk0kjOertrCFPTC8R6e+HxkBWSSAkRxFVbQVZ2+km
         UW8EU1af+tpf5Y76sZaDOFs1vkZiILOQr0IBBbsg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 2/4] tools/bootconfig: Fix to check the write failure correctly
Date:   Thu, 19 Nov 2020 14:53:31 +0900
Message-Id: <160576521135.320071.3883101436675969998.stgit@devnote2>
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

Fix to check the write(2) failure including partial write
correctly and try to rollback the partial write, because
if there is no BOOTCONFIG_MAGIC string, we can not remove it.

Fixes: 85c46b78da58 ("bootconfig: Add bootconfig magic word for indicating bootconfig explicitly")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v5:
   - Return -ENOSPC for partial write.
---
 tools/bootconfig/main.c |   30 ++++++++++++++++++++++++++----
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

