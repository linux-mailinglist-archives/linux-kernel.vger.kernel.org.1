Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612352C98C7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgLAIEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:04:01 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:48243 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbgLAIEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:04:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UH73k16_1606809738;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UH73k16_1606809738)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Dec 2020 16:02:19 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     vbabka@suse.cz, alex.shi@linux.alibaba.com
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm/swap.c: extend the usage to pagevec_lru_add
Date:   Tue,  1 Dec 2020 16:02:15 +0800
Message-Id: <1606809735-43300-3-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1606809735-43300-1-git-send-email-alex.shi@linux.alibaba.com>
References: <20201126155553.GT4327@casper.infradead.org>
 <1606809735-43300-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only different for __pagevec_lru_add and other page moving between
lru lists is page to add lru list has no need to do TestClearPageLRU and
set the lru bit back. So we could combound them with a clear lru bit
switch in sort function parameter.

Than all lru list operation functions could be united.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/swap.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 814809845700..6a7920b2937f 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -12,6 +12,7 @@
  * Started 18.12.91
  * Swap aging added 23.2.95, Stephen Tweedie.
  * Buffermem limits added 12.3.98, Rik van Riel.
+ * Pre-sort pagevec added 1.12.20, Alex Shi.
  */
 
 #include <linux/mm.h>
@@ -227,8 +228,8 @@ static void shell_sort(struct pagevec *pvec, unsigned long *lvaddr)
 }
 
 /* Get lru bit cleared page and their lruvec address, release the others */
-void sort_isopv(struct pagevec *pvec, struct pagevec *isopv,
-		unsigned long *lvaddr)
+static void sort_isopv(struct pagevec *pvec, struct pagevec *isopv,
+		unsigned long *lvaddr, bool clearlru)
 {
 	int i, j;
 	struct pagevec busypv;
@@ -241,7 +242,7 @@ void sort_isopv(struct pagevec *pvec, struct pagevec *isopv,
 		pvec->pages[i] = NULL;
 
 		/* block memcg migration during page moving between lru */
-		if (!TestClearPageLRU(page)) {
+		if (clearlru && !TestClearPageLRU(page)) {
 			pagevec_add(&busypv, page);
 			continue;
 		}
@@ -265,10 +266,13 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 	unsigned long lvaddr[PAGEVEC_SIZE];
 	struct pagevec isopv;
 	struct pagevec *pv;
+	bool clearlru;
+
+	clearlru = pvec != this_cpu_ptr(&lru_pvecs.lru_add);
 
 	if (!mem_cgroup_disabled() || num_online_nodes() > 1) {
 		pagevec_init(&isopv);
-		sort_isopv(pvec, &isopv, lvaddr);
+		sort_isopv(pvec, &isopv, lvaddr, clearlru);
 		pv = &isopv;
 	} else {
 		pv = pvec;
@@ -291,7 +295,8 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 
 		(*move_fn)(pv->pages[i], lruvec);
 
-		SetPageLRU(pv->pages[i]);
+		if (clearlru)
+			SetPageLRU(pv->pages[i]);
 	}
 	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
 	release_pages(pv->pages, pv->nr);
@@ -1086,20 +1091,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
  */
 void __pagevec_lru_add(struct pagevec *pvec)
 {
-	int i;
-	struct lruvec *lruvec = NULL;
-	unsigned long flags = 0;
-
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
-
-		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
-		__pagevec_lru_add_fn(page, lruvec);
-	}
-	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
-	release_pages(pvec->pages, pvec->nr);
-	pagevec_reinit(pvec);
+	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn);
 }
 
 /**
-- 
2.29.GIT

