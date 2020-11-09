Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA882AC4F2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgKIT2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:28:16 -0500
Received: from m12-18.163.com ([220.181.12.18]:55359 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729906AbgKIT2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0nz9E
        muVKEDMYgSYXMvDw92+1nLs3pnWhuHOXzVD23s=; b=JkhLOHYetlklEJbGvYwl0
        AuGNQEkrpIket8hlGCA+VKc1ewUBhVF6kcobIadYleLjMXKQ0vCmePiZr2IcCO/K
        aFXnYVPIRwe0Hk/JYw4M09r3zDfryU7hcEZABhDAMOPf/jayQDDspgPc3mbFjK7k
        LlnTYyc2KgbjHj1e18g/iM=
Received: from localhost.localdomain (unknown [120.229.59.65])
        by smtp14 (Coremail) with SMTP id EsCowADn6fsRmKlfQZ4cDA--.5141S4;
        Tue, 10 Nov 2020 03:27:20 +0800 (CST)
From:   zengzhaoxiu@163.com
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Subject: [PATCH 2/3] lib: zlib_inflate: improves decompression performance
Date:   Tue, 10 Nov 2020 03:25:08 +0800
Message-Id: <20201109192508.14186-1-zengzhaoxiu@163.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201109191601.14053-1-zengzhaoxiu@163.com>
References: <20201109191601.14053-1-zengzhaoxiu@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowADn6fsRmKlfQZ4cDA--.5141S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyfWw4UGr4xWFWfKw47XFb_yoWrGF4xpF
        n3K39xKryDtr1jyr92yw4rZFykZrZ3WFZrGrZxGrW09ryakrya9ry3Ww10vas7Xr9aqa17
        Cr43tF98XrZ5X37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYJP_UUUUU=
X-Originating-IP: [120.229.59.65]
X-CM-SenderInfo: p2hqw6xkdr5xrx6rljoofrz/1tbiMALXgFWBvwlf2QABsA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

This patch does:
1. Cleanup code and reduce branches
2. Use copy_from_back to copy the matched bytes from the back output buffer

I tested on 5.8.18-300.fc33.x86_64.
The performance of function zlib_inflate is improved by about 7%.
If the CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is disabled in copy_from_back.h,
the performance is improved by about 5%.

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
---
 lib/zlib_inflate/inffast.c | 122 ++++++-------------------------------
 1 file changed, 17 insertions(+), 105 deletions(-)

diff --git a/lib/zlib_inflate/inffast.c b/lib/zlib_inflate/inffast.c
index ed1f3df27260..c27e45fc5335 100644
--- a/lib/zlib_inflate/inffast.c
+++ b/lib/zlib_inflate/inffast.c
@@ -4,29 +4,13 @@
  */
 
 #include <linux/zutil.h>
+#include <asm/copy_from_back.h>
 #include "inftrees.h"
 #include "inflate.h"
 #include "inffast.h"
 
 #ifndef ASMINF
 
-union uu {
-	unsigned short us;
-	unsigned char b[2];
-};
-
-/* Endian independed version */
-static inline unsigned short
-get_unaligned16(const unsigned short *p)
-{
-	union uu  mm;
-	unsigned char *b = (unsigned char *)p;
-
-	mm.b[0] = b[0];
-	mm.b[1] = b[1];
-	return mm.us;
-}
-
 /*
    Decode literal, length, and distance codes and write out the resulting
    literal and match bytes until either not enough input or output is
@@ -184,104 +168,32 @@ void inflate_fast(z_streamp strm, unsigned start)
                         state->mode = BAD;
                         break;
                     }
-                    from = window;
-                    if (write == 0) {           /* very common case */
-                        from += wsize - op;
-                        if (op < len) {         /* some from window */
-                            len -= op;
-                            do {
-                                *out++ = *from++;
-                            } while (--op);
-                            from = out - dist;  /* rest from output */
-                        }
-                    }
-                    else if (write < op) {      /* wrap around window */
-                        from += wsize + write - op;
-                        op -= write;
-                        if (op < len) {         /* some from end of window */
-                            len -= op;
-                            do {
-                                *out++ = *from++;
-                            } while (--op);
-                            from = window;
-                            if (write < len) {  /* some from start of window */
-                                op = write;
+                    from = window + write - op;
+                    if (write < op) {           /* very common case */
+                        from += wsize;
+                        if (write) {            /* wrap around window */
+                            op -= write;
+                            if (op < len) {     /* some from end of window */
                                 len -= op;
                                 do {
                                     *out++ = *from++;
                                 } while (--op);
-                                from = out - dist;      /* rest from output */
+                                from = window;  /* some from start of window */
+                                op = write;
                             }
                         }
                     }
-                    else {                      /* contiguous in window */
-                        from += write - op;
-                        if (op < len) {         /* some from window */
-                            len -= op;
-                            do {
-                                *out++ = *from++;
-                            } while (--op);
-                            from = out - dist;  /* rest from output */
-                        }
-                    }
-                    while (len > 2) {
-                        *out++ = *from++;
-                        *out++ = *from++;
-                        *out++ = *from++;
-                        len -= 3;
-                    }
-                    if (len) {
-                        *out++ = *from++;
-                        if (len > 1)
+                    if (op < len) {             /* some from window */
+                        len -= op;              /* rest from output */
+                        do {
                             *out++ = *from++;
+                        } while (--op);
+                    } else {
+                        dist = out - from;
                     }
                 }
-                else {
-		    unsigned short *sout;
-		    unsigned long loops;
-
-                    from = out - dist;          /* copy direct from output */
-		    /* minimum length is three */
-		    /* Align out addr */
-		    if (!((long)(out - 1) & 1)) {
-			*out++ = *from++;
-			len--;
-		    }
-		    sout = (unsigned short *)(out);
-		    if (dist > 2) {
-			unsigned short *sfrom;
-
-			sfrom = (unsigned short *)(from);
-			loops = len >> 1;
-			do
-#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-			    *sout++ = *sfrom++;
-#else
-			    *sout++ = get_unaligned16(sfrom++);
-#endif
-			while (--loops);
-			out = (unsigned char *)sout;
-			from = (unsigned char *)sfrom;
-		    } else { /* dist == 1 or dist == 2 */
-			unsigned short pat16;
-
-			pat16 = *(sout-1);
-			if (dist == 1) {
-				union uu mm;
-				/* copy one char pattern to both bytes */
-				mm.us = pat16;
-				mm.b[0] = mm.b[1];
-				pat16 = mm.us;
-			}
-			loops = len >> 1;
-			do
-			    *sout++ = pat16;
-			while (--loops);
-			out = (unsigned char *)sout;
-		    }
-		    if (len & 1)
-			*out++ = *from++;
-                }
+                /* copy direct from output */
+                out = copy_from_back(out, dist, len);
             }
             else if ((op & 64) == 0) {          /* 2nd level distance code */
                 this = dcode[this.val + (hold & ((1U << op) - 1))];
-- 
2.28.0


