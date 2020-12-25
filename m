Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C1E2E2B13
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 11:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbgLYKCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 05:02:45 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:44747 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727442AbgLYKCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 05:02:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UJjFIVO_1608890514;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UJjFIVO_1608890514)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Dec 2020 18:01:56 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     willy@infradead.org
Cc:     tim.c.chen@linux.intel.com,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] mm/swap.c: extend the usage to pagevec_lru_add
Date:   Fri, 25 Dec 2020 17:59:49 +0800
Message-Id: <1608890390-64305-4-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1608890390-64305-1-git-send-email-alex.shi@linux.alibaba.com>
References: <20201126155553.GT4327@casper.infradead.org>
 <1608890390-64305-1-git-send-email-alex.shi@linux.alibaba.com>
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
 mm/swap.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index bb5300b7e321..9a2269e5099b 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -12,6 +12,7 @@
  * Started 18.12.91
  * Swap aging added 23.2.95, Stephen Tweedie.
  * Buffermem limits added 12.3.98, Rik van Riel.
+ * Pre-sort pagevec added 12.1.20, Alex Shi.
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
@@ -242,7 +243,7 @@ void sort_isopv(struct pagevec *pvec, struct pagevec *isopv,
 		pvec->pages[i] = NULL;
 
 		/* block memcg migration during page moving between lru */
-		if (!TestClearPageLRU(page)) {
+		if (clearlru && !TestClearPageLRU(page)) {
 			pagevec_add(&busypv, page);
 			continue;
 		}
@@ -266,9 +267,13 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 	unsigned long flags = 0;
 	unsigned long lvaddr[PAGEVEC_SIZE];
 	struct pagevec sortedpv;
+	bool clearlru;
+
+	/* don't clear lru bit for new page adding to lru */
+	clearlru = pvec != this_cpu_ptr(&lru_pvecs.lru_add);
 
 	pagevec_init(&sortedpv);
-	sort_isopv(pvec, &sortedpv, lvaddr);
+	sort_isopv(pvec, &sortedpv, lvaddr, clearlru);
 
 	n = pagevec_count(&sortedpv);
 	if (!n)
@@ -287,7 +292,8 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 
 		(*move_fn)(sortedpv.pages[i], lruvec);
 
-		SetPageLRU(sortedpv.pages[i]);
+		if (clearlru)
+			SetPageLRU(sortedpv.pages[i]);
 	}
 	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
 	release_pages(sortedpv.pages, sortedpv.nr);
@@ -1111,20 +1117,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
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

