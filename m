Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFE42B8620
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgKRU6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgKRU6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:58:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD01C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 12:58:41 -0800 (PST)
Message-Id: <20201118204007.561220818@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605733120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+ZrRx/8oPKtbwxfPKSuA9uFhSRNHw0LXoGRTJJXvQqc=;
        b=wMGRnjEW7RLohGkm9TzjVU2Jv/8/fuvCDuUlbFsjnYUIrIlb6+Z8tYnVl80t5Xh4yK5h/x
        ZTW8xH+eJB95HzQD4tpGwvtb8LbbvsTS1MQOtIVq/WqBjDnvOXHONw5coe7Bljpfh/xbnH
        ACk0WjRR++c5UcXXoAeKCIimOr1sffBr2I8AhbdB75D72k0YUsvtAqT9YM9jtkk4rd25HM
        EOdR5NE+sPeRtPa5F0zwhqTRQx1UbFhW+79lMeZ7GTVxagAE7PYqNbL0KJm9vycjWnL4Xq
        TVJKThnz/J0tE1dsHthSM6VlAFxuuLXDfixDrCSwKNC9idyFLBPiE6bK3qOdmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605733120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+ZrRx/8oPKtbwxfPKSuA9uFhSRNHw0LXoGRTJJXvQqc=;
        b=FUmzRTH8UOdxIp1a1NUA4ayv2hSTU73Xu+3dn9nUlCCKISkX8InHxlwtmKukkTSdHS8s6t
        +ei2y27ls6Jrm9Cw==
Date:   Wed, 18 Nov 2020 20:48:45 +0100
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
Subject: [patch V4 7/8] io-mapping: Provide iomap_local variant
References: <20201118194838.753436396@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Similar to kmap local provide a iomap local variant which only disables
migration, but neither disables pagefaults nor preemption.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Restrict migrate disable to the 32bit mapping case and update documentation.

V2: Split out from the large combo patch and add the !IOMAP_ATOMIC variants
---
 Documentation/driver-api/io-mapping.rst |   76 +++++++++++++++++++-------------
 include/linux/io-mapping.h              |   30 +++++++++++-
 2 files changed, 74 insertions(+), 32 deletions(-)

--- a/Documentation/driver-api/io-mapping.rst
+++ b/Documentation/driver-api/io-mapping.rst
@@ -20,55 +20,71 @@ as it would consume too much of the kern
 mappable, while 'size' indicates how large a mapping region to
 enable. Both are in bytes.
 
-This _wc variant provides a mapping which may only be used
-with the io_mapping_map_atomic_wc or io_mapping_map_wc.
+This _wc variant provides a mapping which may only be used with
+io_mapping_map_atomic_wc(), io_mapping_map_local_wc() or
+io_mapping_map_wc().
+
+With this mapping object, individual pages can be mapped either temporarily
+or long term, depending on the requirements. Of course, temporary maps are
+more efficient. They come in two flavours::
 
-With this mapping object, individual pages can be mapped either atomically
-or not, depending on the necessary scheduling environment. Of course, atomic
-maps are more efficient::
+	void *io_mapping_map_local_wc(struct io_mapping *mapping,
+				      unsigned long offset)
 
 	void *io_mapping_map_atomic_wc(struct io_mapping *mapping,
 				       unsigned long offset)
 
-'offset' is the offset within the defined mapping region.
-Accessing addresses beyond the region specified in the
-creation function yields undefined results. Using an offset
-which is not page aligned yields an undefined result. The
-return value points to a single page in CPU address space.
-
-This _wc variant returns a write-combining map to the
-page and may only be used with mappings created by
-io_mapping_create_wc
+'offset' is the offset within the defined mapping region.  Accessing
+addresses beyond the region specified in the creation function yields
+undefined results. Using an offset which is not page aligned yields an
+undefined result. The return value points to a single page in CPU address
+space.
 
