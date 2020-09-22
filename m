Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A532743AB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgIVN5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:57:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:33640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgIVN5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:57:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 000A1AFE5;
        Tue, 22 Sep 2020 13:57:46 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     aris@ruivo.org, naoya.horiguchi@nec.com, mhocko@kernel.org,
        tony.luck@intel.com, cai@lca.pw, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v7 10/14] mm,hwpoison: refactor soft_offline_huge_page and __soft_offline_page
Date:   Tue, 22 Sep 2020 15:56:46 +0200
Message-Id: <20200922135650.1634-11-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200922135650.1634-1-osalvador@suse.de>
References: <20200922135650.1634-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merging soft_offline_huge_page and __soft_offline_page let us get rid of
quite some duplicated code, and makes the code much easier to follow.

Now, __soft_offline_page will handle both normal and hugetlb pages.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory-failure.c | 182 ++++++++++++++++++++------------------------
 1 file changed, 82 insertions(+), 100 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index cc8757282860..7c122cca9f31 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -65,13 +65,31 @@ int sysctl_memory_failure_recovery __read_mostly = 1;
 
 atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
-static void page_handle_poison(struct page *page, bool release)
+static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
 {
+	if (hugepage_or_freepage) {
+		/*
+		 * Doing this check for free pages is also fine since dissolve_free_huge_page
+		 * returns 0 for non-hugetlb pages as well.
+		 */
+		if (dissolve_free_huge_page(page) || !take_page_off_buddy(page))
+			/*
+			 * We could fail to take off the target page from buddy
+			 * for example due to racy page allocaiton, but that's
+			 * acceptable because soft-offlined page is not broken
+			 * and if someone really want to use it, they should
+			 * take it.
+			 */
+			return false;
+	}
+
 	SetPageHWPoison(page);
 	if (release)
 		put_page(page);
 	page_ref_inc(page);
 	num_poisoned_pages_inc();
+
+	return true;
 }
 
 #if defined(CONFIG_HWPOISON_INJECT) || defined(CONFIG_HWPOISON_INJECT_MODULE)
@@ -1725,63 +1743,51 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 	return ret;
 }
 
-static int soft_offline_huge_page(struct page *page, int flags)
+static bool isolate_page(struct page *page, struct list_head *pagelist)
 {
-	int ret;
-	unsigned long pfn = page_to_pfn(page);
-	struct page *hpage = compound_head(page);
-	LIST_HEAD(pagelist);
+	bool isolated = false;
+	bool lru = PageLRU(page);
 
-	/*
-	 * This double-check of PageHWPoison is to avoid the race with
-	 * memory_failure(). See also comment in __soft_offline_page().
-	 */
-	lock_page(hpage);
-	if (PageHWPoison(hpage)) {
-		unlock_page(hpage);
-		put_page(hpage);
-		pr_info("soft offline: %#lx hugepage already poisoned\n", pfn);
-		return -EBUSY;
+	if (PageHuge(page)) {
+		isolated = isolate_huge_page(page, pagelist);
+	} else {
+		if (lru)
+			isolated = !isolate_lru_page(page);
+		else
+			isolated = !isolate_movable_page(page, ISOLATE_UNEVICTABLE);
+
+		if (isolated)
+			list_add(&page->lru, pagelist);
 	}
-	unlock_page(hpage);
 
-	ret = isolate_huge_page(hpage, &pagelist);
+	if (isolated && lru)
+		inc_node_page_state(page, NR_ISOLATED_ANON +
+				    page_is_file_lru(page));
+
 	/*
-	 * get_any_page() and isolate_huge_page() takes a refcount each,
-	 * so need to drop one here.
+	 * If we succeed to isolate the page, we grabbed another refcount on
+	 * the page, so we can safely drop the one we got from get_any_pages().
+	 * If we failed to isolate the page, it means that we cannot go further
+	 * and we will return an error, so drop the reference we got from
+	 * get_any_pages() as well.
 	 */
-	put_page(hpage);
-	if (!ret) {
-		pr_info("soft offline: %#lx hugepage failed to isolate\n", pfn);
-		return -EBUSY;
-	}
-
-	ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
-				MIGRATE_SYNC, MR_MEMORY_FAILURE);
-	if (ret) {
-		pr_info("soft offline: %#lx: hugepage migration failed %d, type %lx (%pGp)\n",
-			pfn, ret, page->flags, &page->flags);
-		if (!list_empty(&pagelist))
-			putback_movable_pages(&pagelist);
-		if (ret > 0)
-			ret = -EIO;
-	} else {
-		/*
-		 * We set PG_hwpoison only when we were able to take the page
-		 * off the buddy.
-		 */
-		if (!dissolve_free_huge_page(page) && take_page_off_buddy(page))
-			page_handle_poison(page, false);
-		else
-			ret = -EBUSY;
-	}
-	return ret;
+	put_page(page);
+	return isolated;
 }
 
