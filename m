Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6126A268BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgINNHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgINNBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:01:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603FAC06121C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EHgzdRosBMsz0w0GEEdwo/W7ei2Jp7MgX6g3BY09CJk=; b=gDn66RgtJXXmxOQbT+bHpRicPg
        QRqGFAlitj5356PJyc2I/jZtYMdlOl5H0SZ+QgfNlzqtRSKr7WmwCx71OAgBP7AyW2Urvi2EuSWJl
        pqRXY5QxeF9sHBXEu8CybYYVGJ6L+ly6sSEz9w1t5aR7/zGkyLHvv4XRAxdKulMEqYxSezQBfahD5
        hgQKwQpB3Bc426SoBubGjDftU5Qwjau0qPy/5V+dGTS4TAZB2Vnwc/T69ei3uBRZqPuioJ7fiN+4t
        pysdnw4fBtaxKOaKz0D5+4roBgqXqOR+D95NhFXMT2xMD83P69s5A+cG1dNtjiFDYdt/4OzjR13XF
        QP4v67MQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHo68-0002zr-Th; Mon, 14 Sep 2020 13:00:44 +0000
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
Subject: [PATCH v2 03/12] mm/filemap: Add helper for finding pages
Date:   Mon, 14 Sep 2020 14:00:33 +0100
Message-Id: <20200914130042.11442-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200914130042.11442-1-willy@infradead.org>
References: <20200914130042.11442-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a lot of common code in find_get_entries(),
find_get_pages_range() and find_get_pages_range_tag().  Factor out
xas_find_get_entry() which simplifies all three functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 98 +++++++++++++++++++++++-----------------------------
 1 file changed, 43 insertions(+), 55 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7d8cf1a25628..d8f5ff07eb9c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1758,6 +1758,43 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 }
 EXPORT_SYMBOL(pagecache_get_page);
 
+static inline struct page *xas_find_get_entry(struct xa_state *xas,
+		pgoff_t max, xa_mark_t mark)
+{
+	struct page *page;
+
+retry:
+	if (mark == XA_PRESENT)
+		page = xas_find(xas, max);
+	else
+		page = xas_find_marked(xas, max, mark);
+
+	if (xas_retry(xas, page))
+		goto retry;
+	/*
+	 * A shadow entry of a recently evicted page, a swap
+	 * entry from shmem/tmpfs or a DAX entry.  Return it
+	 * without attempting to raise page count.
+	 */
+	if (!page || xa_is_value(page))
+		return page;
+
+	if (!page_cache_get_speculative(page))
+		goto reset;
+
+	/* Has the page moved or been split? */
+	if (unlikely(page != xas_reload(xas))) {
+		put_page(page);
+		goto reset;
+	}
+	VM_BUG_ON_PAGE(!thp_contains(page, xas->xa_index), page);
+
+	return page;
+reset:
+	xas_reset(xas);
+	goto retry;
+}
+
 /**
  * find_get_entries - gang pagecache lookup
  * @mapping:	The address_space to search
@@ -1797,42 +1834,21 @@ unsigned find_get_entries(struct address_space *mapping,
 		return 0;
 
 	rcu_read_lock();
-	xas_for_each(&xas, page, ULONG_MAX) {
-		if (xas_retry(&xas, page))
-			continue;
-		/*
-		 * A shadow entry of a recently evicted page, a swap
-		 * entry from shmem/tmpfs or a DAX entry.  Return it
-		 * without attempting to raise page count.
-		 */
-		if (xa_is_value(page))
-			goto export;
-
-		if (!page_cache_get_speculative(page))
-			goto retry;
-
-		/* Has the page moved or been split? */
-		if (unlikely(page != xas_reload(&xas)))
-			goto put_page;
-
+	while ((page = xas_find_get_entry(&xas, ULONG_MAX, XA_PRESENT))) {
 		/*
 		 * Terminate early on finding a THP, to allow the caller to
 		 * handle it all at once; but continue if this is hugetlbfs.
 		 */
-		if (PageTransHuge(page) && !PageHuge(page)) {
+		if (!xa_is_value(page) && PageTransHuge(page) &&
+				!PageHuge(page)) {
 			page = find_subpage(page, xas.xa_index);
 			nr_entries = ret + 1;
 		}
-export:
+
 		indices[ret] = xas.xa_index;
 		entries[ret] = page;
 		if (++ret == nr_entries)
 			break;
-		continue;
-put_page:
-		put_page(page);
-retry:
-		xas_reset(&xas);
 	}
 	rcu_read_unlock();
 	return ret;
@@ -1871,30 +1887,16 @@ unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 		return 0;
 
 	rcu_read_lock();
-	xas_for_each(&xas, page, end) {
-		if (xas_retry(&xas, page))
-			continue;
+	while ((page = xas_find_get_entry(&xas, end, XA_PRESENT))) {
 		/* Skip over shadow, swap and DAX entries */
 		if (xa_is_value(page))
 			continue;
 
-		if (!page_cache_get_speculative(page))
-			goto retry;
-
-		/* Has the page moved or been split? */
-		if (unlikely(page != xas_reload(&xas)))
-			goto put_page;
-
 		pages[ret] = find_subpage(page, xas.xa_index);
 		if (++ret == nr_pages) {
 			*start = xas.xa_index + 1;
 			goto out;
 		}
-		continue;
-put_page:
-		put_page(page);
-retry:
-		xas_reset(&xas);
 	}
 
 	/*
@@ -1993,9 +1995,7 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 		return 0;
 
 	rcu_read_lock();
-	xas_for_each_marked(&xas, page, end, tag) {
-		if (xas_retry(&xas, page))
-			continue;
+	while ((page = xas_find_get_entry(&xas, end, tag))) {
 		/*
 		 * Shadow entries should never be tagged, but this iteration
 		 * is lockless so there is a window for page reclaim to evict
@@ -2004,23 +2004,11 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 		if (xa_is_value(page))
 			continue;
 
-		if (!page_cache_get_speculative(page))
-			goto retry;
-
-		/* Has the page moved or been split? */
-		if (unlikely(page != xas_reload(&xas)))
-			goto put_page;
-
 		pages[ret] = page;
 		if (++ret == nr_pages) {
 			*index = page->index + thp_nr_pages(page);
 			goto out;
 		}
-		continue;
-put_page:
-		put_page(page);
-retry:
-		xas_reset(&xas);
 	}
 
 	/*
-- 
2.28.0

