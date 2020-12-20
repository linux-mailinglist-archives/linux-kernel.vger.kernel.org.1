Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C8D2DF6EA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 22:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgLTVj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 16:39:29 -0500
Received: from casper.infradead.org ([90.155.50.34]:36426 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgLTVj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 16:39:29 -0500
X-Greylist: delayed 1680 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Dec 2020 16:39:28 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=NUqXj/POrl622LAUb62LCHSZurTWKJa2BeQnkYK49wc=; b=FPcvcPrKrhzWPxAmQIQUK56PGU
        Gl4asoz4GFZ50DLgihfaToYj5BUITjB4brnnYeeKn1Rhz84vY12DZY6Bklz0oN7pVvNGKrZWcN2zT
        Z/OzTO6+ew3dhZWP7gKR36yJoXirtRQdkEa8MG1AyoGyS9bcw0rjTWZU5GY28aCcSyHOmJziA+hhM
        ONjjVOJHHt9xZwB2V7GyfmC0NtLP0d+FejMskoSMwNkp9R2GAHIWHUxrChVvlZIA5XO9y0Jmjgkk7
        2D52lZcyGi430lzzlwcOtz5/7ujlgvysAk/bTK4P/XXW3CKksqnj/Z+oWBctl3KGUN262NOnhoEf5
        A6VFoV7Q==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kr5yh-0005CV-KA; Sun, 20 Dec 2020 21:10:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Toralf=20F=C3=B6rster?= <toralf.foerster@gmx.de>,
        linux-mm@kvack.org
Subject: [RFC PATCH 2/2] mm: readahead: handle LARGE input to get_init_ra_size()
Date:   Sun, 20 Dec 2020 13:10:51 -0800
Message-Id: <20201220211051.1416-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test to detect if the input ra request size has its high order
bit set (is negative when tested as a signed long). This would be a
really Huge readahead.

If so, WARN() with the value and a stack trace so that we can see
where this is happening and then make further corrections later.
Then adjust the size value so that it is not so Huge (although
this may not be needed).

Also correct a comment: the return value is not squared for
small size.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Toralf Förster <toralf.foerster@gmx.de>
Cc: linux-mm@kvack.org
---
Notes:
- Look for "WARNING:.*get_init_ra_size"
- If panic_on_warn is set, this will cause a kernel panic().

 mm/readahead.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- linux-5.10.1.orig/mm/readahead.c
+++ linux-5.10.1/mm/readahead.c
@@ -14,6 +14,7 @@
 #include <linux/export.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
+#include <linux/bug.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/pagevec.h>
 #include <linux/pagemap.h>
@@ -303,14 +304,21 @@ void force_page_cache_ra(struct readahea
 }
 
 /*
- * Set the initial window size, round to next power of 2 and square
+ * Set the initial window size, round to next power of 2
  * for small size, x 4 for medium, and x 2 for large
  * for 128k (32 page) max ra
  * 1-8 page = 32k initial, > 8 page = 128k initial
  */
 static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
 {
-	unsigned long newsize = roundup_pow_of_two(size);
+	unsigned long newsize;
+
+	if ((signed long)size < 0) { /* high bit is set: ultra-large ra req */
+		WARN_ONCE(1, "%s: size=0x%lx\n", __func__, size);
+		size = -size;	/* really only need to flip the high/sign bit */
+	}
+
+	newsize = roundup_pow_of_two(size);
 
 	if (newsize <= max / 32)
 		newsize = newsize * 4;
