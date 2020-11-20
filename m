Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207D02BA06C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 03:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgKTC3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 21:29:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgKTC3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:29:17 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FBE8222C8;
        Fri, 20 Nov 2020 02:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605839357;
        bh=Pz+QUbIq/xE+KNtd0DhZLW2abReYpglxqge7YM02zmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x+WGvfdRdjO31i9cSaBhXWkJPSBLLoto3bQwbxs69dlmRZxojtiLo7pXw5pKw32yw
         XDolyn9Qhb/oi6XgIkFyU6m1edfzxAmNElaV4niOVw0z6g1hxMNMBnyCu56Q9OjO0k
         +ykdEGKzv5AoDT50nqCvvbaAxqKb3q6j3LpXXQy8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 2/3] tools/bootconfig: Store size and checksum in footer as le32
Date:   Fri, 20 Nov 2020 11:29:13 +0900
Message-Id: <160583935332.547349.5897811300636587426.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160583933538.547349.272918354455492444.stgit@devnote2>
References: <160583933538.547349.272918354455492444.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the size and the checksum fields in the footer as le32
instead of u32. This will allow us to apply bootconfig to the
cross build initrd without caring the endianness.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/main.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 4a445b6304bb..7362bef1a368 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -10,6 +10,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <errno.h>
+#include <endian.h>
 
 #include <linux/kernel.h>
 #include <linux/bootconfig.h>
@@ -183,9 +184,11 @@ static int load_xbc_from_initrd(int fd, char **buf)
 
 	if (read(fd, &size, sizeof(u32)) < 0)
 		return pr_errno("Failed to read size", -errno);
+	size = le32toh(size);
 
 	if (read(fd, &csum, sizeof(u32)) < 0)
 		return pr_errno("Failed to read checksum", -errno);
+	csum = le32toh(csum);
 
 	/* Wrong size error  */
 	if (stat.st_size < size + 8 + BOOTCONFIG_MAGIC_LEN) {
@@ -407,10 +410,10 @@ static int apply_xbc(const char *path, const char *xbc_path)
 
 	/* Add a footer */
 	p = data + size;
-	*(u32 *)p = size;
+	*(u32 *)p = htole32(size);
 	p += sizeof(u32);
 
-	*(u32 *)p = csum;
+	*(u32 *)p = htole32(csum);
 	p += sizeof(u32);
 
 	memcpy(p, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);

