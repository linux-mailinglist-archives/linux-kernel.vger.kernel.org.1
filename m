Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3132C2CB224
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 02:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgLBBNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 20:13:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgLBBNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 20:13:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9B4C221E2;
        Wed,  2 Dec 2020 01:13:10 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kkGhh-002W3E-R9; Tue, 01 Dec 2020 20:13:09 -0500
Message-ID: <20201202011309.723874753@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Dec 2020 20:12:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 2/3] tools/bootconfig: Store size and checksum in footer as le32
References: <20201202011224.839590843@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Store the size and the checksum fields in the footer as le32
instead of u32. This will allow us to apply bootconfig to the
cross build initrd without caring the endianness.

Link: https://lkml.kernel.org/r/160583935332.547349.5897811300636587426.stgit@devnote2

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/main.c | 7 +++++--
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
-- 
2.28.0


