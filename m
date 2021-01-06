Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C201E2EC5DA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 22:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbhAFVlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 16:41:47 -0500
Received: from p-impout008aa.msg.pkvw.co.charter.net ([47.43.26.139]:37348
        "EHLO p-impout008.msg.pkvw.co.charter.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726812AbhAFVlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 16:41:46 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jan 2021 16:41:46 EST
Received: from localhost.localdomain ([24.28.70.126])
        by cmsmtp with ESMTP
        id xGTIkOFACWkb1xGTIkCSO5; Wed, 06 Jan 2021 21:36:00 +0000
X-Authority-Analysis: v=2.3 cv=X+cs11be c=1 sm=1 tr=0
 a=BTY82x8O7hZCLddHJN7Ugw==:117 a=BTY82x8O7hZCLddHJN7Ugw==:17 a=2KX_Yc5PAAAA:8
 a=HSaPApW-AAAA:8 a=gu1jZnlCE3DicGtal5UA:9 a=K5qBII3WhM4c2FDM:21
 a=kWzZxb7PhO8AiBGg:21 a=7-jybhonH9vmnwHyecmn:22 a=90ZouZG-ZxWRzw--LAzy:22
From:   Timur Tabi <timur@tabi.org>
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Timur Tabi <timur@tabi.org>, Roman Fietze <roman.fietze@magna.com>
Subject: [PATCH] lib/hexdump: introduce DUMP_PREFIX_UNHASHED for unhashed addresses
Date:   Wed,  6 Jan 2021 15:35:47 -0600
Message-Id: <20210106213547.1077789-1-timur@tabi.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHldxUivVd5oAu0gIzJ6ktzpWYCFgS8JP8uejz/5UT7l5/tSMRjb2+JZEMCPPEcKH4G7vLiKl/30jnGPfQd0wBne+v0j/h7qU460oM5xAEyYjjOn3lAz
 //P34o/0KKe3OC55pZnlZb21swYimFMk8tdDxSgEJQEcLKBScZf2y01jVhoRriwcEtiKyU+8SXVviohzDG6fD4q33DaaJh5mhFTIiOUxsTy+Cxa4ud2bgKiq
 GZ+CceFz2unwCjrBQGalEb2KjE8drrtre8cJHj4dRKeRgTsHvntYcb+fMaTHbPqhBAbII64SiSVcVVViY51onUopDXJwTn1ZflJ1F2oOVxsBHKdLR+B5DmNN
 okDp0uhH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hashed addresses are useless in hexdumps unless you're comparing
with other hashed addresses, which is unlikely.  However, there's
no need to break existing code, so introduce a new prefix type
that prints unhashed addresses.

Signed-off-by: Timur Tabi <timur@tabi.org>
Cc: Roman Fietze <roman.fietze@magna.com>
---
 include/linux/printk.h | 3 ++-
 lib/hexdump.c          | 9 +++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index fe7eb2351610..5d833bad785c 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -567,7 +567,8 @@ extern const struct file_operations kmsg_fops;
 enum {
 	DUMP_PREFIX_NONE,
 	DUMP_PREFIX_ADDRESS,
-	DUMP_PREFIX_OFFSET
+	DUMP_PREFIX_OFFSET,
+	DUMP_PREFIX_UNHASHED,
 };
 extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
 			      int groupsize, char *linebuf, size_t linebuflen,
diff --git a/lib/hexdump.c b/lib/hexdump.c
index 9301578f98e8..b5acfc4168a8 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -211,8 +211,9 @@ EXPORT_SYMBOL(hex_dump_to_buffer);
  * @level: kernel log level (e.g. KERN_DEBUG)
  * @prefix_str: string to prefix each line with;
  *  caller supplies trailing spaces for alignment if desired
- * @prefix_type: controls whether prefix of an offset, address, or none
- *  is printed (%DUMP_PREFIX_OFFSET, %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_NONE)
+ * @prefix_type: controls whether prefix of an offset, hashed address,
+ *  unhashed address, or none is printed (%DUMP_PREFIX_OFFSET,
+ *  %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_UNHASHED, %DUMP_PREFIX_NONE)
  * @rowsize: number of bytes to print per line; must be 16 or 32
  * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
  * @buf: data blob to dump
@@ -256,6 +257,10 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 				   linebuf, sizeof(linebuf), ascii);
 
 		switch (prefix_type) {
+		case DUMP_PREFIX_UNHASHED:
+			printk("%s%s%px: %s\n",
+			       level, prefix_str, ptr + i, linebuf);
+			break;
 		case DUMP_PREFIX_ADDRESS:
 			printk("%s%s%p: %s\n",
 			       level, prefix_str, ptr + i, linebuf);
-- 
2.25.1

