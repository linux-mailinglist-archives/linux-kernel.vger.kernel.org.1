Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39377268BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgINNKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgINNBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:01:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB73C061351
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=v4mRlLVz8AMSm1sdAYf6Zqwa2ax9GUax7tJyFxBJP4c=; b=r7NUBn4HsfyMPZEHvZXDedAQfR
        /ra65rrJOAXSZT0dsVc33AgTOwiHNe4wmmOJE7uyI28PlcGAp/Y31/b5/AHT86tBUBzePfaqeuiwx
        VpjE2ztuiaDcsWLGRxTQT09oN6ygYwJUefGsDjU57vADka9wapLfVN4rDfjDxcmuGvaTVR8sn5hmJ
        Je/nN/lLq+qNVjSIvMGAlXGwzqE0K2Mqshd6fVZQ5cFo3eAIgkDAuuhPvXICm9viRkJhLjDNZ5tpk
        ISekSRD5G5lVXrPH1GYwa3fStmKJn6go0EL52QtZ/1z+LCnXYD1D3t5pk/wXIny5L53FOohLUkdqZ
        frVsQjrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHo69-00030A-Gd; Mon, 14 Sep 2020 13:00:45 +0000
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
Subject: [PATCH v2 06/12] mm: Add an 'end' parameter to find_get_entries
Date:   Mon, 14 Sep 2020 14:00:36 +0100
Message-Id: <20200914130042.11442-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200914130042.11442-1-willy@infradead.org>
References: <20200914130042.11442-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simplifies the callers and leads to a more efficient implementation
since the XArray has this functionality already.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/pagemap.h |  4 ++--
 mm/filemap.c            |  9 +++++----
 mm/shmem.c              | 10 ++--------
 mm/swap.c               |  2 +-
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 869dc371b800..d440c6750757 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -414,8 +414,8 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 }
 
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
-			  unsigned int nr_entries, struct page **entries,
-			  pgoff_t *indices);
+		pgoff_t end, unsigned int nr_entries, struct page **entries,
+		pgoff_t *indices);
 unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 			pgoff_t end, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index 9f7f6b46aee4..6dc0a9b8c0fa 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1799,6 +1799,7 @@ static inline struct page *xas_find_get_entry(struct xa_state *xas,
  * find_get_entries - gang pagecache lookup
  * @mapping:	The address_space to search
  * @start:	The starting page cache index
+ * @end:	The final page index (inclusive).
  * @nr_entries:	The maximum number of entries
  * @entries:	Where the resulting entries are placed
  * @indices:	The cache indices corresponding to the entries in @entries
@@ -1822,9 +1823,9 @@ static inline struct page *xas_find_get_entry(struct xa_state *xas,
  *
  * Return: the number of pages and shadow entries which were found.
  */
-unsigned find_get_entries(struct address_space *mapping,
-			  pgoff_t start, unsigned int nr_entries,
-			  struct page **entries, pgoff_t *indices)
+unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
+		pgoff_t end, unsigned int nr_entries, struct page **entries,
+		pgoff_t *indices)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
 	struct page *page;
@@ -1834,7 +1835,7 @@ unsigned find_get_entries(struct address_space *mapping,
 		return 0;
 
 	rcu_read_lock();
-	while ((page = xas_find_get_entry(&xas, ULONG_MAX, XA_PRESENT))) {
+	while ((page = xas_find_get_entry(&xas, end, XA_PRESENT))) {
 		/*
 		 * Terminate early on finding a THP, to allow the caller to
 		 * handle it all at once; but continue if this is hugetlbfs.
diff --git a/mm/shmem.c b/mm/shmem.c
index a73ce8ce28e3..404e45c285ca 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -911,8 +911,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			struct page *page = pvec.pages[i];
 
 			index = indices[i];
-			if (index >= end)
-				break;
 
 			if (xa_is_value(page)) {
 				if (unfalloc)
@@ -965,9 +963,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	while (index < end) {
 		cond_resched();
 
-		pvec.nr = find_get_entries(mapping, index,
-				min(end - index, (pgoff_t)PAGEVEC_SIZE),
-				pvec.pages, indices);
+		pvec.nr = find_get_entries(mapping, index, end - 1,
+				PAGEVEC_SIZE, pvec.pages, indices);
 		if (!pvec.nr) {
 			/* If all gone or hole-punch or unfalloc, we're done */
 			if (index == start || end != -1)
@@ -980,9 +977,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			struct page *page = pvec.pages[i];
 
 			index = indices[i];
-			if (index >= end)
-				break;
-
 			if (xa_is_value(page)) {
 				if (unfalloc)
 					continue;
diff --git a/mm/swap.c b/mm/swap.c
index d16d65d9b4e0..fcf6ccb94b09 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1060,7 +1060,7 @@ unsigned pagevec_lookup_entries(struct pagevec *pvec,
 				pgoff_t start, unsigned nr_entries,
 				pgoff_t *indices)
 {
-	pvec->nr = find_get_entries(mapping, start, nr_entries,
+	pvec->nr = find_get_entries(mapping, start, ULONG_MAX, nr_entries,
 				    pvec->pages, indices);
 	return pagevec_count(pvec);
 }
-- 
2.28.0

