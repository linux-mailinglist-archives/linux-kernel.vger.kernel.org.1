Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C352A4990
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgKCPZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:25:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:51566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbgKCPWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:22:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2CEBBAE1C;
        Tue,  3 Nov 2020 15:22:50 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Laura Abbott <labbott@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 1/5] mm, page_alloc: do not rely on the order of page_poison and init_on_alloc/free parameters
Date:   Tue,  3 Nov 2020 16:22:33 +0100
Message-Id: <20201103152237.9853-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201103152237.9853-1-vbabka@suse.cz>
References: <20201103152237.9853-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling page_poison=1 together with init_on_alloc=1 or init_on_free=1 produces
a warning in dmesg that page_poison takes precedence. However, as these
warnings are printed in early_param handlers for init_on_alloc/free, they are
not printed if page_poison is enabled later on the command line (handlers are
called in the order of their parameters), or when init_on_alloc/free is always
enabled by the respective config option - before the page_poison early param
handler is called, it is not considered to be enabled. This is inconsistent.

We can remove the dependency on order by making the init_on_* parameters only
set a boolean variable, and postponing the evaluation after all early params
have been processed. Introduce a new init_mem_debugging_and_hardening()
function for that, and move the related debug_pagealloc processing there as
well.

As a result init_mem_debugging_and_hardening() knows always accurately if
init_on_* and/or page_poison options were enabled. Thus we can also optimize
want_init_on_alloc() and want_init_on_free(). We don't need to check
page_poisoning_enabled() there, we can instead not enable the init_on_* static
keys at all, if page poisoning is enabled. This results in a simpler and more
effective code.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/mm.h | 20 ++---------
 init/main.c        |  2 +-
 mm/page_alloc.c    | 88 ++++++++++++++++++++++------------------------
 3 files changed, 46 insertions(+), 64 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef360fe70aaf..e0bc1c8aa2a6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2865,6 +2865,7 @@ extern int apply_to_existing_page_range(struct mm_struct *mm,
 				   unsigned long address, unsigned long size,
 				   pte_fn_t fn, void *data);
 
+extern void init_mem_debugging_and_hardening(void);
 #ifdef CONFIG_PAGE_POISONING
 extern bool page_poisoning_enabled(void);
 extern void kernel_poison_pages(struct page *page, int numpages, int enable);
@@ -2874,35 +2875,20 @@ static inline void kernel_poison_pages(struct page *page, int numpages,
 					int enable) { }
 #endif
 
-#ifdef CONFIG_INIT_ON_ALLOC_DEFAULT_ON
-DECLARE_STATIC_KEY_TRUE(init_on_alloc);
-#else
 DECLARE_STATIC_KEY_FALSE(init_on_alloc);
-#endif
 static inline bool want_init_on_alloc(gfp_t flags)
 {
-	if (static_branch_unlikely(&init_on_alloc) &&
-	    !page_poisoning_enabled())
+	if (static_branch_unlikely(&init_on_alloc))
 		return true;
 	return flags & __GFP_ZERO;
 }
 
-#ifdef CONFIG_INIT_ON_FREE_DEFAULT_ON
-DECLARE_STATIC_KEY_TRUE(init_on_free);
-#else
 DECLARE_STATIC_KEY_FALSE(init_on_free);
-#endif
 static inline bool want_init_on_free(void)
 {
-	return static_branch_unlikely(&init_on_free) &&
-	       !page_poisoning_enabled();
+	return static_branch_unlikely(&init_on_free);
 }
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
-extern void init_debug_pagealloc(void);
-#else
-static inline void init_debug_pagealloc(void) {}
-#endif
 extern bool _debug_pagealloc_enabled_early;
 DECLARE_STATIC_KEY_FALSE(_debug_pagealloc_enabled);
 
diff --git a/init/main.c b/init/main.c
index 130376ec10ba..14da5458baf6 100644
--- a/init/main.c
+++ b/init/main.c
@@ -815,7 +815,7 @@ static void __init mm_init(void)
 	 * bigger than MAX_ORDER unless SPARSEMEM.
 	 */
 	page_ext_init_flatmem();
