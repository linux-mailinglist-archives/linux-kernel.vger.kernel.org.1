Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788E42C98C3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgLAIDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:03:04 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:40194 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbgLAIDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:03:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UH73k16_1606809738;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UH73k16_1606809738)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Dec 2020 16:02:18 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     vbabka@suse.cz, alex.shi@linux.alibaba.com
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm/swap.c: pre-sort pages in pagevec for pagevec_lru_move_fn
Date:   Tue,  1 Dec 2020 16:02:13 +0800
Message-Id: <1606809735-43300-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20201126155553.GT4327@casper.infradead.org>
References: <20201126155553.GT4327@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pages in pagevec may have different lruvec, so we have to do relock in
function pagevec_lru_move_fn(), but a relock may cause current cpu wait
for long time on the same lock for spinlock fairness reason.

Before per memcg lru_lock, we have to bear the relock since the spinlock
is the only way to serialize page's memcg/lruvec. Now TestClearPageLRU
could be used to isolate pages exculsively, and stable the page's
lruvec/memcg. So it gives us a chance to sort the page's lruvec before
moving action in pagevec_lru_move_fn. Then we don't suffer from the
spinlock's fairness wait.

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
 mm/swap.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 79 insertions(+), 13 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 490553f3f9ef..17d8990e5ca7 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -201,29 +201,95 @@ int get_kernel_page(unsigned long start, int write, struct page **pages)
 }
 EXPORT_SYMBOL_GPL(get_kernel_page);
 
+/* Pratt's gaps for shell sort, https://en.wikipedia.org/wiki/Shellsort */
+static int gaps[] = { 6, 4, 3, 2, 1, 0};
+
+/* Shell sort pagevec[] on page's lruvec.*/
+static void shell_sort(struct pagevec *pvec, unsigned long *lvaddr)
+{
+	int g, i, j, n = pagevec_count(pvec);
+
+	for (g=0; gaps[g] > 0 && gaps[g] <= n/2; g++) {
+		int gap = gaps[g];
+
+		for (i = gap; i < n; i++) {
+			unsigned long tmp = lvaddr[i];
+			struct page *page = pvec->pages[i];
+
+			for (j = i - gap; j >= 0 && lvaddr[j] > tmp; j -= gap) {
+				lvaddr[j + gap] = lvaddr[j];
+				pvec->pages[j + gap] = pvec->pages[j];
+			}
+			lvaddr[j + gap] = tmp;
+			pvec->pages[j + gap] = page;
+		}
+	}
+}
+
+/* Get lru bit cleared page and their lruvec address, release the others */
+void sort_isopv(struct pagevec *pvec, struct pagevec *isopv,
+		unsigned long *lvaddr)
+{
+	int i, j;
+	struct pagevec busypv;
+
+	pagevec_init(&busypv);
+
+	for (i = 0, j = 0; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+
+		pvec->pages[i] = NULL;
+
+		/* block memcg migration during page moving between lru */
+		if (!TestClearPageLRU(page)) {
+			pagevec_add(&busypv, page);
+			continue;
+		}
+		lvaddr[j++] = (unsigned long)
+				mem_cgroup_page_lruvec(page, page_pgdat(page));
+		pagevec_add(isopv, page);
+	}
+	pagevec_reinit(pvec);
+	if (pagevec_count(&busypv))
+		release_pages(busypv.pages, busypv.nr);
+
+	shell_sort(isopv, lvaddr);
+}
+
 static void pagevec_lru_move_fn(struct pagevec *pvec,
 	void (*move_fn)(struct page *page, struct lruvec *lruvec))
 {
-	int i;
+	int i, n;
 	struct lruvec *lruvec = NULL;
 	unsigned long flags = 0;
+	unsigned long lvaddr[PAGEVEC_SIZE];
+	struct pagevec isopv;
 
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
+	pagevec_init(&isopv);
 
-		/* block memcg migration during page moving between lru */
-		if (!TestClearPageLRU(page))
-			continue;
+	sort_isopv(pvec, &isopv, lvaddr);
 
-		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
-		(*move_fn)(page, lruvec);
+	n = pagevec_count(&isopv);
+	if (!n)
+		return;
 
-		SetPageLRU(page);
+	lruvec = (struct lruvec *)lvaddr[0];
+	spin_lock_irqsave(&lruvec->lru_lock, flags);
+
+	for (i = 0; i < n; i++) {
+		/* lock new lruvec if lruvec changes, we have sorted them */
+		if (lruvec != (struct lruvec *)lvaddr[i]) {
+			spin_unlock_irqrestore(&lruvec->lru_lock, flags);
+			lruvec = (struct lruvec *)lvaddr[i];
+			spin_lock_irqsave(&lruvec->lru_lock, flags);
+		}
+
+		(*move_fn)(isopv.pages[i], lruvec);
+
+		SetPageLRU(isopv.pages[i]);
 	}
-	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
-	release_pages(pvec->pages, pvec->nr);
-	pagevec_reinit(pvec);
+	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
+	release_pages(isopv.pages, isopv.nr);
 }
 
 static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
-- 
2.29.GIT

