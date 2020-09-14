Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DD6268BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgINNDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgINNBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:01:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9846AC061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OLAOtiQJj0p7soapL1XVM7TPxz0RKAcScdgfX62Cymg=; b=hlDUvXdjv3VN7vmBYMmSuhcOLU
        ltWfmuOZlJNZuiCs8f8I/57YliBe5+bl603wvkGHA7lru2G04N3abfN4y8tFirPdnwk3kZxW0S0HX
        pUz0DMcH931OKwmj5X9ghvKHPvqZnpog7eWvKVQyvl9n73ChOgY868NTsQ6jV3noj9wQEFoIQwskx
        CJFijfWZM0KzsCvLZrgz+oydiOHoVjRB60sBjvUJP7d6HXpGCZveK4VaGAcIAbYqbbjDrqGm8lP5+
        DRmLn9Ro096vhwXkkHq+Hhu+eev4AwQjPqa2nPTHOHtJtxXZc8Noo02mQuqZrWqDk1H1Vwl+YgIgE
        mB5aGC8g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHo6B-00030t-83; Mon, 14 Sep 2020 13:00:47 +0000
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
Subject: [PATCH v2 12/12] mm/filemap: Return only head pages from find_get_entries
Date:   Mon, 14 Sep 2020 14:00:42 +0100
Message-Id: <20200914130042.11442-13-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200914130042.11442-1-willy@infradead.org>
References: <20200914130042.11442-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers now expect head (and base) pages, and can handle multiple
head pages in a single batch, so make find_get_entries() behave that way.
Also take the opportunity to make it use the pagevec infrastructure
instead of open-coding how pvecs behave.  This has the side-effect of
being able to append to a pagevec with existing contents, although we
don't make use of that functionality anywhere yet.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  2 --
 mm/filemap.c            | 36 ++++++++----------------------------
 mm/internal.h           |  2 ++
 3 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 788c280737e0..50d2c39b47ab 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -413,8 +413,6 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 	return head + (index & (thp_nr_pages(head) - 1));
 }
 
-unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
-		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 			pgoff_t end, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index a4ad294a34dc..dbe3f7050897 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1807,49 +1807,29 @@ static inline struct page *xas_find_get_entry(struct xa_state *xas,
  * the mapping.  The entries are placed in @pvec.  find_get_entries()
  * takes a reference on any actual pages it returns.
  *
- * The search returns a group of mapping-contiguous page cache entries
- * with ascending indexes.  There may be holes in the indices due to
- * not-present pages.
+ * The entries have ascending indexes.  The indices may not be consecutive
+ * due to not-present entries or THPs.
  *
  * Any shadow entries of evicted pages, or swap entries from
  * shmem/tmpfs, are included in the returned array.
  *
- * If it finds a Transparent Huge Page, head or tail, find_get_entries()
- * stops at that page: the caller is likely to have a better way to handle
- * the compound page as a whole, and then skip its extent, than repeatedly
- * calling find_get_entries() to return all its tails.
- *
- * Return: the number of pages and shadow entries which were found.
+ * Return: The number of entries which were found.
  */
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct pagevec *pvec, pgoff_t *indices)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
 	struct page *page;
-	unsigned int ret = 0;
-	unsigned nr_entries = PAGEVEC_SIZE;
 
 	rcu_read_lock();
 	while ((page = xas_find_get_entry(&xas, end, XA_PRESENT))) {
-		/*
-		 * Terminate early on finding a THP, to allow the caller to
-		 * handle it all at once; but continue if this is hugetlbfs.
-		 */
-		if (!xa_is_value(page) && PageTransHuge(page) &&
-				!PageHuge(page)) {
-			page = find_subpage(page, xas.xa_index);
-			nr_entries = ret + 1;
-		}
-
-		indices[ret] = xas.xa_index;
-		pvec->pages[ret] = page;
-		if (++ret == nr_entries)
+		indices[pvec->nr] = xas.xa_index;
+		if (!pagevec_add(pvec, page))
 			break;
 	}
 	rcu_read_unlock();
 
-	pvec->nr = ret;
-	return ret;
+	return pagevec_count(pvec);
 }
 
 /**
@@ -1868,8 +1848,8 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
  * not returned.
  *
  * The entries have ascending indexes.  The indices may not be consecutive
- * due to not-present entries, THP pages, pages which could not be locked
- * or pages under writeback.
+ * due to not-present entries, THPs, pages which could not be locked or
+ * pages under writeback.
  *
  * Return: The number of entries which were found.
  */
diff --git a/mm/internal.h b/mm/internal.h
index d17d9060902f..55da9860a54b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -62,6 +62,8 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 
 struct page *find_get_entry(struct address_space *mapping, pgoff_t index);
 struct page *find_lock_entry(struct address_space *mapping, pgoff_t index);
+unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
+		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 
-- 
2.28.0

