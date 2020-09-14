Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10E6268BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgINNJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgINNBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:01:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9CCC061355
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uGAwZnkn87pwanHSJb4fYgmseaVLFFvMj2rf/LwreS0=; b=UcmAqdO0gGOB8BAVcvtqwyeVtE
        tweSp8hSMUS03RaY23JdxfwMtjP3Y1v2aKCHTJQfBmtTxzhx03T7xWLfCsHzEwYUKt0BEsQm1xKxX
        xjS4VdmLU40hgQ6yexi2ShxOBHnpuGgnYm4jmtFfyoCOCQnVdRhuZW0hIM4XA5akCLnGhh/06kAHe
        5t6oxvDtat206x23o9C8dyOw65/zGEFtmnEJGO+jzveHuyVSQ+24U/yU4vTw+0mH7dq4mda+72MqO
        DFcj6MmpAW35JLZzmej+U1fQKo/XEOCHb00LSe3pAqLZKf0dZadN55Y6x2ceay9n6igGSLJQFB++Q
        EYTVaxNw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHo6A-00030I-56; Mon, 14 Sep 2020 13:00:46 +0000
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
Subject: [PATCH v2 08/12] mm: Remove nr_entries parameter from pagevec_lookup_entries
Date:   Mon, 14 Sep 2020 14:00:38 +0100
Message-Id: <20200914130042.11442-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200914130042.11442-1-willy@infradead.org>
References: <20200914130042.11442-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers want to fetch the full size of the pvec.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagevec.h | 2 +-
 mm/swap.c               | 4 ++--
 mm/truncate.c           | 5 ++---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 4b245592262c..ce77724a2ab7 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -27,7 +27,7 @@ void __pagevec_release(struct pagevec *pvec);
 void __pagevec_lru_add(struct pagevec *pvec);
 unsigned pagevec_lookup_entries(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t start, pgoff_t end,
-		unsigned nr_entries, pgoff_t *indices);
+		pgoff_t *indices);
 void pagevec_remove_exceptionals(struct pagevec *pvec);
 unsigned pagevec_lookup_range(struct pagevec *pvec,
 			      struct address_space *mapping,
diff --git a/mm/swap.c b/mm/swap.c
index b6e56a84b466..d4e3ba4c967c 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1058,9 +1058,9 @@ void __pagevec_lru_add(struct pagevec *pvec)
  */
 unsigned pagevec_lookup_entries(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t start, pgoff_t end,
-		unsigned nr_entries, pgoff_t *indices)
+		pgoff_t *indices)
 {
-	pvec->nr = find_get_entries(mapping, start, end, nr_entries,
+	pvec->nr = find_get_entries(mapping, start, end, PAGEVEC_SIZE,
 				    pvec->pages, indices);
 	return pagevec_count(pvec);
 }
diff --git a/mm/truncate.c b/mm/truncate.c
index 69ea72e7fc1c..bbd0a02eaed7 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -377,7 +377,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	for ( ; ; ) {
 		cond_resched();
 		if (!pagevec_lookup_entries(&pvec, mapping, index, end - 1,
-				PAGEVEC_SIZE, indices)) {
+				indices)) {
 			/* If all gone from start onwards, we're done */
 			if (index == start)
 				break;
@@ -611,8 +611,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 
 	pagevec_init(&pvec);
 	index = start;
-	while (pagevec_lookup_entries(&pvec, mapping, index, end,
-			PAGEVEC_SIZE, indices)) {
+	while (pagevec_lookup_entries(&pvec, mapping, index, end, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
-- 
2.28.0

