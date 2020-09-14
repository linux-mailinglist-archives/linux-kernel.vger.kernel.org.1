Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7024A268BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgINNGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgINNBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:01:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15B6C0612F2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pazHez88nGdskBWp4sJi5WftMxGg8yRxvCKjKEILDL0=; b=MnBLPqBNCd8jVwY9GMSDRsgik/
        /3gp5v3b7FkI3r9l61LfkAavKeaN9RNQe/VETIblVarMFwJ905w3VFnrr6a0feL9+SSos1ugD3Ns7
        8pfetF6qe9s0n5fNu65OIp7uiBK4HVeITGEi5XHmu6HSMQUbuBglBOr76h5nDke9pDcglKFVwptSH
        8/p/OnaS8rkl0eYsE1R9bzYousYXSoFu3Ike44H9UiXEjg5XZ0r4OXFY4RQ+qaz4/7GXyqW640+H8
        xh2w1NpRvd0BBWXBMnaLlWDvOSa9+IV25r1IAegzwUXAfLom6rlCpM7pwnWxPF7r+pfzJf2qnT2pG
        WbMjQErQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHo69-000302-8t; Mon, 14 Sep 2020 13:00:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/12] mm: Add and use find_lock_entries
Date:   Mon, 14 Sep 2020 14:00:35 +0100
Message-Id: <20200914130042.11442-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200914130042.11442-1-willy@infradead.org>
References: <20200914130042.11442-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have three functions (shmem_undo_range(), truncate_inode_pages_range()
and invalidate_mapping_pages()) which want exactly this function, so
add it to filemap.c.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c  | 57 ++++++++++++++++++++++++++++++++
 mm/internal.h |  2 ++
 mm/shmem.c    | 22 +++----------
 mm/truncate.c | 90 +++++++--------------------------------------------
 4 files changed, 75 insertions(+), 96 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 5662f932b85b..9f7f6b46aee4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1854,6 +1854,63 @@ unsigned find_get_entries(struct address_space *mapping,
 	return ret;
 }
 