-Note that the task may not sleep while holding this page
-mapped.
+This _wc variant returns a write-combining map to the page and may only be
+used with mappings created by io_mapping_create_wc()
 
-::
+Temporary mappings are only valid in the context of the caller. The mapping
+is not guaranteed to be globaly visible.
 
-	void io_mapping_unmap_atomic(void *vaddr)
+io_mapping_map_local_wc() has a side effect on X86 32bit as it disables
+migration to make the mapping code work. No caller can rely on this side
+effect.
+
+io_mapping_map_atomic_wc() has the side effect of disabling preemption and
+pagefaults. Don't use in new code. Use io_mapping_map_local_wc() instead.
 
-'vaddr' must be the value returned by the last
-io_mapping_map_atomic_wc call. This unmaps the specified
-page and allows the task to sleep once again.
+Nested mappings need to be undone in reverse order because the mapping
+code uses a stack for keeping track of them::
 
-If you need to sleep while holding the lock, you can use the non-atomic
-variant, although they may be significantly slower.
+ addr1 = io_mapping_map_local_wc(map1, offset1);
+ addr2 = io_mapping_map_local_wc(map2, offset2);
+ ...
+ io_mapping_unmap_local(addr2);
+ io_mapping_unmap_local(addr1);
 
-::
+The mappings are released with::
+
+	void io_mapping_unmap_local(void *vaddr)
+	void io_mapping_unmap_atomic(void *vaddr)
+
+'vaddr' must be the value returned by the last io_mapping_map_local_wc() or
+io_mapping_map_atomic_wc() call. This unmaps the specified mapping and
+undoes the side effects of the mapping functions.
+
+If you need to sleep while holding a mapping, you can use the regular
+variant, although this may be significantly slower::
 
 	void *io_mapping_map_wc(struct io_mapping *mapping,
 				unsigned long offset)
 
-This works like io_mapping_map_atomic_wc except it allows
-the task to sleep while holding the page mapped.
-
+This works like io_mapping_map_atomic/local_wc() except it has no side
+effects and the pointer is globaly visible.
 
-::
+The mappings are released with::
 
 	void io_mapping_unmap(void *vaddr)
 
-This works like io_mapping_unmap_atomic, except it is used
-for pages mapped with io_mapping_map_wc.
+Use for pages mapped with io_mapping_map_wc().
 
 At driver close time, the io_mapping object must be freed::
 
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -83,6 +83,21 @@ io_mapping_unmap_atomic(void __iomem *va
 }
 
 static inline void __iomem *
+io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
+{
+	resource_size_t phys_addr;
+
+	BUG_ON(offset >= mapping->size);
+	phys_addr = mapping->base + offset;
+	return __iomap_local_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
+}
+
+static inline void io_mapping_unmap_local(void __iomem *vaddr)
+{
+	kunmap_local_indexed((void __force *)vaddr);
+}
+
+static inline void __iomem *
 io_mapping_map_wc(struct io_mapping *mapping,
 		  unsigned long offset,
 		  unsigned long size)
@@ -101,7 +116,7 @@ io_mapping_unmap(void __iomem *vaddr)
 	iounmap(vaddr);
 }
 
-#else
+#else  /* HAVE_ATOMIC_IOMAP */
 
 #include <linux/uaccess.h>
 
@@ -166,7 +181,18 @@ io_mapping_unmap_atomic(void __iomem *va
 	preempt_enable();
 }
 
-#endif /* HAVE_ATOMIC_IOMAP */
+static inline void __iomem *
+io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
+{
+	return io_mapping_map_wc(mapping, offset, PAGE_SIZE);
+}
+
+static inline void io_mapping_unmap_local(void __iomem *vaddr)
+{
+	io_mapping_unmap(vaddr);
+}
+
+#endif /* !HAVE_ATOMIC_IOMAP */
 
 static inline struct io_mapping *
 io_mapping_create_wc(resource_size_t base,


