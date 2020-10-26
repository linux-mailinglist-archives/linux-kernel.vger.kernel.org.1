Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F0E2993EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787865AbgJZReN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:34:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:43832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1780079AbgJZReI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:34:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7F63AE3B;
        Mon, 26 Oct 2020 17:34:06 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 2/3] mm, page_poison: use static key more efficiently
Date:   Mon, 26 Oct 2020 18:33:57 +0100
Message-Id: <20201026173358.14704-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201026173358.14704-1-vbabka@suse.cz>
References: <20201026173358.14704-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 11c9c7edae06 ("mm/page_poison.c: replace bool variable with static key")
changed page_poisoning_enabled() to a static key check. However, the function
is not inlined, so each check still involves a function call with overhead not
eliminated when page poisoning is disabled.

Analogically to how debug_pagealloc is handled, this patch converts
page_poisoning_enabled() back to boolean check, and introduces
page_poisoning_enabled_static() for fast paths. Both functions are inlined.

Also optimize the check that enables page poisoning instead of debug_pagealloc
for architectures without proper debug_pagealloc support. Move the check to
init_mem_debugging() to enable a single static key instead of having two
static branches in page_poisoning_enabled_static().

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/virtio/virtio_balloon.c |  2 +-
 include/linux/mm.h              | 16 ++++++++++++-
 mm/page_alloc.c                 | 13 ++++++++++-
 mm/page_poison.c                | 40 +++++----------------------------
 4 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 481611c09dae..e53faed6ba93 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1116,7 +1116,7 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	 */
 	if (!want_init_on_free() &&
 	    (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY) ||
-	     !page_poisoning_enabled()))
+	     !page_poisoning_enabled_static()))
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
 	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c6a0adccf2fe..c1d0ed2b8724 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2867,10 +2867,24 @@ extern int apply_to_existing_page_range(struct mm_struct *mm,
 
 extern void init_mem_debugging(void);
 #ifdef CONFIG_PAGE_POISONING
-extern bool page_poisoning_enabled(void);
 extern void kernel_poison_pages(struct page *page, int numpages, int enable);
+extern bool _page_poisoning_enabled_early;
+DECLARE_STATIC_KEY_FALSE(_page_poisoning_enabled);
+static inline bool page_poisoning_enabled(void)
+{
+	return _page_poisoning_enabled_early;
+}
+/*
+ * For use in fast paths after init_mem_debugging() has run, or when a
+ * false negative result is not harmful when called too early.
+ */
+static inline bool page_poisoning_enabled_static(void)
+{
+	return (static_branch_unlikely(&_page_poisoning_enabled));
+}
 #else
 static inline bool page_poisoning_enabled(void) { return false; }
+static inline bool page_poisoning_enabled_static(void) { return false; }
 static inline void kernel_poison_pages(struct page *page, int numpages,
 					int enable) { }
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b168c58ef337..2a1be197649d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -777,6 +777,17 @@ void init_mem_debugging()
 		}
 	}
 
+#ifdef CONFIG_PAGE_POISONING
+	/*
+	 * Page poisoning is debug page alloc for some arches. If
+	 * either of those options are enabled, enable poisoning.
+	 */
+	if (page_poisoning_enabled() ||
+			(!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
+			debug_pagealloc_enabled()))
+		static_branch_enable(&_page_poisoning_enabled);
+#endif
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	if (!debug_pagealloc_enabled())
 		return;
@@ -2208,7 +2219,7 @@ static inline int check_new_page(struct page *page)
 static inline bool free_pages_prezeroed(void)
 {
 	return (IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) &&
-		page_poisoning_enabled()) || want_init_on_free();
+		page_poisoning_enabled_static()) || want_init_on_free();
 }
 
 #ifdef CONFIG_DEBUG_VM
diff --git a/mm/page_poison.c b/mm/page_poison.c
index ae0482cded87..d1f06b70a779 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -8,45 +8,17 @@
 #include <linux/ratelimit.h>
 #include <linux/kasan.h>
 
-static DEFINE_STATIC_KEY_FALSE_RO(want_page_poisoning);
+bool _page_poisoning_enabled_early;
+EXPORT_SYMBOL(_page_poisoning_enabled_early);
+DEFINE_STATIC_KEY_FALSE_RO(_page_poisoning_enabled);
+EXPORT_SYMBOL(_page_poisoning_enabled);
 
 static int __init early_page_poison_param(char *buf)
 {
-	int ret;
-	bool tmp;
-
-	ret = strtobool(buf, &tmp);
-	if (ret)
-		return ret;
-
-	if (tmp)
-		static_branch_enable(&want_page_poisoning);
-	else
-		static_branch_disable(&want_page_poisoning);
-
-	return 0;
+	return kstrtobool(buf, &_page_poisoning_enabled_early);
 }
 early_param("page_poison", early_page_poison_param);
 
-/**
- * page_poisoning_enabled - check if page poisoning is enabled
- *
- * Return true if page poisoning is enabled, or false if not.
- */
-bool page_poisoning_enabled(void)
-{
-	/*
-	 * Assumes that debug_pagealloc_enabled is set before
-	 * memblock_free_all.
-	 * Page poisoning is debug page alloc for some arches. If
-	 * either of those options are enabled, enable poisoning.
-	 */
-	return (static_branch_unlikely(&want_page_poisoning) ||
-		(!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
-		debug_pagealloc_enabled()));
-}
-EXPORT_SYMBOL_GPL(page_poisoning_enabled);
-
 static void poison_page(struct page *page)
 {
 	void *addr = kmap_atomic(page);
@@ -127,7 +99,7 @@ static void unpoison_pages(struct page *page, int n)
 
 void kernel_poison_pages(struct page *page, int numpages, int enable)
 {
-	if (!page_poisoning_enabled())
+	if (!page_poisoning_enabled_static())
 		return;
 
 	if (enable)
-- 
2.29.0

