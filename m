Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A7E2B1934
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgKMKku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:40:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:39738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgKMKkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:40:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3AECFAEFB;
        Fri, 13 Nov 2020 10:40:48 +0000 (UTC)
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
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 3/5] kernel/power: allow hibernation with page_poison sanity checking
Date:   Fri, 13 Nov 2020 11:40:31 +0100
Message-Id: <20201113104033.22907-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113104033.22907-1-vbabka@suse.cz>
References: <20201113104033.22907-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page poisoning used to be incompatible with hibernation, as the state of
poisoned pages was lost after resume, thus enabling CONFIG_HIBERNATION forces
CONFIG_PAGE_POISONING_NO_SANITY. For the same reason, the poisoning with zeroes
variant CONFIG_PAGE_POISONING_ZERO used to disable hibernation. The latter
restriction was removed by commit 1ad1410f632d ("PM / Hibernate: allow
hibernation with PAGE_POISONING_ZERO") and similarly for init_on_free by commit
18451f9f9e58 ("PM: hibernate: fix crashes with init_on_free=1") by making sure
free pages are cleared after resume.

We can use the same mechanism to instead poison free pages with PAGE_POISON
after resume. This covers both zero and 0xAA patterns. Thus we can remove the
Kconfig restriction that disables page poison sanity checking when hibernation
is enabled.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com> # for hibernation
---
 include/linux/mm.h       |  1 +
 kernel/power/hibernate.c |  2 +-
 kernel/power/power.h     |  2 +-
 kernel/power/snapshot.c  | 14 +++++++++++---
 mm/Kconfig.debug         |  1 -
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5ab5358be2b3..b15000085ff2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2891,6 +2891,7 @@ static inline void kernel_unpoison_pages(struct page *page, int numpages)
 #else
 static inline bool page_poisoning_enabled(void) { return false; }
 static inline bool page_poisoning_enabled_static(void) { return false; }
+static inline void __kernel_poison_pages(struct page *page, int nunmpages) { }
 static inline void kernel_poison_pages(struct page *page, int numpages) { }
 static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
 #endif
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index d5d48404db37..559acef3fddb 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -329,7 +329,7 @@ static int create_image(int platform_mode)
 
 	if (!in_suspend) {
 		events_check_enabled = false;
-		clear_free_pages();
+		clear_or_poison_free_pages();
 	}
 
 	platform_leave(platform_mode);
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 24f12d534515..778bf431ec02 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -106,7 +106,7 @@ extern int create_basic_memory_bitmaps(void);
 extern void free_basic_memory_bitmaps(void);
 extern int hibernate_preallocate_memory(void);
 
-extern void clear_free_pages(void);
+extern void clear_or_poison_free_pages(void);
 
 /**
  *	Auxiliary structure used for reading the snapshot image data and
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index af534982062d..64b7aab9aee4 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1178,7 +1178,15 @@ void free_basic_memory_bitmaps(void)
 	pr_debug("Basic memory bitmaps freed\n");
 }
 
-void clear_free_pages(void)
+static void clear_or_poison_free_page(struct page *page)
+{
+	if (page_poisoning_enabled_static())
+		__kernel_poison_pages(page, 1);
+	else if (want_init_on_free())
+		clear_highpage(page);
+}
+
+void clear_or_poison_free_pages(void)
 {
 	struct memory_bitmap *bm = free_pages_map;
 	unsigned long pfn;
@@ -1186,12 +1194,12 @@ void clear_free_pages(void)
 	if (WARN_ON(!(free_pages_map)))
 		return;
 
-	if (IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) || want_init_on_free()) {
+	if (page_poisoning_enabled() || want_init_on_free()) {
 		memory_bm_position_reset(bm);
 		pfn = memory_bm_next_pfn(bm);
 		while (pfn != BM_END_OF_MAP) {
 			if (pfn_valid(pfn))
-				clear_highpage(pfn_to_page(pfn));
+				clear_or_poison_free_page(pfn_to_page(pfn));
 
 			pfn = memory_bm_next_pfn(bm);
 		}
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 864f129f1937..c57786ad5be9 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -64,7 +64,6 @@ config PAGE_OWNER
 
 config PAGE_POISONING
 	bool "Poison pages after freeing"
-	select PAGE_POISONING_NO_SANITY if HIBERNATION
 	help
 	  Fill the pages with poison patterns after free_pages() and verify
 	  the patterns before alloc_pages. The filling of the memory helps
-- 
2.29.2