-static int __soft_offline_page(struct page *page, int flags)
+/*
+ * __soft_offline_page handles hugetlb-pages and non-hugetlb pages.
+ * If the page is a non-dirty unmapped page-cache page, it simply invalidates.
+ * If the page is mapped, it migrates the contents over.
+ */
+static int __soft_offline_page(struct page *page)
 {
-	int ret;
+	int ret = 0;
 	unsigned long pfn = page_to_pfn(page);
+	struct page *hpage = compound_head(page);
+	char const *msg_page[] = {"page", "hugepage"};
+	bool huge = PageHuge(page);
+	LIST_HEAD(pagelist);
 
 	/*
 	 * Check PageHWPoison again inside page lock because PageHWPoison
@@ -1790,98 +1796,74 @@ static int __soft_offline_page(struct page *page, int flags)
 	 * so there's no race between soft_offline_page() and memory_failure().
 	 */
 	lock_page(page);
-	wait_on_page_writeback(page);
+	if (!PageHuge(page))
+		wait_on_page_writeback(page);
 	if (PageHWPoison(page)) {
 		unlock_page(page);
 		put_page(page);
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
 		return -EBUSY;
 	}
-	/*
-	 * Try to invalidate first. This should work for
-	 * non dirty unmapped page cache pages.
-	 */
-	ret = invalidate_inode_page(page);
+
+	if (!PageHuge(page))
+		/*
+		 * Try to invalidate first. This should work for
+		 * non dirty unmapped page cache pages.
+		 */
+		ret = invalidate_inode_page(page);
 	unlock_page(page);
+
 	/*
 	 * RED-PEN would be better to keep it isolated here, but we
 	 * would need to fix isolation locking first.
 	 */
-	if (ret == 1) {
+	if (ret) {
 		pr_info("soft_offline: %#lx: invalidated\n", pfn);
-		page_handle_poison(page, true);
+		page_handle_poison(page, false, true);
 		return 0;
 	}
 
-	/*
-	 * Simple invalidation didn't work.
-	 * Try to migrate to a new page instead. migrate.c
-	 * handles a large number of cases for us.
-	 */
-	if (PageLRU(page))
-		ret = isolate_lru_page(page);
-	else
-		ret = isolate_movable_page(page, ISOLATE_UNEVICTABLE);
-	/*
-	 * Drop page reference which is came from get_any_page()
-	 * successful isolate_lru_page() already took another one.
-	 */
-	put_page(page);
-	if (!ret) {
-		LIST_HEAD(pagelist);
-		/*
-		 * After isolated lru page, the PageLRU will be cleared,
-		 * so use !__PageMovable instead for LRU page's mapping
-		 * cannot have PAGE_MAPPING_MOVABLE.
-		 */
-		if (!__PageMovable(page))
-			inc_node_page_state(page, NR_ISOLATED_ANON +
-						page_is_file_lru(page));
-		list_add(&page->lru, &pagelist);
+	if (isolate_page(hpage, &pagelist)) {
 		ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
 					MIGRATE_SYNC, MR_MEMORY_FAILURE);
 		if (!ret) {
-			page_handle_poison(page, true);
+			bool release = !huge;
+
+			if (!page_handle_poison(page, huge, release))
+				ret = -EBUSY;
 		} else {
 			if (!list_empty(&pagelist))
 				putback_movable_pages(&pagelist);
 
-			pr_info("soft offline: %#lx: migration failed %d, type %lx (%pGp)\n",
-				pfn, ret, page->flags, &page->flags);
+			pr_info("soft offline: %#lx: %s migration failed %d, type %lx (%pGp)\n",
+				pfn, msg_page[huge], ret, page->flags, &page->flags);
 			if (ret > 0)
 				ret = -EIO;
 		}
 	} else {
-		pr_info("soft offline: %#lx: isolation failed: %d, page count %d, type %lx (%pGp)\n",
-			pfn, ret, page_count(page), page->flags, &page->flags);
+		pr_info("soft offline: %#lx: %s isolation failed: %d, page count %d, type %lx (%pGp)\n",
+			pfn, msg_page[huge], ret, page_count(page), page->flags, &page->flags);
+		ret = -EBUSY;
 	}
 	return ret;
 }
 
-static int soft_offline_in_use_page(struct page *page, int flags)
+static int soft_offline_in_use_page(struct page *page)
 {
-	int ret;
 	struct page *hpage = compound_head(page);
 
 	if (!PageHuge(page) && PageTransHuge(hpage))
 		if (try_to_split_thp_page(page, "soft offline") < 0)
 			return -EBUSY;
-
-	if (PageHuge(page))
-		ret = soft_offline_huge_page(page, flags);
-	else
-		ret = __soft_offline_page(page, flags);
-	return ret;
+	return __soft_offline_page(page);
 }
 
 static int soft_offline_free_page(struct page *page)
 {
-	int rc = -EBUSY;
+	int rc = 0;
 
-	if (!dissolve_free_huge_page(page) && take_page_off_buddy(page)) {
-		page_handle_poison(page, false);
-		rc = 0;
-	}
+	if (!page_handle_poison(page, true, false))
+		rc = -EBUSY;
 
 	return rc;
 }
@@ -1932,7 +1914,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 	put_online_mems();
 
 	if (ret > 0)
-		ret = soft_offline_in_use_page(page, flags);
+		ret = soft_offline_in_use_page(page);
 	else if (ret == 0)
 		ret = soft_offline_free_page(page);
 
-- 
2.26.2

