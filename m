Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD22C268BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgINNLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgINNBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:01:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A50C061352
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Pg1I1M+L0Ys2evtsmU1Fe0vXAju57Ok+EiNjdCZkzBo=; b=FRF15Cbm4BW3gtZLIzi8zigIVn
        tSobNvruc9L4hznRDowLYloHoD17tu1AiLkm6e4t4vfdeYw/OF01862uBArg84UqiVU/r7dUgSxgm
        giJm8qvU3aG5p+lYK/1zOJZVNrYkm2Cv5wBWVKECZNRcO8QiSKizG+St5EUbjX1+w0+pU2j+1RKPk
        npYvL12q1MIM/pauissEBWOn+7De/VxfTI6Jw9BsVXVIHVc0XjSj/hchZ5h91vQFFFlQ6Wq/fcRVe
        fagai1tjp2GZvod8WxmOHyJF08EiJeFlXgv0QjJCHj88Ps689EgBNKy8UcMNlw9NI2Pb8qQGMBTkL
        lOvqDpNA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHo68-0002zi-G6; Mon, 14 Sep 2020 13:00:44 +0000
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
Subject: [PATCH v2 01/12] mm: Make pagecache tagged lookups return only head pages
Date:   Mon, 14 Sep 2020 14:00:31 +0100
Message-Id: <20200914130042.11442-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200914130042.11442-1-willy@infradead.org>
References: <20200914130042.11442-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pagecache tags are used for dirty page writeback.  Since dirtiness is
tracked on a per-THP basis, we only want to return the head page rather
than each subpage of a tagged page.  All the filesystems which use huge
pages today are in-memory, so there are no tagged huge pages today.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f5fda3038782..7d8cf1a25628 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1968,7 +1968,7 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
 EXPORT_SYMBOL(find_get_pages_contig);
 
 /**
- * find_get_pages_range_tag - find and return pages in given range matching @tag
+ * find_get_pages_range_tag - Find and return head pages matching @tag.
  * @mapping:	the address_space to search
  * @index:	the starting page index
  * @end:	The final page index (inclusive)
@@ -1976,8 +1976,8 @@ EXPORT_SYMBOL(find_get_pages_contig);
  * @nr_pages:	the maximum number of pages
  * @pages:	where the resulting pages are placed
  *
- * Like find_get_pages, except we only return pages which are tagged with
- * @tag.   We update @index to index the next page for the traversal.
+ * Like find_get_pages(), except we only return head pages which are tagged
+ * with @tag.   We update @index to index the next page for the traversal.
  *
  * Return: the number of pages which were found.
  */
@@ -2011,9 +2011,9 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 		if (unlikely(page != xas_reload(&xas)))
 			goto put_page;
 
-		pages[ret] = find_subpage(page, xas.xa_index);
+		pages[ret] = page;
 		if (++ret == nr_pages) {
-			*index = xas.xa_index + 1;
+			*index = page->index + thp_nr_pages(page);
 			goto out;
 		}
 		continue;
-- 
2.28.0

