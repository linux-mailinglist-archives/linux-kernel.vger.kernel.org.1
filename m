Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B782E2B11
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 11:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgLYKCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 05:02:41 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:44328 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727161AbgLYKCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 05:02:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UJjFIVO_1608890514;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UJjFIVO_1608890514)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Dec 2020 18:01:55 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     willy@infradead.org
Cc:     tim.c.chen@linux.intel.com,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] mm/swap.c: bail out early for no memcg and no numa
Date:   Fri, 25 Dec 2020 17:59:48 +0800
Message-Id: <1608890390-64305-3-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1608890390-64305-1-git-send-email-alex.shi@linux.alibaba.com>
References: <20201126155553.GT4327@casper.infradead.org>
 <1608890390-64305-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a system has memcg disabled and no numa node, like a embedded system,
there is no needs to do the pagevec sort, since only just one lruvec in
system. In this situation, we could skip the pagevec sorting.

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
 mm/swap.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 994641331bf7..bb5300b7e321 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -235,6 +235,7 @@ void sort_isopv(struct pagevec *pvec, struct pagevec *isopv,
 
 	pagevec_init(&busypv);
 
+
 	for (i = 0, j = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
 
@@ -253,7 +254,8 @@ void sort_isopv(struct pagevec *pvec, struct pagevec *isopv,
 	if (pagevec_count(&busypv))
 		release_pages(busypv.pages, busypv.nr);
 
-	shell_sort(isopv, lvaddr);
+	if (!mem_cgroup_disabled() || num_online_nodes() > 1)
+		shell_sort(isopv, lvaddr);
 }
 
 static void pagevec_lru_move_fn(struct pagevec *pvec,
@@ -263,13 +265,12 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 	struct lruvec *lruvec = NULL;
 	unsigned long flags = 0;
 	unsigned long lvaddr[PAGEVEC_SIZE];
-	struct pagevec isopv;
-
-	pagevec_init(&isopv);
+	struct pagevec sortedpv;
 
-	sort_isopv(pvec, &isopv, lvaddr);
+	pagevec_init(&sortedpv);
+	sort_isopv(pvec, &sortedpv, lvaddr);
 
-	n = pagevec_count(&isopv);
+	n = pagevec_count(&sortedpv);
 	if (!n)
 		return;
 
@@ -284,12 +285,12 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 			spin_lock_irqsave(&lruvec->lru_lock, flags);
 		}
 
-		(*move_fn)(isopv.pages[i], lruvec);
+		(*move_fn)(sortedpv.pages[i], lruvec);
 
-		SetPageLRU(isopv.pages[i]);
+		SetPageLRU(sortedpv.pages[i]);
 	}
 	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
-	release_pages(isopv.pages, isopv.nr);
+	release_pages(sortedpv.pages, sortedpv.nr);
 }
 
 static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
-- 
2.29.GIT

