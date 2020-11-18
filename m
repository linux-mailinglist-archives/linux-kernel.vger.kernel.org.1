Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F5B2B8623
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgKRU6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:58:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57764 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbgKRU6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:58:43 -0500
Message-Id: <20201118204007.670851839@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605733121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=n6ZnY4fkMJxZaMnKuAdf5ZenkVJW5B3lKuVHTxlEMsQ=;
        b=eUC6bTUEftA8VubxeJPfi/9RV3Ygjgx/syVTifwYyBPpgBjdlQO3p+Tzw/9zclPhp/oguL
        V8eWjtmVqFSElbYr6KDgwpygcHQvsZgRV7o+76zpYgZzWeUL3uF7Gf8Qu3T4zcE8aNG03c
        n11gDWPi6Psl/yvCMsgMY1kZO2qFOT+MTYMWMxeyM4Xm3bgZ2gmezcUmwJ/3vzPTSQ8zu1
        9Pd0CB4FdrVTnDl3k0VzGFRrox46iOe3gPocn0qCiYEZzgzocPIib7OQMrq7yp6VVBqH4a
        vxPF6PZJlxoxos0zcXWJf0Dk+BJnyOHqxFPuFx4WCACiK4uLEpRHFpd68LKPXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605733121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=n6ZnY4fkMJxZaMnKuAdf5ZenkVJW5B3lKuVHTxlEMsQ=;
        b=6Gj6t05xdfPnftLBfQTZ+to85TmZSrrZNMp1Vt4RpSfwiFRxeihmtg7CYQ3+YvJG7vqQMO
        kUZoqldX72sngVCg==
Date:   Wed, 18 Nov 2020 20:48:46 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [patch V4 8/8] x86/crashdump/32: Simplify copy_oldmem_page()
References: <20201118194838.753436396@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Replace kmap_atomic_pfn() with kmap_local_pfn() which is preemptible and
can take page faults.

Remove the indirection of the dump page and the related cruft which is not
longer required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: New patch
---
 arch/x86/kernel/crash_dump_32.c |   48 ++++++++--------------------------------
 1 file changed, 10 insertions(+), 38 deletions(-)

--- a/arch/x86/kernel/crash_dump_32.c
+++ b/arch/x86/kernel/crash_dump_32.c
@@ -13,8 +13,6 @@
 
 #include <linux/uaccess.h>
 
-static void *kdump_buf_page;
-
 static inline bool is_crashed_pfn_valid(unsigned long pfn)
 {
 #ifndef CONFIG_X86_PAE
@@ -41,15 +39,11 @@ static inline bool is_crashed_pfn_valid(
  * @userbuf: if set, @buf is in user address space, use copy_to_user(),
  *	otherwise @buf is in kernel address space, use memcpy().
  *
- * Copy a page from "oldmem". For this page, there is no pte mapped
- * in the current kernel. We stitch up a pte, similar to kmap_atomic.
- *
- * Calling copy_to_user() in atomic context is not desirable. Hence first
- * copying the data to a pre-allocated kernel page and then copying to user
- * space in non-atomic context.
+ * Copy a page from "oldmem". For this page, there might be no pte mapped
+ * in the current kernel.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-                               size_t csize, unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
+			 unsigned long offset, int userbuf)
 {
 	void  *vaddr;
 
@@ -59,38 +53,16 @@ ssize_t copy_oldmem_page(unsigned long p
 	if (!is_crashed_pfn_valid(pfn))
 		return -EFAULT;
 
-	vaddr = kmap_atomic_pfn(pfn);
+	vaddr = kmap_local_pfn(pfn);
 
 	if (!userbuf) {
-		memcpy(buf, (vaddr + offset), csize);
-		kunmap_atomic(vaddr);
+		memcpy(buf, vaddr + offset, csize);
 	} else {
-		if (!kdump_buf_page) {
-			printk(KERN_WARNING "Kdump: Kdump buffer page not"
-				" allocated\n");
-			kunmap_atomic(vaddr);
-			return -EFAULT;
-		}
-		copy_page(kdump_buf_page, vaddr);
-		kunmap_atomic(vaddr);
-		if (copy_to_user(buf, (kdump_buf_page + offset), csize))
-			return -EFAULT;
+		if (copy_to_user(buf, vaddr + offset, csize))
+			csize = -EFAULT;
 	}
 
-	return csize;
-}
+	kunmap_local(vaddr);
 
-static int __init kdump_buf_page_init(void)
-{
-	int ret = 0;
-
-	kdump_buf_page = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!kdump_buf_page) {
-		printk(KERN_WARNING "Kdump: Failed to allocate kdump buffer"
-			 " page\n");
-		ret = -ENOMEM;
-	}
-
-	return ret;
+	return csize;
 }
-arch_initcall(kdump_buf_page_init);