+/**
+ * find_lock_entries - Find a batch of pagecache entries.
+ * @mapping:	The address_space to search.
+ * @start:	The starting page cache index.
+ * @end:	The final page index (inclusive).
+ * @pvec:	Where the resulting entries are placed.
+ * @indices:	The cache indices of the entries in @pvec.
+ *
+ * find_lock_entries() will return a batch of entries from @mapping.
+ * Swap, shadow and DAX entries are included.  Pages are returned
+ * locked and with an incremented refcount.  Pages which are locked by
+ * somebody else or under writeback are skipped.  Only the head page of
+ * a THP is returned.  Pages which are partially outside the range are
+ * not returned.
+ *
+ * The entries have ascending indexes.  The indices may not be consecutive
+ * due to not-present entries, THP pages, pages which could not be locked
+ * or pages under writeback.
+ *
+ * Return: The number of entries which were found.
+ */
+unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
+		pgoff_t end, struct pagevec *pvec, pgoff_t *indices)
+{
+	XA_STATE(xas, &mapping->i_pages, start);
+	struct page *page;
+
+	rcu_read_lock();
+	while ((page = xas_find_get_entry(&xas, end, XA_PRESENT))) {
+		if (!xa_is_value(page)) {
+			if (page->index < start)
+				goto put;
+			VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
+			if (page->index + thp_nr_pages(page) - 1 > end)
+				goto put;
+			if (!trylock_page(page))
+				goto put;
+			if (page->mapping != mapping || PageWriteback(page))
+				goto unlock;
+		}
+		indices[pvec->nr] = xas.xa_index;
+		if (!pagevec_add(pvec, page))
+			break;
+		goto next;
+unlock:
+		unlock_page(page);
+put:
+		put_page(page);
+next:
+		if (!xa_is_value(page) && PageTransHuge(page))
+			xas_set(&xas, page->index + thp_nr_pages(page));
+	}
+	rcu_read_unlock();
+
+	return pagevec_count(pvec);
+}
+
 /**
  * find_get_pages_range - gang pagecache lookup
  * @mapping:	The address_space to search
diff --git a/mm/internal.h b/mm/internal.h
index 6345b08ce86c..1c5f4425ed74 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -62,6 +62,8 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 
 struct page *find_get_entry(struct address_space *mapping, pgoff_t index);
 struct page *find_lock_entry(struct address_space *mapping, pgoff_t index);
+unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
+		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 
 /**
  * page_evictable - test whether a page is evictable
diff --git a/mm/shmem.c b/mm/shmem.c
index b65263d9bb67..a73ce8ce28e3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -905,12 +905,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 
 	pagevec_init(&pvec);
 	index = start;
-	while (index < end) {
-		pvec.nr = find_get_entries(mapping, index,
-			min(end - index, (pgoff_t)PAGEVEC_SIZE),
-			pvec.pages, indices);
-		if (!pvec.nr)
-			break;
+	while (index < end && find_lock_entries(mapping, index, end - 1,
+			&pvec, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
@@ -925,18 +921,10 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 								index, page);
 				continue;
 			}
+			index += thp_nr_pages(page) - 1;
 
-			VM_BUG_ON_PAGE(page_to_pgoff(page) != index, page);
-
-			if (!trylock_page(page))
-				continue;
-
-			if ((!unfalloc || !PageUptodate(page)) &&
-			    page_mapping(page) == mapping) {
-				VM_BUG_ON_PAGE(PageWriteback(page), page);
-				if (shmem_punch_compound(page, start, end))
-					truncate_inode_page(mapping, page);
-			}
+			if (!unfalloc || !PageUptodate(page))
+				truncate_inode_page(mapping, page);
 			unlock_page(page);
 		}
 		pagevec_remove_exceptionals(&pvec);
diff --git a/mm/truncate.c b/mm/truncate.c
index 1cc93b57fb41..5dbe0c77b5ac 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -326,51 +326,19 @@ void truncate_inode_pages_range(struct address_space *mapping,
 
 	pagevec_init(&pvec);
 	index = start;
-	while (index < end && pagevec_lookup_entries(&pvec, mapping, index,
-			min(end - index, (pgoff_t)PAGEVEC_SIZE),
-			indices)) {
-		/*
-		 * Pagevec array has exceptional entries and we may also fail
-		 * to lock some pages. So we store pages that can be deleted
-		 * in a new pagevec.
-		 */
-		struct pagevec locked_pvec;
-
-		pagevec_init(&locked_pvec);
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
-
-			/* We rely upon deletion not changing page->index */
-			index = indices[i];
-			if (index >= end)
-				break;
-
-			if (xa_is_value(page))
-				continue;
-
-			if (!trylock_page(page))
-				continue;
-			WARN_ON(page_to_index(page) != index);
-			if (PageWriteback(page)) {
-				unlock_page(page);
-				continue;
-			}
-			if (page->mapping != mapping) {
-				unlock_page(page);
-				continue;
-			}
-			pagevec_add(&locked_pvec, page);
-		}
-		for (i = 0; i < pagevec_count(&locked_pvec); i++)
-			truncate_cleanup_page(mapping, locked_pvec.pages[i]);
-		delete_from_page_cache_batch(mapping, &locked_pvec);
-		for (i = 0; i < pagevec_count(&locked_pvec); i++)
-			unlock_page(locked_pvec.pages[i]);
+	while (index < end && find_lock_entries(mapping, index, end - 1,
+			&pvec, indices)) {
+		index = indices[pagevec_count(&pvec) - 1] + 1;
 		truncate_exceptional_pvec_entries(mapping, &pvec, indices, end);
+		for (i = 0; i < pagevec_count(&pvec); i++)
+			truncate_cleanup_page(mapping, pvec.pages[i]);
+		delete_from_page_cache_batch(mapping, &pvec);
+		for (i = 0; i < pagevec_count(&pvec); i++)
+			unlock_page(pvec.pages[i]);
 		pagevec_release(&pvec);
 		cond_resched();
-		index++;
 	}
+
 	if (partial_start) {
 		struct page *page = find_lock_page(mapping, start - 1);
 		if (page) {
@@ -554,9 +522,7 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
 	int i;
 
 	pagevec_init(&pvec);
-	while (index <= end && pagevec_lookup_entries(&pvec, mapping, index,
-			min(end - index, (pgoff_t)PAGEVEC_SIZE - 1) + 1,
-			indices)) {
+	while (find_lock_entries(mapping, index, end, &pvec, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
@@ -570,39 +536,7 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
 							     page);
 				continue;
 			}
-
-			if (!trylock_page(page))
-				continue;
-
-			WARN_ON(page_to_index(page) != index);
-
-			/* Middle of THP: skip */
-			if (PageTransTail(page)) {
-				unlock_page(page);
-				continue;
-			} else if (PageTransHuge(page)) {
-				index += HPAGE_PMD_NR - 1;
-				i += HPAGE_PMD_NR - 1;
-				/*
-				 * 'end' is in the middle of THP. Don't
-				 * invalidate the page as the part outside of
-				 * 'end' could be still useful.
-				 */
-				if (index > end) {
-					unlock_page(page);
-					continue;
-				}
-
-				/* Take a pin outside pagevec */
-				get_page(page);
-
-				/*
-				 * Drop extra pins before trying to invalidate
-				 * the huge page.
-				 */
-				pagevec_remove_exceptionals(&pvec);
-				pagevec_release(&pvec);
-			}
+			index += thp_nr_pages(page) - 1;
 
 			ret = invalidate_inode_page(page);
 			unlock_page(page);
@@ -612,8 +546,6 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
 			 */
 			if (!ret)
 				deactivate_file_page(page);
-			if (PageTransHuge(page))
-				put_page(page);
 			count += ret;
 		}
 		pagevec_remove_exceptionals(&pvec);
-- 
2.28.0

