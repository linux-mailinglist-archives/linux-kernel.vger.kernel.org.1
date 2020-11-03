Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A992A497F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgKCPYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:24:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:51904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbgKCPWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:22:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92A9DB02D;
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
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 5/5] mm, page_poison: remove CONFIG_PAGE_POISONING_ZERO
Date:   Tue,  3 Nov 2020 16:22:37 +0100
Message-Id: <20201103152237.9853-6-vbabka@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201103152237.9853-1-vbabka@suse.cz>
References: <20201103152237.9853-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PAGE_POISONING_ZERO uses the zero pattern instead of 0xAA. It was
introduced by commit 1414c7f4f7d7 ("mm/page_poisoning.c: allow for zero
poisoning"), noting that using zeroes retains the benefit of sanitizing content
of freed pages, with the benefit of not having to zero them again on alloc, and
the downside of making some forms of corruption (stray writes of NULLs) harder
to detect than with the 0xAA pattern. Together with
CONFIG_PAGE_POISONING_NO_SANITY it made possible to sanitize the contents on
free without checking it back on alloc.

These days we have the init_on_free() option to achieve sanitization with
zeroes and to save clearing on alloc (and without checking on alloc). Arguably
if someone does choose to check the poison for corruption on alloc, the savings
of not clearing the page are secondary, and it makes sense to always use the
0xAA poison pattern. Thus, remove the CONFIG_PAGE_POISONING_ZERO option for
being redundant.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/poison.h       |  4 ----
 mm/Kconfig.debug             | 12 ------------
 mm/page_alloc.c              |  8 +-------
 tools/include/linux/poison.h |  6 +-----
 4 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/include/linux/poison.h b/include/linux/poison.h
index dc8ae5d8db03..aff1c9250c82 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -27,11 +27,7 @@
 #define TIMER_ENTRY_STATIC	((void *) 0x300 + POISON_POINTER_DELTA)
 
 /********** mm/page_poison.c **********/
-#ifdef CONFIG_PAGE_POISONING_ZERO
-#define PAGE_POISON 0x00
-#else
 #define PAGE_POISON 0xaa
-#endif
 
 /********** mm/page_alloc.c ************/
 
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 14e29fe5bfa6..1e73717802f8 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -80,18 +80,6 @@ config PAGE_POISONING
 
 	  If unsure, say N
 
-config PAGE_POISONING_ZERO
-	bool "Use zero for poisoning instead of debugging value"
-	depends on PAGE_POISONING
-	help
-	   Instead of using the existing poison value, fill the pages with
-	   zeros. This makes it harder to detect when errors are occurring
-	   due to sanitization but the zeroing at free means that it is
-	   no longer necessary to write zeros when GFP_ZERO is used on
-	   allocation.
-
-	   If unsure, say N
-
 config DEBUG_PAGE_REF
 	bool "Enable tracepoint to track down page reference manipulation"
 	depends on DEBUG_KERNEL
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fd7f9345adc0..2054320d3c1f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2215,12 +2215,6 @@ static inline int check_new_page(struct page *page)
 	return 1;
 }
 
-static inline bool free_pages_prezeroed(void)
-{
-	return (IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) &&
-		page_poisoning_enabled_static()) || want_init_on_free();
-}
-
 #ifdef CONFIG_DEBUG_VM
 /*
  * With DEBUG_VM enabled, order-0 pages are checked for expected state when
@@ -2291,7 +2285,7 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
 {
 	post_alloc_hook(page, order, gfp_flags);
 
-	if (!free_pages_prezeroed() && want_init_on_alloc(gfp_flags))
+	if (!want_init_on_free() && want_init_on_alloc(gfp_flags))
 		kernel_init_free_pages(page, 1 << order);
 
 	if (order && (gfp_flags & __GFP_COMP))
diff --git a/tools/include/linux/poison.h b/tools/include/linux/poison.h
index d29725769107..2e6338ac5eed 100644
--- a/tools/include/linux/poison.h
+++ b/tools/include/linux/poison.h
@@ -35,12 +35,8 @@
  */
 #define TIMER_ENTRY_STATIC	((void *) 0x300 + POISON_POINTER_DELTA)
 
-/********** mm/debug-pagealloc.c **********/
-#ifdef CONFIG_PAGE_POISONING_ZERO
-#define PAGE_POISON 0x00
-#else
+/********** mm/page_poison.c **********/
 #define PAGE_POISON 0xaa
-#endif
 
 /********** mm/page_alloc.c ************/
 
-- 
2.29.1

