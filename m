Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B512BA49C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 09:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgKTI1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 03:27:35 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:52291 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726123AbgKTI1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:27:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UFyQvrT_1605860851;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFyQvrT_1605860851)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 20 Nov 2020 16:27:31 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH next] mm/swap.c: reduce lock contention in lru_cache_add
Date:   Fri, 20 Nov 2020 16:27:27 +0800
Message-Id: <1605860847-47445-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current relock logical will change lru_lock when found a new
lruvec, so if 2 memcgs are reading file or alloc page at same time,
they could hold the lru_lock alternately, and wait for each other for
fairness attribute of ticket spin lock.

This patch will sort that all lru_locks and only hold them once in
above scenario. That could reduce fairness waiting for lock reget.
Than, vm-scalability/case-lru-file-readtwice could get ~5% performance
gain on my 2P*20core*HT machine.

Suggested-by: Konstantin Khlebnikov <koct9i@gmail.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/swap.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 490553f3f9ef..c787b38bf9c0 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1009,24 +1009,65 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
 	trace_mm_lru_insertion(page, lru);
 }
 
+struct lruvecs {
+	struct list_head lists[PAGEVEC_SIZE];
+	struct lruvec *vecs[PAGEVEC_SIZE];
+};
+
+/* Sort pvec pages on their lruvec */
+int sort_page_lruvec(struct lruvecs *lruvecs, struct pagevec *pvec)
+{
+	int i, j, nr_lruvec;
+	struct page *page;
+	struct lruvec *lruvec = NULL;
+
+	lruvecs->vecs[0] = NULL;
+	for (i = nr_lruvec = 0; i < pagevec_count(pvec); i++) {
+		page = pvec->pages[i];
+		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+
+		/* Try to find a same lruvec */
+		for (j = 0; j <= nr_lruvec; j++)
+			if (lruvec == lruvecs->vecs[j])
+				break;
+
+		/* A new lruvec */
+		if (j > nr_lruvec) {
+			INIT_LIST_HEAD(&lruvecs->lists[nr_lruvec]);
+			lruvecs->vecs[nr_lruvec] = lruvec;
+			j = nr_lruvec++;
+			lruvecs->vecs[nr_lruvec] = 0;
+		}
+
+		list_add_tail(&page->lru, &lruvecs->lists[j]);
+	}
+
+	return nr_lruvec;
+}
+
 /*
  * Add the passed pages to the LRU, then drop the caller's refcount
  * on them.  Reinitialises the caller's pagevec.
  */
 void __pagevec_lru_add(struct pagevec *pvec)
 {
-	int i;
-	struct lruvec *lruvec = NULL;
+	int i, nr_lruvec;
 	unsigned long flags = 0;
+	struct page *page;
+	struct lruvecs lruvecs;
 
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
+	nr_lruvec = sort_page_lruvec(&lruvecs, pvec);
 
-		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
-		__pagevec_lru_add_fn(page, lruvec);
+	for (i = 0; i < nr_lruvec; i++) {
+		spin_lock_irqsave(&lruvecs.vecs[i]->lru_lock, flags);
+		while (!list_empty(&lruvecs.lists[i])) {
+			page = lru_to_page(&lruvecs.lists[i]);
+			list_del(&page->lru);
+			__pagevec_lru_add_fn(page, lruvecs.vecs[i]);
+		}
+		spin_unlock_irqrestore(&lruvecs.vecs[i]->lru_lock, flags);
 	}
-	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
+
 	release_pages(pvec->pages, pvec->nr);
 	pagevec_reinit(pvec);
 }
-- 
2.29.GIT

