Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE332B1BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgKMN3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:29:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgKMN3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:29:33 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DFE72085B;
        Fri, 13 Nov 2020 13:29:32 +0000 (UTC)
Date:   Fri, 13 Nov 2020 08:29:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chen Yu <yu.chen.surf@gmail.com>
Subject: [GIT PULL] bootconfig: Extend the magic check range to the
 preceding 3 bytes
Message-ID: <20201113082930.27da4612@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Fix alignment of bootconfig

GRUB may align the init ramdisk size to 4 bytes, the magic number at the
end of the init ramdisk that denotes bootconfig is attached may not be at
the exact end of the ramdisk. The kernel needs to check back at least 4
bytes.


Please pull the latest trace-v5.10-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.10-rc3

Tag SHA1: e20c1d4f9314c2296b72a02f3e21c6116099f573
Head SHA1: 50b8a742850fce7293bed45753152c425f7e931b


Masami Hiramatsu (1):
      bootconfig: Extend the magic check range to the preceding 3 bytes

----
 init/main.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)
---------------------------
commit 50b8a742850fce7293bed45753152c425f7e931b
Author: Masami Hiramatsu <mhiramat@kernel.org>
Date:   Fri Nov 13 02:27:31 2020 +0900

    bootconfig: Extend the magic check range to the preceding 3 bytes
    
    Since Grub may align the size of initrd to 4 if user pass
    initrd from cpio, we have to check the preceding 3 bytes as well.
    
    Link: https://lkml.kernel.org/r/160520205132.303174.4876760192433315429.stgit@devnote2
    
    Cc: stable@vger.kernel.org
    Fixes: 85c46b78da58 ("bootconfig: Add bootconfig magic word for indicating bootconfig explicitly")
    Reported-by: Chen Yu <yu.chen.surf@gmail.com>
    Tested-by: Chen Yu <yu.chen.surf@gmail.com>
    Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/init/main.c b/init/main.c
index 130376ec10ba..20baced721ad 100644
--- a/init/main.c
+++ b/init/main.c
@@ -269,14 +269,24 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 	u32 size, csum;
 	char *data;
 	u32 *hdr;
+	int i;
 
 	if (!initrd_end)
 		return NULL;
 
 	data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
-	if (memcmp(data, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN))
-		return NULL;
+	/*
+	 * Since Grub may align the size of initrd to 4, we must
+	 * check the preceding 3 bytes as well.
+	 */
+	for (i = 0; i < 4; i++) {
+		if (!memcmp(data, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN))
+			goto found;
+		data--;
+	}
+	return NULL;
 
+found:
 	hdr = (u32 *)(data - 8);
 	size = hdr[0];
 	csum = hdr[1];
