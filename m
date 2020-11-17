Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9C12B5C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgKQJxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:53:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbgKQJxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:53:04 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8B5C2465B;
        Tue, 17 Nov 2020 09:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605606783;
        bh=eH0eFjEdfPCKqj+nFvfcrkvS6cdGdrlUpwKSE4VZIU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T4kl2EN8AwquU5YcXk+FRUVyC7fsiqwYFGkUz8U9UenbhjTuvQOeEZZZlkA9DhB3O
         wcIXQvXoPGbOdg4YEEcc2janZg7+sLmRw8qp04yFmqiTrA6jilPD9mF1XMNgpweRN4
         luHtPNo6AmHeUNsGSsT5yicN5AmdizWkQpI4IkSI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 1/3] tools/bootconfig: Fix to check the write failure correctly
Date:   Tue, 17 Nov 2020 18:52:59 +0900
Message-Id: <160560677952.144950.8229834525319742454.stgit@devnote2>
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

Fix to check the write(2) failure including partial write
correctly and try to rollback the partial write, because
if there is no BOOTCONFIG_MAGIC string, we can not remove it.

Fixes: 85c46b78da58 ("bootconfig: Add bootconfig magic word for indicating bootconfig explicitly")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/main.c |   27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index eb92027817a7..f7b89a50404c 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -332,6 +332,7 @@ static int delete_xbc(const char *path)
 
 static int apply_xbc(const char *path, const char *xbc_path)
 {
+	struct stat stat;
 	u32 size, csum;
 	char *buf, *data;
 	int ret, fd;
@@ -388,16 +389,26 @@ static int apply_xbc(const char *path, const char *xbc_path)
 		return fd;
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
@@ -405,6 +416,14 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	free(data);
 
 	return ret;
+
+out_rollback:
+	if (ftruncate(fd, stat.st_size) < 0) {
+		ret = -errno;
+		pr_err("Failed to rollback the write error: %d\n", ret);
+		pr_err("The initrd %s may be corrupted. Recommend to rebuild.\n", path);
+	}
+	goto out;
 }
 
 static int usage(void)

