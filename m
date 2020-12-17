Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38542DCC80
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 07:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgLQG3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 01:29:48 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:10569 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726862AbgLQG3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 01:29:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UItliQ7_1608186540;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UItliQ7_1608186540)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Dec 2020 14:29:01 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm/compaction: remove rcu_read_lock during page compaction
Date:   Thu, 17 Dec 2020 14:28:52 +0800
Message-Id: <1608186532-81218-3-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1608186532-81218-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1608186532-81218-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_read_lock was used to guard memcg destory, now TestClearPageLRU
could block this happen, so we don't need it. Remove it to reduce
locking load in debugging mode.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/compaction.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 8049d3530812..02af220fb992 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -995,7 +995,6 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (!TestClearPageLRU(page))
 			goto isolate_fail_put;
 
-		rcu_read_lock();
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
 		/* If we already hold the lock, we can skip some rechecking */
@@ -1005,7 +1004,6 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
 			locked = lruvec;
-			rcu_read_unlock();
 
 			lruvec_memcg_debug(lruvec, page);
 
@@ -1026,8 +1024,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 				SetPageLRU(page);
 				goto isolate_fail_put;
 			}
-		} else
-			rcu_read_unlock();
+		}
 
 		/* The whole page is taken off the LRU; skip the tail pages. */
 		if (PageCompound(page))
-- 
2.29.GIT

