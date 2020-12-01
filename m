Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0942C98C4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgLAIDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:03:04 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:47527 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbgLAIDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:03:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UH73k16_1606809738;
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
Subject: [PATCH 2/3] mm/swap.c: bail out early for no memcg and no numa
Date:   Tue,  1 Dec 2020 16:02:14 +0800
Message-Id: <1606809735-43300-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1606809735-43300-1-git-send-email-alex.shi@linux.alibaba.com>
References: <20201126155553.GT4327@casper.infradead.org>
 <1606809735-43300-1-git-send-email-alex.shi@linux.alibaba.com>
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
 mm/swap.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 17d8990e5ca7..814809845700 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -264,12 +264,17 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 	unsigned long flags = 0;
 	unsigned long lvaddr[PAGEVEC_SIZE];
 	struct pagevec isopv;
+	struct pagevec *pv;
 
-	pagevec_init(&isopv);
-
-	sort_isopv(pvec, &isopv, lvaddr);
+	if (!mem_cgroup_disabled() || num_online_nodes() > 1) {
+		pagevec_init(&isopv);
+		sort_isopv(pvec, &isopv, lvaddr);
+		pv = &isopv;
+	} else {
+		pv = pvec;
+	}
 
-	n = pagevec_count(&isopv);
+	n = pagevec_count(pv);
 	if (!n)
 		return;
 
@@ -284,12 +289,12 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 			spin_lock_irqsave(&lruvec->lru_lock, flags);
 		}
 
-		(*move_fn)(isopv.pages[i], lruvec);
+		(*move_fn)(pv->pages[i], lruvec);
 
-		SetPageLRU(isopv.pages[i]);
+		SetPageLRU(pv->pages[i]);
 	}
 	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
-	release_pages(isopv.pages, isopv.nr);
+	release_pages(pv->pages, pv->nr);
 }
 
 static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
-- 
2.29.GIT