-	init_debug_pagealloc();
+	init_mem_debugging_and_hardening();
 	report_meminit();
 	mem_init();
 	kmem_cache_init();
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 23f5066bd4a5..44d596c9c764 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -165,53 +165,26 @@ unsigned long totalcma_pages __read_mostly;
 
 int percpu_pagelist_fraction;
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
-#ifdef CONFIG_INIT_ON_ALLOC_DEFAULT_ON
-DEFINE_STATIC_KEY_TRUE(init_on_alloc);
-#else
 DEFINE_STATIC_KEY_FALSE(init_on_alloc);
-#endif
 EXPORT_SYMBOL(init_on_alloc);
 
-#ifdef CONFIG_INIT_ON_FREE_DEFAULT_ON
-DEFINE_STATIC_KEY_TRUE(init_on_free);
-#else
 DEFINE_STATIC_KEY_FALSE(init_on_free);
-#endif
 EXPORT_SYMBOL(init_on_free);
 
+static bool _init_on_alloc_enabled_early __read_mostly
+				= IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);
 static int __init early_init_on_alloc(char *buf)
 {
-	int ret;
-	bool bool_result;
 
-	ret = kstrtobool(buf, &bool_result);
-	if (ret)
-		return ret;
-	if (bool_result && page_poisoning_enabled())
-		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, will take precedence over init_on_alloc\n");
-	if (bool_result)
-		static_branch_enable(&init_on_alloc);
-	else
-		static_branch_disable(&init_on_alloc);
-	return 0;
+	return kstrtobool(buf, &_init_on_alloc_enabled_early);
 }
 early_param("init_on_alloc", early_init_on_alloc);
 
+static bool _init_on_free_enabled_early __read_mostly
+				= IS_ENABLED(CONFIG_INIT_ON_FREE_DEFAULT_ON);
 static int __init early_init_on_free(char *buf)
 {
-	int ret;
-	bool bool_result;
-
-	ret = kstrtobool(buf, &bool_result);
-	if (ret)
-		return ret;
-	if (bool_result && page_poisoning_enabled())
-		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, will take precedence over init_on_free\n");
-	if (bool_result)
-		static_branch_enable(&init_on_free);
-	else
-		static_branch_disable(&init_on_free);
-	return 0;
+	return kstrtobool(buf, &_init_on_free_enabled_early);
 }
 early_param("init_on_free", early_init_on_free);
 
@@ -728,19 +701,6 @@ static int __init early_debug_pagealloc(char *buf)
 }
 early_param("debug_pagealloc", early_debug_pagealloc);
 
-void init_debug_pagealloc(void)
-{
-	if (!debug_pagealloc_enabled())
-		return;
-
-	static_branch_enable(&_debug_pagealloc_enabled);
-
-	if (!debug_guardpage_minorder())
-		return;
-
-	static_branch_enable(&_debug_guardpage_enabled);
-}
-
 static int __init debug_guardpage_minorder_setup(char *buf)
 {
 	unsigned long res;
@@ -792,6 +752,42 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
 				unsigned int order, int migratetype) {}
 #endif
 
+/*
+ * Enable static keys related to various memory debugging and hardening options.
+ * Some override others, and depend on early params that are evaluated in the
+ * order of appearance. So we need to first gather the full picture of what was
+ * enabled, and then make decisions.
+ */
+void init_mem_debugging_and_hardening(void)
+{
+	if (_init_on_alloc_enabled_early) {
+		if (page_poisoning_enabled())
+			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
+				"will take precedence over init_on_alloc\n");
+		else
+			static_branch_enable(&init_on_alloc);
+	}
+	if (_init_on_free_enabled_early) {
+		if (page_poisoning_enabled())
+			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
+				"will take precedence over init_on_free\n");
+		else
+			static_branch_enable(&init_on_free);
+	}
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	if (!debug_pagealloc_enabled())
+		return;
+
+	static_branch_enable(&_debug_pagealloc_enabled);
+
+	if (!debug_guardpage_minorder())
+		return;
+
+	static_branch_enable(&_debug_guardpage_enabled);
+#endif
+}
+
 static inline void set_buddy_order(struct page *page, unsigned int order)
 {
 	set_page_private(page, order);
-- 
2.29.1

