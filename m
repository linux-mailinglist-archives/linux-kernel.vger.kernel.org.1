Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F024279CB2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 23:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgIZVj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 17:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgIZVj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 17:39:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BBDC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 14:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=mqpR5mKaToPhyrhfrt21itaiYs65hzitILARZIXZNQs=; b=uJKw/s1sTnI9hMT0VNpJW8BESD
        b6fpkWuw+RMZxi0/HFWNbIqFgzQIbELWbmGR2mBdl0Rr6ln2t4KoP6imCK8aiE5KqRAWhjFZIYBiZ
        6yJgWF5WfBiMK6sqaAUByVrc315BtcaJDtL37FesygX+tQNkzUp9ls0M5zdgWOUeXwiaT1d3ir9I9
        90g9wT/lh99UiRBjT1hSAkOiWoehTBWVaMkiQGuzBnKWIF+gp7V4gDdwvY7krZUgjFqCLDt2+QdBn
        G78w2wN97kCLW9OYJTGiAN1GONbRu9oVV2ZWOBuDWt9NjaKIISnuMskDsF0DTNEI6Apj3X/4N8jeq
        5N8MqPHg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMHub-0006wS-O3; Sat, 26 Sep 2020 21:39:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Nick Piggin <npiggin@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] page_alloc: Fix freeing non-compound pages
Date:   Sat, 26 Sep 2020 22:39:19 +0100
Message-Id: <20200926213919.26642-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a very rare race which leaks memory:

Page P0 is allocated to the page cache.  Page P1 is free.

Thread A                Thread B                Thread C
find_get_entry():
xas_load() returns P0
						Removes P0 from page cache
						P0 finds its buddy P1
			alloc_pages(GFP_KERNEL, 1) returns P0
			P0 has refcount 1
page_cache_get_speculative(P0)
P0 has refcount 2
			__free_pages(P0)
			P0 has refcount 1
put_page(P0)
P1 is not freed

Fix this by freeing all the pages in __free_pages() that won't be freed
by the call to put_page().  It's usually not a good idea to split a page,
but this is a very unlikely scenario.

Fixes: e286781d5f2e ("mm: speculative page references")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
v2: Add a test module.  Verified it works by:
 (1) loading the test module on an unmodified kernel and watching it OOM
 (2) modifying __free_pages() with my v1 patch that neglected to add the
     PageHead test and hitting VM_BUG_ON_PAGE(PageTail(page))
 (3) applying all of this patch and seeing it survive

 lib/Kconfig.debug     |  9 +++++++++
 lib/Makefile          |  1 +
 lib/test_free_pages.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c       |  3 +++
 4 files changed, 55 insertions(+)
 create mode 100644 lib/test_free_pages.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e068c3c7189a..eed59af0e907 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2369,6 +2369,15 @@ config TEST_HMM
 
 	  If unsure, say N.
 
+config TEST_FREE_PAGES
+	tristate "Test freeing pages"
+	help
+	  Test that a memory leak does not occur due to a race between
+	  freeing a block of pages and a speculative page reference.
+	  Loading this module is safe if your kernel has the bug fixed.
+	  If the bug is not fixed, it will leak gigabytes of memory and
+	  probably OOM your system.
+
 config TEST_FPU
 	tristate "Test floating point operations in kernel space"
 	depends on X86 && !KCOV_INSTRUMENT_ALL
diff --git a/lib/Makefile b/lib/Makefile
index a4a4c6864f51..071b687b7363 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_TEST_BLACKHOLE_DEV) += test_blackhole_dev.o
 obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
 obj-$(CONFIG_TEST_LOCKUP) += test_lockup.o
 obj-$(CONFIG_TEST_HMM) += test_hmm.o
+obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
 
 #
 # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
diff --git a/lib/test_free_pages.c b/lib/test_free_pages.c
new file mode 100644
index 000000000000..074e76bd76b2
--- /dev/null
+++ b/lib/test_free_pages.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * test_free_pages.c: Check that free_pages() doesn't leak memory
+ * Copyright (c) 2020 Oracle
+ * Author: Matthew Wilcox <willy@infradead.org>
+ */
+
+#include <linux/gfp.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+
+static void test_free_pages(gfp_t gfp)
+{
+	unsigned int i;
+
+	for (i = 0; i < 1000 * 1000; i++) {
+		unsigned long addr = __get_free_pages(gfp, 3);
+		struct page *page = virt_to_page(addr);
+
+		/* Simulate page cache getting a speculative reference */
+		get_page(page);
+		free_pages(addr, 3);
+		put_page(page);
+	}
+}
+
+static int m_in(void)
+{
+	test_free_pages(GFP_KERNEL);
+	test_free_pages(GFP_KERNEL | __GFP_COMP);
+
+	return 0;
+}
+
+static void m_ex(void)
+{
+}
+
+module_init(m_in);
+module_exit(m_ex);
+MODULE_AUTHOR("Matthew Wilcox <willy@infradead.org>");
+MODULE_LICENSE("GPL");
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fab5e97dc9ca..9b259c76e285 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4947,6 +4947,9 @@ void __free_pages(struct page *page, unsigned int order)
 {
 	if (put_page_testzero(page))
 		free_the_page(page, order);
+	else if (!PageHead(page))
+		while (order-- > 0)
+			free_the_page(page + (1 << order), order);
 }
 EXPORT_SYMBOL(__free_pages);
 
-- 
2.28.0

