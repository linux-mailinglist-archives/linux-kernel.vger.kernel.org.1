Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08A02E059A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 06:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgLVFWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 00:22:02 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:50236 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbgLVFWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 00:22:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UJPqUQy_1608614460;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UJPqUQy_1608614460)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Dec 2020 13:21:00 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     hughd@google.com
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] mm/compaction: remove rcu_read_lock during page compaction
Date:   Tue, 22 Dec 2020 13:20:53 +0800
Message-Id: <1608614453-10739-3-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1608614453-10739-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1608614453-10739-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

isolate_migratepages_block() used rcu_read_lock() with the intention
of safeguarding against the mem_cgroup being destroyed concurrently;
but its TestClearPageLRU already protects against that.  Delete the
unnecessary rcu_read_lock() and _unlock().

Hugh Dickin' helped on commit log polishing, Thanks!

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Acked-by: Hugh Dickins <hughd@google.com>
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

